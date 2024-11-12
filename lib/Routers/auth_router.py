from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from lib.services.auth_service import authenticate_user
from lib.services.database import get_db

router = APIRouter()

@router.post("/login")
async def login(username: str, password: str, db: Session = Depends(get_db)):
    user = authenticate_user(db, username, password)
    if not user:
        raise HTTPException(status_code=400, detail="Invalid username or password")
    return {"message": "Login successful", "user_id": user.id}