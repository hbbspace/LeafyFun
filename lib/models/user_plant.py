from sqlalchemy import Column, Integer, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from lib.services.database import Base
from datetime import datetime

class UserPlant(Base):
    __tablename__ = "user_plants"
    
    user_plant_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    date_saved = Column(DateTime, default=datetime.utcnow)
    quiz_score = Column(Integer, default=0)

    user = relationship("User", back_populates="user_plants")
    plant = relationship("Plant")
