from django.shortcuts import render, redirect, get_object_or_404
from django.db import connection, transaction
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib import messages
from .models import Order
from .models import Product, Productreview
from MySQLdb import ProgrammingError  # Import ProgrammingError for catching the specific exception


# Create your views here.
def home(request):
    all_orders = Order.objects.all
    return render(request, 'home.html',{'all': all_orders})


def product_list(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT product_id, name, price, description, average_rating
            FROM product
        """)
        products = cursor.fetchall()

    # Transform the results into a list of dictionaries for easier handling in the template
    product_list = [
        {
            'product_id': row[0],
            'name': row[1],
            'price': row[2],
            'description': row[3],
            'average_rating': row[4]
        }
        for row in products
    ]

    return render(request, 'product_list.html', {'products': product_list})


def order_customer_join(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT Customer.name AS customer_name, Customer.email, Customer.phone_number, `Order`.order_id, `Order`.status, `Order`.total_price
            FROM Customer
            LEFT OUTER JOIN `Order` ON Customer.customer_id = `Order`.customer_id;
        """)
        results = cursor.fetchall()

    # Transform the results into a list of dictionaries for easier handling in the template
    orders = [
        {
            'customer_name': row[0],
            'email': row[1],
            'phone_number': row[2],
            'order_id': row[3],
            'status': row[4],
            'total_price': row[5]
        }
        for row in results
    ]

    return render(request, 'order_customer_join.html', {'orders': orders})

def product_category_view(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM ProductsByCategory")
        columns = [col[0] for col in cursor.description]
        products = [dict(zip(columns, row)) for row in cursor.fetchall()]

    categories_with_products = {}

    for product in products:
        category_name = product['category_name']
        if category_name not in categories_with_products:
            categories_with_products[category_name] = []
        categories_with_products[category_name].append(product)

    return render(request, 'product_category_view.html', {'categories_with_products': categories_with_products})


def add_review(request, product_id):
    if request.method == 'POST':
        rating = request.POST['rating']
        comment = request.POST['comment']
        
        with connection.cursor() as cursor:
            # Define your SQL insert query
            sql_query = """
                INSERT INTO productreview (rating, comment, product_id)
                VALUES (%s, %s, %s)
            """
            cursor.execute(sql_query, [rating, comment, product_id])
        
        # Redirect back to the product list page after review insertion
        return redirect('product_list')
    
    # Render the form to add a review
    product = Product.objects.get(product_id=product_id)
    return render(request, 'add_review.html', {'product': product})


def product_reviews(request, product_id):
    # Get the product details
    product = get_object_or_404(Product, product_id=product_id)
    
    # Fetch the reviews for the product
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT rating, comment
            FROM productreview
            WHERE product_id = %s
        """, [product_id])
        reviews = cursor.fetchall()

    # Transform the reviews into a list of dictionaries for easier handling in the template
    reviews_list = [{'rating': row[0], 'comment': row[1]} for row in reviews]

    return render(request, 'product_reviews.html', {'product': product, 'reviews': reviews_list})


def add_an_employee(request):
    if request.method == 'POST':
        employee_name = request.POST['employee_name']
        phone_number = request.POST['phone_number']
        branch_id = request.POST['branch_id']
        delivery_area = request.POST['delivery_area']

        try:
            with transaction.atomic():
                # Start the transaction
                with connection.cursor() as cursor:
                    # Create the employee
                    cursor.execute("""
                        INSERT INTO Employee (name, phone, branch_id) 
                        VALUES (%s, %s, %s)
                    """, [employee_name, phone_number, branch_id])
                    
                    # Get the last inserted employee_id
                    cursor.execute("SELECT LAST_INSERT_ID()")
                    employee_id = cursor.fetchone()[0]

                    # Assign the employee as delivery personnel
                    cursor.execute("""
                        INSERT INTO DeliveryPersonnel (employee_id, delivery_area) 
                        VALUES (%s, %s)
                    """, [employee_id, delivery_area])

            # If no errors, commit the transaction
            return render(request, 'transaction_success.html')

        except Exception as e:
            # If there's an error, rollback the transaction
            transaction.rollback()
            return render(request, 'transaction_error.html', {'error': str(e)})

    return render(request, 'add_an_employee.html')


def authenticate_mysql_user(username, password):
    try:
        with connection.cursor() as cursor:
            # Ensure password is properly quoted with single quotes
            cursor.execute("SELECT 1 FROM mysql.user WHERE user = %s AND authentication_string = PASSWORD(%s)", (username, password))
            row = cursor.fetchone()
            if row:
                return True
            else:
                return False
    except ProgrammingError as e:
        print(f"Error executing SQL query: {e}")
        return False
    

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        if authenticate_mysql_user(username, password):
            # Create a basic user object for demonstration
            user = {
                'username': username,
                'password': password  # Normally, you shouldn't store passwords in plaintext; this is for demonstration only
            }
            # Simulate login by storing user details in session (not recommended for production)
            request.session['user'] = user
            return render(request, 'home.html')
        else:
            messages.error(request, 'Invalid username or password')
            return render(request, 'login.html')

    return render(request, 'login.html')