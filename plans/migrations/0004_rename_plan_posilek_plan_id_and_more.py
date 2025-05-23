# Generated by Django 5.1.2 on 2024-10-27 11:04

import django.db.models.deletion
import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('plans', '0003_rename_produkt_product'),
    ]

    operations = [
        migrations.RenameField(
            model_name='posilek',
            old_name='plan',
            new_name='plan_id',
        ),
        migrations.RenameField(
            model_name='skladposilku',
            old_name='posilek',
            new_name='id_posilku',
        ),
        migrations.RemoveField(
            model_name='plan',
            name='id',
        ),
        migrations.RemoveField(
            model_name='posilek',
            name='id',
        ),
        migrations.RemoveField(
            model_name='product',
            name='id',
        ),
        migrations.RemoveField(
            model_name='skladposilku',
            name='produkt',
        ),
        migrations.RemoveField(
            model_name='user',
            name='id',
        ),
        migrations.AddField(
            model_name='plan',
            name='id_plan',
            field=models.AutoField(default=1, primary_key=True, serialize=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='posilek',
            name='id_posilku',
            field=models.AutoField(default=1, primary_key=True, serialize=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='product',
            name='id_prod',
            field=models.AutoField(default=1, primary_key=True, serialize=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='skladposilku',
            name='id_produktu',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='sklad_posilki', to='plans.product'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='user',
            name='id_user',
            field=models.AutoField(default=1, primary_key=True, serialize=False),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='plan',
            name='description',
            field=models.TextField(null=True),
        ),
        migrations.AlterField(
            model_name='plan',
            name='ile_kalorii',
            field=models.IntegerField(null=True),
        ),
        migrations.AlterField(
            model_name='plan',
            name='nazwa',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='posilek',
            name='kcal',
            field=models.IntegerField(null=True),
        ),
        migrations.AlterField(
            model_name='posilek',
            name='nazwa',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='posilek',
            name='przepis',
            field=models.TextField(null=True),
        ),
        migrations.AlterField(
            model_name='posilek',
            name='type',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='product',
            name='calories_per_100g',
            field=models.DecimalField(decimal_places=2, max_digits=5),
        ),
        migrations.AlterField(
            model_name='product',
            name='carbs_per_100g',
            field=models.DecimalField(decimal_places=2, max_digits=5),
        ),
        migrations.AlterField(
            model_name='product',
            name='fats_per_100g',
            field=models.DecimalField(decimal_places=2, max_digits=5),
        ),
        migrations.AlterField(
            model_name='product',
            name='product_name',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='product',
            name='proteins_per_100g',
            field=models.DecimalField(decimal_places=2, max_digits=5),
        ),
        migrations.AlterField(
            model_name='skladposilku',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name='skladposilku',
            name='ilosc',
            field=models.DecimalField(decimal_places=2, max_digits=10, null=True),
        ),
        migrations.AlterField(
            model_name='skladposilku',
            name='jednostka',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='skladposilku',
            name='nazwa_produktu',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='skladposilku',
            name='typ',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='activity_level',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='age',
            field=models.IntegerField(null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='height',
            field=models.DecimalField(decimal_places=2, max_digits=5, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='imie',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='password',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(max_length=50, unique=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='weight',
            field=models.DecimalField(decimal_places=2, max_digits=5, null=True),
        ),
        migrations.CreateModel(
            name='DietUser',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('start_date', models.DateField(default=django.utils.timezone.now)),
                ('end_date', models.DateField(blank=True, null=True)),
                ('id_plan', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dietusers', to='plans.plan')),
                ('id_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dietusers', to='plans.user')),
            ],
        ),
    ]
