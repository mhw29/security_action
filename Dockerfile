FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./app /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=gitops_app.settings

# Run Django migrations
#RUN python manage.py migrate

# Collect static files
#RUN python manage.py collectstatic --noinput

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
