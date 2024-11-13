from sqlalchemy import Column, Integer, String
from lib.services.database import Base

class Plant(Base):
    __tablename__ = "plants"

    plant_id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100))
