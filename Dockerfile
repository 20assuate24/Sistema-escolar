# 1. Use uma imagem Python oficial e leve como base.
# A tag 'slim' é um bom equilíbrio entre tamanho e compatibilidade. Corrigindo o nome da imagem.
FROM python:3.13.4-alpine3.22

# Evita que o Python escreva arquivos .pyc no disco
ENV PYTHONDONTWRITEBYTECODE 1
# Garante que a saída do Python seja exibida imediatamente
ENV PYTHONUNBUFFERED 1

# 2. Defina o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copie o arquivo de dependências primeiro para aproveitar o cache do Docker.
COPY requirements.txt .

# 4. Instale as dependências.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# 5. Copie o restante do código da aplicação.
COPY . .

# 6. Exponha a porta em que o Uvicorn será executado.
EXPOSE 8000

# 7. Comando para iniciar a aplicação.
# O host '0.0.0.0' é necessário para que a aplicação seja acessível de fora do contêiner.
# O comando de produção não deve ter --reload. Isso é adicionado no docker-compose para desenvolvimento.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
