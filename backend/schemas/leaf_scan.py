from pydantic import BaseModel
from datetime import datetime


class LeafScanBase(BaseModel):
    user_id: int
    scan_image: str
    plant_id: int
    confidence_score: float


class LeafScanCreate(LeafScanBase):
    pass


class LeafScanRead(LeafScanBase):
    scan_id: int
    scan_date: datetime


class LeafScanOut(LeafScanRead):
    class Config:
        from_attributes = True
