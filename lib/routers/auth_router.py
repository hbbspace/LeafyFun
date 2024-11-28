from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from sqlalchemy.orm import Session
from lib.services.database import get_db
from lib.services.utils import hash_password, verify_password, create_access_token
from lib.models.user import User
from lib.schemas.user import LoginRequest

router = APIRouter()

@router.post("/")
async def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Ambil data user berdasarkan email
    user = db.query(User).filter(User.email == request.email).first()

    if not user or not verify_password(request.password, user.password):
        raise HTTPException(status_code=400, detail="Invalid credentials")

    # Jika login berhasil, buat token akses (JWT atau yang lainnya)
    access_token = create_access_token(data={"sub": user.email})

    # Kembalikan response
    return JSONResponse(content={"access_token": access_token, "token_type": "bearer"})
