from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class LeafScanBase(BaseModel):
    user_id: int
    scan_image: str
    plant_id: Optional[int]
    confidence_score: Optional[float]
    status: str


class LeafScanCreate(LeafScanBase):
    pass


class LeafScanOut(LeafScanBase):
    scan_id: int
    scan_date: datetime

    class Config:
        orm_mode = True
