from sqlalchemy import Column, Integer, String, Float, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from lib.services.database import Base
from datetime import datetime

class LeafScan(Base):
    __tablename__ = "leaf_scans"
    
    scan_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    scan_image = Column(String(255))  # Menyimpan nama file gambar scan daun
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    scan_date = Column(DateTime, default=datetime.utcnow)
    confidence_score = Column(Float)
    status = Column(String(50))

    user = relationship("User")
    plant = relationship("Plant")
