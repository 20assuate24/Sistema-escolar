import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Lê a URL do banco de dados da variável de ambiente 'DATABASE_URL'.
# Se não estiver definida, usa um valor padrão (sqlite:///escola.db),
# o que garante a compatibilidade com a execução local fora do Docker.
SQLALCHEMY_DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///escola.db")

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, 
    connect_args={"check_same_thread": False} # Necessário apenas para SQLite
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()