from pydantic import BaseModel, EmailStr, Field
from typing import List, Optional


class UserBase(BaseModel):
    username: str
    email: str


class UserCreate(UserBase):
    password: str


class UserRead(UserBase):
    user_id: int

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class LoginResponse(BaseModel):
    access_token: str
    token_type: str

class UserUpdate(BaseModel):
    username: Optional[str] = Field(None, title="Username", max_length=100)
    email: Optional[EmailStr] = Field(None, title="Email Address")
    password: Optional[str] = Field(None, title="Password", min_length=3)

class UserOut(UserRead):
    user_plants: List[int] = []
    user_achievements: List[int] = []

    class Config:
        from_attributes = True