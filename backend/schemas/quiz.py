from pydantic import BaseModel


class QuizBase(BaseModel):
    plant_id: int
    question_text: str


class QuizCreate(QuizBase):
    pass


class QuizRead(QuizBase):
    quiz_id: int


class QuizOut(QuizRead):
    class Config:
        from_attributes = True
