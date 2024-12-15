from pydantic import BaseModel
from datetime import datetime


class LeafScanBase(BaseModel):
    user_id: int
    scan_image: str
    plant_id: int
    confidence_score: float

class LeafScanRead(LeafScanBase):
    # scan_id: int
    # scan_date: str
    pass

class LeafScanCreate(LeafScanRead):
    pass

class LeafScanOut(LeafScanRead):
    class Config:
        from_attributes = True
