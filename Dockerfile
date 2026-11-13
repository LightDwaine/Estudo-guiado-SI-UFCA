# Usa uma imagem oficial e mais recente do Python
FROM python:3.12-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Atualiza pacotes do sistema operacional para corrigir CVEs de OS (ex: openssl, zlib)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Atualiza ferramentas base do Python (pip, setuptools, wheel) para eliminar CVEs internas
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Copia apenas o arquivo de dependências primeiro (otimização de cache do Docker)
COPY requirements.txt .

# Instala as dependências da aplicação
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação para dentro do contêiner
COPY . .

# Define variável de ambiente para o Flask escutar em todas as interfaces dentro do contêiner
ENV FLASK_HOST=0.0.0.0

# Expõe a porta 5000 para o mundo exterior
EXPOSE 5000

# Comando para rodar a aplicação quando o contêiner iniciar
CMD ["python", "app.py"]