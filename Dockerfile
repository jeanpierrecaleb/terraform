# Use the official Python image from the Docker Hub
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY ./docker/requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY ./docker .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable, not compulsory
# ENV FLASK_APP=app.py

# Run Flask app
## CMD ["flask", "run", "--host=0.0.0.0"]
# CMD ["python", "app.py", "--host=0.0.0.0"]
# Run app.py when the container launches
CMD ["python3", "app.py"]
##CMD ["flask", "run"]