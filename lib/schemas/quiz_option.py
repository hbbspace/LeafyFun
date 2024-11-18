from pydantic import BaseModel


class QuizOptionBase(BaseModel):
    quiz_id: int
    option_text: str
    is_correct: bool


class QuizOptionCreate(QuizOptionBase):
    pass


class QuizOptionOut(QuizOptionBase):
    option_id: int

    class Config:
        orm_mode = True
