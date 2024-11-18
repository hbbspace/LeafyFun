from sqlalchemy import Column, Integer, String, Text
from lib.services.database import Base

class Achievement(Base):
    __tablename__ = "achievements"
    
    achievement_id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100))
    description = Column(Text)
    coin_reward = Column(Integer)
