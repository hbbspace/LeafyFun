from sqlalchemy.orm import Session
from lib.models.user import User
from lib.models.plant import Plant
from passlib.context import CryptContext

# Context untuk hashing password
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Fungsi untuk hash password
def hash_password(password: str) -> str:
    return pwd_context.hash(password)

# Fungsi untuk inisialisasi data awal
def initialize_data(db: Session):
    try:
        # Tambahkan data awal User jika belum ada
        if not db.query(User).first():
            users = [
                User(username="admin", email="admin@example.com", password=hash_password("admin123")),
                User(username="john_doe", email="john@example.com", password=hash_password("password123")),
            ]
            db.add_all(users)

        # Tambahkan data awal Plant jika belum ada
        if not db.query(Plant).first():
            plants = [
                Plant(name="Apple Tree"),
                Plant(name="Mango Tree"),
                Plant(name="Pine Tree"),
            ]
            db.add_all(plants)

        db.commit()
        print("Initial data successfully added.")
    except Exception as e:
        print(f"Error initializing data: {e}")
