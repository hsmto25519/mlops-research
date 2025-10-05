# Dockerfile

# 1. Use an official Python runtime as a parent image
FROM python:3.11-slim

# 2. Set the working directory in the container
WORKDIR /code

# 3. Copy just the requirements file and install dependencies
# This leverages Docker's layer caching
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 4. Copy the app code and the trained model
COPY ./app /code/app
COPY ./models /code/models

# 5. Expose the port the app runs on
EXPOSE 8000

# 6. Command to run the uvicorn server
# The host 0.0.0.0 makes it accessible from outside the container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]