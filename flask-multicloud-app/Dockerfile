FROM python:3.12-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application code and templates
COPY app.py .
COPY templates/ templates/

# Run the Flask app
ENV FLASK_APP=app.py
CMD ["flask", "run", "--host=0.0.0.0", "--port=8000"]
