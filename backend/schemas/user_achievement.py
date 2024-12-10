from pydantic import BaseModel
from datetime import datetime


class UserAchievementBase(BaseModel):
    user_id: int
    achievement_id: int


class UserAchievementCreate(UserAchievementBase):
    pass


class UserAchievementRead(UserAchievementBase):
    user_achievement_id: int
    date_earned: datetime


class UserAchievementOut(UserAchievementRead):
    class Config:
        from_attributes = True
