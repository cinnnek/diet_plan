from django.shortcuts import render

from django.shortcuts import render, get_object_or_404
from .models import Plan, Posilek, SkladPosilku
from .models import Product
import json
from django.http import HttpResponse, HttpResponseBadRequest
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
import io
import os
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics
from django.http import JsonResponse
from django.template.loader import render_to_string

def home(request):
    return render(request, 'plans/home.html')

def plan_list(request):
    plans = Plan.objects.all()
    plans_with_meals = [
        {
            'plan': plan,
            'meals': Posilek.objects.filter(plan_id=plan.id_plan)
        }
        for plan in plans
    ]
    return render(request, 'plans/plan_list.html', {'plans_with_meals': plans_with_meals})

def kalkulator(request):
    return render(request, 'plans/kalkulator.html')

def plan_detail(request, id_plan):
    plan = get_object_or_404(Plan, id_plan=id_plan)
    # Pobieramy posiłki dla planu, a składniki są już dostępne poprzez `related_name`
    meals = Posilek.objects.filter(plan_id=plan)

    return render(request, 'plans/plan_detail.html', {'plan': plan, 'meals': meals})

def create_plan(request):
    meals = Posilek.objects.all().values("id_posilku", "nazwa", "kcal")
    meals_json = json.dumps(list(meals))
    return render(request, 'plans/create_plan.html', {
        'meals_json': meals_json
    })
def custom_plan_detail(request):
    # Pobierz wybrane posiłki z GET (z adresu URL)
    meal_ids = request.GET.getlist('meals')
    selected_meals = Posilek.objects.filter(id_posilku__in=meal_ids).values_list('id_posilku', flat=True)

    # Pobierz składniki dla każdego posiłku
    meals_with_ingredients = []
    for meal in Posilek.objects.filter(id_posilku__in=meal_ids):
        skladniki = SkladPosilku.objects.filter(id_posilku=meal)
        meals_with_ingredients.append({
            'meal': meal,
            'skladniki': skladniki
        })

    context = {
        'meals_with_ingredients': meals_with_ingredients,
        'selected_meals': selected_meals  # This should now be a list of IDs
    }
    return render(request, 'plans/custom_plan_detail.html', context)


def edit_plan(request, id_plan):
    # Pobierz plan i posiłki związane z planem
    plan = get_object_or_404(Plan, id_plan=id_plan)
    posilki = Posilek.objects.all().values("id_posilku", "nazwa", "kcal")  # Pobierz wszystkie posiłki

    # Przekonwertuj posiłki i wybrane posiłki na JSON
    meals_json = json.dumps(list(posilki))
    selected_meals = [meal.id_posilku for meal in Posilek.objects.filter(plan_id=plan)]
    selected_meals_json = json.dumps(selected_meals)

    return render(request, 'plans/edit_plan.html', {
        'meals_json': meals_json,
        'selected_meals_json': selected_meals_json,
        'meal_count': len(selected_meals),
    })

def products_view(request):
    search_query = request.GET.get('search', '')
    if search_query:
        products = Product.objects.filter(product_name__icontains=search_query)
    else:
        products = Product.objects.all()
    return render(request, 'plans/products.html', {'products': products, 'search_query': search_query})



def kalkulator(request):
    products = Product.objects.all()
    context = {
        'products': products
    }
    return render(request, 'plans/kalkulator.html', context)

def generate_pdf(request, id_plan=None):

    font_path = os.path.join("plans", "static", "fonts", "Anonymous_Pro.ttf")
    font_path_bold = os.path.join("plans", "static", "fonts", "Anonymous_Pro_B.ttf")
    pdfmetrics.registerFont(TTFont('Anonymous_Pro', font_path))
    pdfmetrics.registerFont(TTFont('Anonymous_Pro_B', font_path_bold))



    custom_meals = request.GET.getlist('meals')

    # Przygotowanie odpowiedzi PDF
    buffer = io.BytesIO()
    pdf = SimpleDocTemplate(buffer, pagesize=A4)
    elements = []

    # Ustawienia stylów tekstu
    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(name='PlanTitle', fontSize=16, leading=20, fontName='Anonymous_Pro_B', spaceAfter=10, alignment=1))
    styles.add(ParagraphStyle(name='SubTitle', fontSize=14, leading=16, fontName='Anonymous_Pro', spaceAfter=8))
    styles.add(ParagraphStyle(name='Content', fontSize=12, leading=14, fontName='Anonymous_Pro'))
    styles.add(ParagraphStyle(name='TableHeader', fontSize=12, leading=14, fontName='Anonymous_Pro', textColor=colors.white,
                       backColor=colors.black))


    # Pobieranie posiłków do PDF
    if id_plan:
        # Generowanie dla standardowego planu
        plan = get_object_or_404(Plan, id_plan=id_plan)
        posilki = Posilek.objects.filter(plan_id=plan)
        elements.append(Paragraph(f"Plan dietetyczny: {plan.nazwa}", styles['PlanTitle']))
    elif custom_meals:
        # Generowanie dla niestandardowego planu
        posilki = Posilek.objects.filter(id_posilku__in=custom_meals)
        elements.append(Paragraph("Własny Plan Dietetyczny", styles['PlanTitle']))
    else:
        return HttpResponseBadRequest("Brak danych do wygenerowania PDF")

    # Przetwarzanie każdego posiłku
    for posilek in posilki:
        # Tytuł posiłku
        elements.append(Paragraph(f"{posilek.nazwa} - {posilek.kcal} kcal", styles['SubTitle']))

        # Przepis
        elements.append(Paragraph(f"Przepis: {posilek.przepis}", styles['Content']))

        # Tabela składników
        skladniki = SkladPosilku.objects.filter(id_posilku=posilek)
        table_data = [["Składnik", "Ilość", "Jednostka"]]
        for skladnik in skladniki:
            table_data.append([skladnik.nazwa_produktu, f"{skladnik.ilosc}", skladnik.jednostka])

        table = Table(table_data, colWidths=[200, 100, 100])
        table.setStyle(TableStyle([
            ('FONTNAME', (0, 0), (-1, 0), 'Anonymous_Pro'),
            ('FONTNAME', (0, 1), (-1, -1), 'Anonymous_Pro'),
            ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
            ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
            ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ]))

        elements.append(table)
        elements.append(Spacer(1, 12))  # Dodanie odstępu między posiłkami

    # Generowanie PDF
    pdf.build(elements)
    buffer.seek(0)

    # Zwrócenie pliku PDF jako odpowiedzi do pobrania
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="plan_dietetyczny.pdf"'
    return response