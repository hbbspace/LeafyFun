from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from lib.services.database import Base

class User(Base):
    __tablename__ = "users"
    
    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, index=True)
    email = Column(String(100), unique=True, index=True)
    password = Column(String(255))
    google_auth = Column(Boolean, default=False)
    profile_border = Column(String(100), nullable=True)
    profile_image = Column(String(255), nullable=True)
    coins = Column(Integer, default=0)

    # Relasi dengan tabel lainnya
    user_plants = relationship("UserPlant", back_populates="user")
    user_achievements = relationship("UserAchievement", back_populates="user")