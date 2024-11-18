from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime

# Base class for User with optional profile_border, profile_image, and coins
class UserBase(BaseModel):
    username: str
    email: EmailStr
    profile_border: Optional[str] = None  # Optional
    profile_image: Optional[str] = None  # Optional
    coins: Optional[int] = 0  # Optional with default 0

# Schema for creating a new User
class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

# Schema for reading User (without sensitive information)
class UserRead(BaseModel):
    user_id: int
    username: str
    email: EmailStr

# Output schema for returning User with full details
class UserOut(UserBase):
    user_id: int  # Add user_id to the output

    class Config:
        orm_mode = True  # Important for converting SQLAlchemy model to Pydantic model
