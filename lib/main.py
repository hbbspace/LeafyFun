from fastapi import FastAPI, HTTPException, Depends, status, Request
from pydantic import BaseModel
from typing import Annotated
from sqlalchemy.orm import Session
from lib.models import user as UserModel  
from lib.models import plant as PlantModel
from lib.services.database import engine, SessionLocal
from passlib.context import CryptContext  

app = FastAPI()
UserModel.Base.metadata.create_all(bind=engine)

# Pydantic Models
class User(BaseModel):
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
async def create_user(user: User, db: db_dependency):
    try:
        # Check if the user already exists
        db_user = db.query(UserModel).filter(UserModel.email == user.email).first()
        if db_user:
            raise HTTPException(status_code=400, detail="Email already registered")

        # Hash the password before storing it
        hashed_password = hash_password(user.password)

        # Create a new user object for the database
        new_user = UserModel(
            username=user.username,
            email=user.email,
            password=hashed_password  # Store the hashed password
        )

        # Add the new user to the database session and commit
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        return {"message": "User created successfully", "user_id": new_user.id}

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