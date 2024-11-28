from pydantic import BaseModel


class AchievementBase(BaseModel):
    name: str
    description: str
    coin_reward: int


class AchievementCreate(AchievementBase):
    pass


class AchievementRead(AchievementBase):
    achievement_id: int


class AchievementOut(AchievementBase):
    achievement_id: int

    class Config:
        from_attributes = True
