from pydantic import BaseModel
from typing import List, Optional


class UserBase(BaseModel):
    username: str
    email: str
    google_auth: Optional[bool] = False
    profile_border: Optional[str] = None
    profile_image: Optional[str] = None
    coins: int


class UserCreate(UserBase):
    password: str


class UserRead(UserBase):
    user_id: int

class LoginRequest(BaseModel):
    email: str
    password: str

class LoginResponse(BaseModel):
    token: str
    message: str

class UserOut(UserRead):
    user_plants: List[int] = []
    user_achievements: List[int] = []

    class Config:
        from_attributes = True
