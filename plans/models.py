from django.db import models
from django.utils import timezone

class User(models.Model):
    id_user = models.AutoField(primary_key=True)
    imie = models.CharField(max_length=50, null=True)
    username = models.CharField(max_length=50, unique=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)
    age = models.IntegerField(null=True)
    weight = models.DecimalField(max_digits=5, decimal_places=2, null=True)
    height = models.DecimalField(max_digits=5, decimal_places=2, null=True)
    activity_level = models.CharField(max_length=50, null=True)

    def __str__(self):
        return self.username

class Plan(models.Model):
    id_plan = models.AutoField(primary_key=True)
    nazwa = models.CharField(max_length=100)
    ile_kalorii = models.IntegerField(null=True)
    description = models.TextField(null=True)

    def __str__(self):
        return self.nazwa
    def get_image_url(self):
        # Generowanie URL obrazu na podstawie ID planu
        return f"/static/img/plan_{self.id_plan}.png"

class DietUser(models.Model):
    id = models.AutoField(primary_key=True)
    id_plan = models.ForeignKey(Plan, related_name='dietusers', on_delete=models.CASCADE)
    id_user = models.ForeignKey(User, related_name='dietusers', on_delete=models.CASCADE)
    start_date = models.DateField(default=timezone.now)
    end_date = models.DateField(null=True, blank=True)

class Product(models.Model):
    id_prod = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=100)
    calories_per_100g = models.DecimalField(max_digits=5, decimal_places=2)
    proteins_per_100g = models.DecimalField(max_digits=5, decimal_places=2)
    carbs_per_100g = models.DecimalField(max_digits=5, decimal_places=2)
    fats_per_100g = models.DecimalField(max_digits=5, decimal_places=2)

    def __str__(self):
        return self.product_name

class Posilek(models.Model):
    id_posilku = models.AutoField(primary_key=True)
    nazwa = models.CharField(max_length=100)
    kcal = models.IntegerField(null=True)
    plan_id = models.ForeignKey(Plan, related_name='posilki', on_delete=models.CASCADE)
    type = models.CharField(max_length=50, null=True)
    przepis = models.TextField(null=True)

    def __str__(self):
        return self.nazwa

class SkladPosilku(models.Model):
    id = models.AutoField(primary_key=True)
    id_posilku = models.ForeignKey(Posilek, related_name='skladniki', on_delete=models.CASCADE)
    id_produktu = models.ForeignKey(Product, related_name='sklad_posilki', on_delete=models.CASCADE)
    nazwa_produktu = models.CharField(max_length=100, null=True)
    typ = models.CharField(max_length=20, null=True)
    ilosc = models.DecimalField(max_digits=10, decimal_places=2, null=True)
    jednostka = models.CharField(max_length=10, null=True)

    def __str__(self):
        return f"{self.nazwa_produktu} w ({self.id_posilku.nazwa})"
