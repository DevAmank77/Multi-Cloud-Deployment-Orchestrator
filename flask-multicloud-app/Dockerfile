FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

ENV CLOUD_NAME="Generic Cloud"

CMD ["python", "app.py"]
