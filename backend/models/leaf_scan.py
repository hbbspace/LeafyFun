from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship, Session
from backend.services.database import Base
from datetime import datetime

class LeafScan(Base):
    __tablename__ = "leaf_scans"
    
    scan_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    scan_image = Column(String(255))  # Menyimpan nama file gambar scan daun
    plant_id = Column(Integer, ForeignKey("plants.plant_id"))
    scan_date = Column(String(10))
    confidence_score = Column(Float)

    user = relationship("User")
    plant = relationship("Plant")

def leaf_scan_init(db:Session):
    if db.query(LeafScan).count() == 0:
        leafscan = [
            LeafScan(scan_id = 1, user_id = 2, scan_image = "scan_image_name.jpg", plant_id = 1, scan_date = datetime.utcnow().strftime("%d-%m-%Y"), confidence_score = 95.5,)
        ]
        db.add_all(leafscan)
        db.flush()