# Database Setup

This database is created and regulated in MySQL. To work with the database, firstly, you should use MySQL command or Workbench. 

First, upload and load the scripts: tables, triggers, views, first insertions, and second insertions to build the database. These are located in the `SQL Files` folder.

## Python Virtual Environment

Later, the Python virtual environment is settled, but you should still configure the database settings. In the `ecommercedb` directory, there is a folder named `ecommercedb`. Go there and configure the `settings.py` file for your database.

### Steps to Run

1. Activate the virtual environment:
    ```
    .venv\Scripts\activate
    ```

2. Navigate to the subdirectory `ecommercedb` and run the following command:
    ```
    python manage.py runserver
    ```
