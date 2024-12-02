from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session
from lib.services.database import get_db
from lib.services.utils import verify_password, create_access_token
from lib.models.user import User
from lib.schemas.user import LoginRequest, LoginResponse

router = APIRouter()


@router.post("/login", response_model=LoginResponse)
async def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Ambil data user berdasarkan email
    user = db.query(User).filter(User.email == request.email).first()

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
