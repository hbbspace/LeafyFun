from sqlalchemy import Boolean, Column, Integer, String
from lib.services.database import Base

class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String(25), unique=True)
    email = Column(String(50))
    password = Column(String(60))