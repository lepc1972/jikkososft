# Etapa 1: Construcción
FROM python:3.10-slim as builder

# Definir variables para cacheo eficiente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Copiar dependencias
COPY app/requirements.txt .

# Instalar dependencias en un entorno aislado
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# Etapa 2: Imagen final optimizada
FROM python:3.10-slim

WORKDIR /app

# Copiar dependencias desde la etapa de construcción
COPY --from=builder /install /usr/local

# Copiar el código fuente
COPY app/ .

# Comando por defecto para ejecutar la aplicación
CMD ["python", "app.py"]
