from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from backend.models.achievement import Achievement as AchievementModel
from backend.schemas.achievement import AchievementCreate, AchievementRead
from backend.services.database import get_db

router = APIRouter()


@router.post("/", response_model=AchievementRead, status_code=status.HTTP_201_CREATED)
async def create_achievement(achievement: AchievementCreate, db: Session = Depends(get_db)):
    new_achievement = AchievementModel(
        name=achievement.name,
        description=achievement.description
    )
    db.add(new_achievement)
    db.commit()
    db.refresh(new_achievement)
    return new_achievement


@router.get("/{achievement_id}", response_model=AchievementRead, status_code=status.HTTP_200_OK)
async def read_achievement(achievement_id: int, db: Session = Depends(get_db)):
    achievement = db.query(AchievementModel).filter(AchievementModel.achievement_id == achievement_id).first()
    if achievement is None:
        raise HTTPException(status_code=404, detail="Achievement not found")
    return achievement
