from pydantic import BaseModel
from datetime import datetime


class ArticleBase(BaseModel):
    title: str
    content: str


class ArticleCreate(ArticleBase):
    pass


class ArticleRead(ArticleBase):
    article_id: int
    created_at: datetime


class ArticleOut(ArticleRead):
    class Config:
        from_attributes = True
