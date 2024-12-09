from fastapi import APIRouter, HTTPException, Depends, status
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session
from lib.services.database import get_db
from lib.services.utils import verify_password, create_access_token, hash_password, verify_jwt_token
from lib.models.user import User as UserModel
from lib.schemas.user import LoginRequest, LoginResponse, UserCreate, UserRead
from fastapi.security import OAuth2PasswordBearer

router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

@router.get("/validate-token")
async def validate_token(token: str = Depends(oauth2_scheme)):
    payload = verify_jwt_token(token)
    if not payload:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    return {"valid": True, "user_id": payload.get("user_id"), "username": payload.get("sub")}

@router.post("/login")
async def login(email: str, password: str, db: Session = Depends(get_db)):
    user = db.query(UserModel).filter(UserModel.email == email).first()
    if not user or not verify_password(password, user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    access_token = create_access_token(data={"sub": user.email, "user_id": user.user_id, "username": user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@router.post("/register", response_model=UserRead, status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(UserModel).filter(UserModel.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email sudah terdaftar")

    hashed_password = hash_password(user.password)
    new_user = UserModel(
        username=user.username,
        email=user.email,
        password=hashed_password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user