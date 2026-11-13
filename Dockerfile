FROM python:3.12-slim

WORKDIR /app

# Atualiza pacotes do sistema operacional
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Remove metadados/pacotes antigos do setuptools (site-packages e ensurepip) e atualiza para >= 78.1.1
RUN find /usr/local/lib/ -name "*setuptools*" -exec rm -rf {} + \
    && pip install --no-cache-dir --upgrade pip "setuptools>=78.1.1" wheel

# Copia apenas o arquivo de dependências primeiro
COPY requirements.txt .

# Instala as dependências da aplicação
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação
COPY . .

ENV FLASK_HOST=0.0.0.0
EXPOSE 5000

CMD ["python", "app.py"]