FROM python:3.11-slim-bullseye


ENV FLASK_APP=src.app
ENV FLASK_ENV=development
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8080
ENV OTEL_EXPORTER_OTLP_ENDPOINT=http://0.0.0.0:4317
ENV OTEL_EXPORTER_OTLP_PROTOCOL=grpc
ENV OTEL_EXPORTER_OTLP_INSECURE=true

EXPOSE 8080

WORKDIR /code
COPY . .
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt 

CMD ["opentelemetry-instrument", \
    "--service_name", "flask-app", \
    "flask", "run"]