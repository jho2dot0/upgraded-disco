# App Directory

This directory contains the core application files for the Upgraded Disco project. It includes a simple Flask application, its dependencies, and a Dockerfile for containerization.

## Contents

1. `app.py`: The main Python script containing the Flask application.
2. `Dockerfile`: Instructions for building the Docker image of the application.
3. `requirements.txt`: A list of Python packages required by the application.

## app.py

This is a basic Flask application that serves a "Hello, World!" message. Here's a breakdown of its functionality:

- It creates a Flask application instance.
- Defines a route for the root URL ("/") that returns "Hello, World!".
- If run directly (not imported as a module), it starts the Flask development server, binding to all network interfaces (0.0.0.0) on port 5000.

## Dockerfile

The Dockerfile uses a Python Alpine base image and sets up the environment for running the Flask application. Key steps include:

1. Setting the working directory to `/app`.
2. Copying and installing the Python dependencies.
3. Copying the application file.
4. Exposing port 5000.
5. Using Gunicorn as the WSGI HTTP server to run the Flask application.

## requirements.txt

This file lists the Python packages required by the application:

- Flask 3.0.3: A micro web framework for Python.
- Gunicorn 23.0.0: A Python WSGI HTTP Server for UNIX.

## Running the Application Locally

To run the application locally:

1. Ensure you have Python and pip installed.
2. Install the required packages:
   ```
   pip install -r requirements.txt
   ```
3. Run the Flask application:
   ```
   python app.py
   ```
4. Access the application at `http://localhost:5000`.

## Building and Running with Docker

To build and run the application using Docker:

1. Build the Docker image:
   ```
   docker build -t upgraded-disco-app .
   ```
2. Run the container:
   ```
   docker run -p 5000:5000 upgraded-disco-app
   ```
3. Access the application at `http://localhost:5000`.

Note: The Dockerfile uses Gunicorn instead of the Flask development server, which is more suitable for production environments.
