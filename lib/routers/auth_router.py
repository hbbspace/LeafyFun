from fastapi import APIRouter, HTTPException, Depends, status
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session
from lib.services.database import get_db
from lib.services.utils import verify_password, create_access_token, hash_password
from lib.models.user import User as UserModel
from lib.schemas.user import LoginRequest, LoginResponse, UserCreate, UserRead

router = APIRouter()

@router.post("/login", response_model=LoginResponse)
async def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Ambil data user berdasarkan email
    user = db.query(UserModel).filter(UserModel.email == request.email).first()

    # Verifikasi email dan password
    if not user or not verify_password(request.password, user.password):
        raise HTTPException(status_code=401, detail="Invalid email or password")

    # Jika login berhasil, buat token akses (JWT)
    access_token = create_access_token(data={"sub": user.email})

    # Kembalikan response
    return JSONResponse(
        content={
            "token": access_token,
            "message": "Login successful",
        }
    )

@router.post("/register", response_model=UserRead, status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(UserModel).filter(UserModel.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email sudah terdaftar")

    # Hash password before saving
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
