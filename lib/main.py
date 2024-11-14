# lib/main.py
from fastapi import FastAPI, HTTPException, Depends, status
from pydantic import BaseModel
from typing import Annotated
from sqlalchemy.orm import Session
from lib.models.user import User as UserModel
from lib.services.database import engine, SessionLocal, Base  # Import Base dari database.py
from passlib.context import CryptContext

app = FastAPI()

# Ganti UserModel.Base.metadata.create_all(bind=engine) dengan Base.metadata.create_all(bind=engine)
Base.metadata.create_all(bind=engine)

# Pydantic Models
class UserCreate(BaseModel):
    username: str
    email: str
    password: str

class Plant(BaseModel):
    plant_id: int
    name: str

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Utility function to hash passwords
def hash_password(password: str) -> str:
    return pwd_context.hash(password)

@app.post("/users/", status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate, db: db_dependency):
    try:
        # Cek apakah pengguna sudah ada
        db_user = db.query(UserModel).filter(UserModel.email == user.email).first()
        if db_user:
            raise HTTPException(status_code=400, detail="Email sudah terdaftar")

        # Hash password sebelum disimpan
        hashed_password = hash_password(user.password)

        # Buat objek pengguna baru
        new_user = UserModel(
            username=user.username,
            email=user.email,
            password=hashed_password
        )

        # Tambahkan pengguna baru ke sesi database dan commit
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        return {"message": "User created successfully", "user_id": new_user.user_id}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {str(e)}")

# @app.get("/users/{user_id}", status_code=status.HTTP_200_OK)
# async def read_user(user_id: int, db:db_dependency):
#     user = db.query(User.User).filter(User.User.user_id == user_id).first()
#     if user is None:
#         raise HTTPException(status_code=404, detail='User not Found')
#     return user



# @app.post("/register/")
# def register_user(username: str, password: str, db: Session = Depends(get_db)):
#     hashed_password = auth.get_password_hash(password)
#     db_user = models.User(username=username, hashed_password=hashed_password)
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return {"message": "User registered successfully"}

# @app.post("/login/")
# def login_user(username: str, password: str, db: Session = Depends(get_db)):
#     user = auth.authenticate_user(db, username, password)
#     if not user:
#         raise HTTPException(status_code=400, detail="Incorrect username or password")
#     return {"message": "Login successful"}

# @app.get("/google-login/")
# def google_login():
#     return {"auth_url": auth.google_auth()}