from sqlalchemy import Column, Integer, ForeignKey, String
from sqlalchemy.orm import relationship, Session
from backend.services.database import Base
from datetime import datetime

class UserPlant(Base):
    __tablename__ = "user_plants"
    
    user_plant_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    date_saved = Column(String(10))
    quiz_score = Column(Integer, default=0)

    user = relationship("User", back_populates="user_plants")
    plant = relationship("Plant")

def user_plan_init(db:Session):
    if db.query(UserPlant).count() == 0:
        userplant = [
            UserPlant(user_plant_id = 1, user_id = 2, plant_id = 1, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
            UserPlant(user_plant_id = 2, user_id = 3, plant_id = 1, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
            UserPlant(user_plant_id = 3, user_id = 3, plant_id = 2, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
            UserPlant(user_plant_id = 4, user_id = 3, plant_id = 3, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
            UserPlant(user_plant_id = 5, user_id = 3, plant_id = 4, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
            UserPlant(user_plant_id = 6, user_id = 3, plant_id = 5, date_saved = datetime.utcnow().strftime("%d-%m-%Y")),
        ]
        db.add_all(userplant)
        db.flush()