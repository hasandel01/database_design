from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    path('product_list/', views.product_list, name='product_list'),
    path('order_customer_join/', views.order_customer_join, name='order_customer_join'),
    path('product_category_view/', views.product_category_view, name='product_category_view'),
    path('add_review/<int:product_id>/', views.add_review, name='add_review'),
    path('product_reviews/<int:product_id>/', views.product_reviews, name='product_reviews'),
    path('add_an_employee/', views.add_an_employee, name='add_an_employee'),
    path('login/', views.login_view, name='login'),
]