from pydantic import BaseModel


class QuizOptionBase(BaseModel):
    quiz_id: int
    option_text: str
    is_correct: bool


class QuizOptionCreate(QuizOptionBase):
    pass


class QuizOptionRead(QuizOptionBase):
    option_id: int


class QuizOptionOut(QuizOptionRead):
    class Config:
        from_attributes = True
