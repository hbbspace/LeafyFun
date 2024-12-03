from pydantic import BaseModel, EmailStr, Field
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

class UserUpdate(BaseModel):
    username: Optional[str] = Field(None, max_length=50)
    email: Optional[EmailStr]
    password: Optional[str] = Field(None, min_length=3)
    profile_border: Optional[str]
    profile_image: Optional[str]
    coins: Optional[int]

class UserOut(UserRead):
    user_plants: List[int] = []
    user_achievements: List[int] = []

    class Config:
        from_attributes = True
