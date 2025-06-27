# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY ./app ./app

# Create a non-root user and switch to it
RUN useradd --create-home appuser
USER appuser

# Set environment variables
ENV RESPONSE="it works!"

# Expose port 8000
EXPOSE 8000

# Run the app with uvicorn as the non-root user
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]