from sqlalchemy import Column, Integer, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from backend.services.database import Base
from datetime import datetime

class UserAchievement(Base):
    __tablename__ = "user_achievements"
    
    user_achievement_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    achievement_id = Column(Integer, ForeignKey("achievements.achievement_id"))
    date_earned = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="user_achievements")
    achievement = relationship("Achievement")