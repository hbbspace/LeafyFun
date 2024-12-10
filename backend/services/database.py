import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# Engine untuk koneksi ke database
ENV_PATH = os.path.join(os.path.dirname(__file__), "../../assets/.env")
load_dotenv(ENV_PATH)
DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(DATABASE_URL, pool_pre_ping=True)

# Konfigurasi session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Deklarasi Base untuk model
Base = declarative_base()

# Dependency untuk sesi database
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()