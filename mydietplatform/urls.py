"""
URL configuration for mydietplatform project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from plans import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home, name='home'),
    path('plan_list/', views.plan_list, name='plan_list'),
    path('kalkulator/', views.kalkulator, name='kalkulator'),
    path('plan_detail/<int:id_plan>/', views.plan_detail, name='plan_detail'),
    path('create_plan/', views.create_plan, name='create_plan'),
    path('custom_plan_detail/', views.custom_plan_detail, name='custom_plan_detail'),
    path('edit_plan/<int:id_plan>/', views.edit_plan, name='edit_plan'),
    path('plan_detail/<int:id_plan>/download_pdf/', views.generate_pdf, name='download_pdf'),
    path('custom_plan_detail/download_pdf/', views.generate_pdf, name='download_custom_pdf'),
    path('products/', views.products_view, name='products'),
]
