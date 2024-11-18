from sqlalchemy import Column, Integer, String, Text
from lib.services.database import Base

class Plant(Base):
    __tablename__ = "plants"
    
    plant_id = Column(Integer, primary_key=True, index=True)
    common_name = Column(String(100))
    latin_name = Column(String(100))
    description = Column(Text)
    vitamin_content = Column(String(255))
    fruit_type = Column(String(50))
    fruit_season = Column(String(50))
    region = Column(String(100))
    price_range = Column(String(50))
    image_file = Column(String(255))
