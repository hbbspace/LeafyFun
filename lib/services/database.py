from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# engine = create_engine("mysql+pymysql://root@localhost:3306/leafyfun", pool_pre_ping=True)
engine = create_engine("mysql+pymysql://njczidlb_nioke:nioke8090@109.110.188.73:3306/njczidlb_leafyfun")

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

# Dependency untuk sesi database
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()