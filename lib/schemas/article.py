from pydantic import BaseModel
from datetime import datetime


class ArticleBase(BaseModel):
    title: str
    content: str


class ArticleCreate(ArticleBase):
    pass


class ArticleOut(ArticleBase):
    article_id: int
    created_at: datetime

    class Config:
        orm_mode = True
