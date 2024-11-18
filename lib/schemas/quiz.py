from pydantic import BaseModel
from typing import List


class QuizBase(BaseModel):
    plant_id: int
    question_text: str


class QuizCreate(QuizBase):
    pass


class QuizOut(QuizBase):
    quiz_id: int

    class Config:
        orm_mode = True
