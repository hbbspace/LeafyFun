from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from lib.services.database import Base

class QuizOption(Base):
    __tablename__ = "quiz_options"
    
    option_id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.quiz_id"))
    option_text = Column(String(255))
    is_correct = Column(Boolean)

    quiz = relationship("Quiz", back_populates="options")