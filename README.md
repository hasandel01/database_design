# Database Setup

This database is created and regulated in MySQL. To work with the database, firstly, you should use MySQL command or Workbench. 

First, upload and load the scripts: tables, triggers, views, first insertions, and second insertions to build the database. These are located in the `SQL Scripts` folder.

## Django

Later, the Django project is settled, but you should still configure the database settings. There is a folder named `ecommercedb`, it is the project file for Django, and `website ` stands for the app. Go there and configure the `settings.py` file for your database.

### Steps to Run

1. Configure Database and make sure you configured settings.py as you need

2. In the directory run the following command to start Django application:
    ```
    python manage.py runserver
    ```
