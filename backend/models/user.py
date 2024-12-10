from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship, Session
from sqlalchemy.sql import func
from backend.services.database import Base
from backend.services.utils import hash_password

class User(Base):
    __tablename__ = "users"
    
    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    google_auth = Column(Boolean, default=False)
    profile_border = Column(String(100), nullable=True)
    profile_image = Column(String(255), nullable=True)
    coins = Column(Integer, default=0)

    # Relasi dengan tabel lainnya
    user_plants = relationship("UserPlant", back_populates="user")
    user_achievements = relationship("UserAchievement", back_populates="user")

def user_init(db: Session):
        if db.query(User).count() == 0:
            users = [
                User(username="Habibatul", email="hbb@gmail.com", password=hash_password("123")),
                User(username="Diantoro", email="diantoro@gmail.com", password=hash_password("234")),
            ]
            db.add_all(users)
            db.flush()  # Catat perubahan