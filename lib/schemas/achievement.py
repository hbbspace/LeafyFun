from pydantic import BaseModel


class AchievementBase(BaseModel):
    name: str
    description: str
    coin_reward: int


class AchievementCreate(BaseModel):
    name: str
    description: str


class AchievementRead(BaseModel):
    achievement_id: int
    name: str
    description: str


class AchievementOut(AchievementBase):
    achievement_id: int

class Config:
    orm_mode = True