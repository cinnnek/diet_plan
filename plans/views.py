from django.shortcuts import render

from django.shortcuts import render, get_object_or_404
from .models import Plan, Posilek, SkladPosilku
import json

def home(request):
    return render(request, 'plans/home.html')

def plan_list(request):
    plans = Plan.objects.all()
    # Tworzymy słownik, w którym kluczem jest plan, a wartością lista posiłków
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
    selected_meals = Posilek.objects.filter(id_posilku__in=meal_ids)

    # Pobierz składniki dla każdego posiłku
    meals_with_ingredients = []
    for meal in selected_meals:
        skladniki = SkladPosilku.objects.filter(id_posilku=meal)
        meals_with_ingredients.append({
            'meal': meal,
            'skladniki': skladniki
        })

    context = {
        'meals_with_ingredients': meals_with_ingredients
    }
    return render(request, 'plans/custom_plan_detail.html', context)