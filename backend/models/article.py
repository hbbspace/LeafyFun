from sqlalchemy import Column, Integer, String, Text, DateTime
from backend.services.database import Base
from datetime import datetime

class Article(Base):
    __tablename__ = "articles"
    
    article_id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200), index=True)
    content = Column(Text)
    created_at = Column(DateTime, index=True)