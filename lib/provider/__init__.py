from lib.services.database import SessionLocal
from .data_initializer import initialize_data

def setup_provider():
    db = SessionLocal()
    try:
        initialize_data(db)
    finally:
        db.close()