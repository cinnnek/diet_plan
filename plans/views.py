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