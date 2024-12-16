from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from backend.services.database import Base
from sqlalchemy.orm import Session

class QuizOption(Base):
    __tablename__ = "quiz_options"
    
    option_id = Column(Integer, primary_key=True, index=True)
    quiz_id = Column(Integer, ForeignKey("quizzes.quiz_id"))
    option_text = Column(String(255))
    is_correct = Column(Boolean)

    quiz = relationship("Quiz", back_populates="quiz_options")

def quiz_option_init(db: Session):
    if db.query(QuizOption).count() == 0:
        quiz_options = [

            # APPLE
            # Apple: Question 1
            QuizOption(quiz_id=1, option_text="Red", is_correct=True),
            QuizOption(quiz_id=1, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=1, option_text="Green", is_correct=False),
            QuizOption(quiz_id=1, option_text="Purple", is_correct=False),
                    
            # Apple: Question 2
            QuizOption(quiz_id=2, option_text="Vitamin A", is_correct=False),
            QuizOption(quiz_id=2, option_text="Vitamin C", is_correct=True),
            QuizOption(quiz_id=2, option_text="Vitamin D", is_correct=False),
            QuizOption(quiz_id=2, option_text="Vitamin B12", is_correct=False),
                    
            # Apple: Question 3
            QuizOption(quiz_id=3, option_text="Leaves", is_correct=False),
            QuizOption(quiz_id=3, option_text="Roots", is_correct=False),
            QuizOption(quiz_id=3, option_text="Flowers", is_correct=True),
            QuizOption(quiz_id=3, option_text="Bark", is_correct=False),

            # Apple: Question 4        
            QuizOption(quiz_id=4, option_text="Gala", is_correct=True),
            QuizOption(quiz_id=4, option_text="Rose", is_correct=False),
            QuizOption(quiz_id=4, option_text="Tulip", is_correct=False),
            QuizOption(quiz_id=4, option_text="Daisy", is_correct=False),

            # Apple: Question 5        
            QuizOption(quiz_id=5, option_text="Tropical climates", is_correct=False),
            QuizOption(quiz_id=5, option_text="Temperate regions", is_correct=True),
            QuizOption(quiz_id=5, option_text="Desert climates", is_correct=False),
            QuizOption(quiz_id=5, option_text="Arctic regions", is_correct=False),

            # Apple: Question 6
            QuizOption(quiz_id=6, option_text="Rich in protein", is_correct=False),
            QuizOption(quiz_id=6, option_text="High in fiber", is_correct=True),
            QuizOption(quiz_id=6, option_text="Low in calories", is_correct=False),
            QuizOption(quiz_id=6, option_text="Contains caffeine", is_correct=False),
            
            # Apple: Question 7
            QuizOption(quiz_id=7, option_text="In the freezer", is_correct=False),
            QuizOption(quiz_id=7, option_text="In a cool, dry place", is_correct=True),
            QuizOption(quiz_id=7, option_text="In direct sunlight", is_correct=False),
            QuizOption(quiz_id=7, option_text="Under water", is_correct=False),
            
            # Apple: Question 8
            QuizOption(quiz_id=8, option_text="100-200", is_correct=False),
            QuizOption(quiz_id=8, option_text="200-300", is_correct=True),
            QuizOption(quiz_id=8, option_text="500-600", is_correct=False),
            QuizOption(quiz_id=8, option_text="1000+", is_correct=False),
            
            # Apple: Question 9
            QuizOption(quiz_id=9, option_text="10-15 years", is_correct=False),
            QuizOption(quiz_id=9, option_text="30-50 years", is_correct=True),
            QuizOption(quiz_id=9, option_text="5-10 years", is_correct=False),
            QuizOption(quiz_id=9, option_text="100 years", is_correct=False),
            
            # Apple: Question 10
            QuizOption(quiz_id=10, option_text="After 1 year", is_correct=False),
            QuizOption(quiz_id=10, option_text="After 3-4 years", is_correct=True),
            QuizOption(quiz_id=10, option_text="After 10 years", is_correct=False),
            QuizOption(quiz_id=10, option_text="After 20 years", is_correct=False),
                    
            # CHERRY
            # Cherry: Question 1
            QuizOption(quiz_id=11, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=11, option_text="Red", is_correct=True),
            QuizOption(quiz_id=11, option_text="Green", is_correct=False),
            QuizOption(quiz_id=11, option_text="Blue", is_correct=False),
            
            # Cherry: Question 2
            QuizOption(quiz_id=12, option_text="Rich in antioxidants", is_correct=True),
            QuizOption(quiz_id=12, option_text="High in caffeine", is_correct=False),
            QuizOption(quiz_id=12, option_text="Low in vitamin C", is_correct=False),
            QuizOption(quiz_id=12, option_text="High in fats", is_correct=False),
            
            # Cherry: Question 3
            QuizOption(quiz_id=13, option_text="Oval", is_correct=False),
            QuizOption(quiz_id=13, option_text="Round", is_correct=True),
            QuizOption(quiz_id=13, option_text="Long", is_correct=False),
            QuizOption(quiz_id=13, option_text="Flat", is_correct=False),
                    
            # Cherry: Question 4
            QuizOption(quiz_id=14, option_text="Sour cherries", is_correct=True),
            QuizOption(quiz_id=14, option_text="Sweet cherries", is_correct=False),
            QuizOption(quiz_id=14, option_text="Wild cherries", is_correct=False),
            QuizOption(quiz_id=14, option_text="Tart cherries", is_correct=False),
            
            # Cherry: Question 5
            QuizOption(quiz_id=15, option_text="Tropical climates", is_correct=False),
            QuizOption(quiz_id=15, option_text="Temperate climates", is_correct=True),
            QuizOption(quiz_id=15, option_text="Desert climates", is_correct=False),
            QuizOption(quiz_id=15, option_text="Arctic climates", is_correct=False),
            
            # Cherry: Question 6
            QuizOption(quiz_id=16, option_text="1-2 years", is_correct=False),
            QuizOption(quiz_id=16, option_text="3-5 years", is_correct=True),
            QuizOption(quiz_id=16, option_text="7-10 years", is_correct=False),
            QuizOption(quiz_id=16, option_text="20+ years", is_correct=False),
            
            # Cherry: Question 7
            QuizOption(quiz_id=17, option_text="Freezing", is_correct=True),
            QuizOption(quiz_id=17, option_text="Drying", is_correct=False),
            QuizOption(quiz_id=17, option_text="Pickling", is_correct=False),
            QuizOption(quiz_id=17, option_text="Baking", is_correct=False),
            
            # Cherry: Question 8
            QuizOption(quiz_id=18, option_text="Sweet cherries are larger", is_correct=False),
            QuizOption(quiz_id=18, option_text="Sour cherries are typically used for pies", is_correct=True),
            QuizOption(quiz_id=18, option_text="Sweet cherries have a thicker skin", is_correct=False),
            QuizOption(quiz_id=18, option_text="Sour cherries are sweeter", is_correct=False),
            
            # Cherry: Question 9
            QuizOption(quiz_id=19, option_text="10-15 years", is_correct=False),
            QuizOption(quiz_id=19, option_text="15-20 years", is_correct=True),
            QuizOption(quiz_id=19, option_text="20-30 years", is_correct=False),
            QuizOption(quiz_id=19, option_text="50 years", is_correct=False),
            
            # Cherry: Question 10
            QuizOption(quiz_id=20, option_text="Europe and North America", is_correct=True),
            QuizOption(quiz_id=20, option_text="Asia and South America", is_correct=False),
            QuizOption(quiz_id=20, option_text="Africa and Australia", is_correct=False),
            QuizOption(quiz_id=20, option_text="South Pacific Islands", is_correct=False),

            # GRAPE
            # Grape: Question 1
            QuizOption(quiz_id=21, option_text="Green", is_correct=False),
            QuizOption(quiz_id=21, option_text="Red", is_correct=False),
            QuizOption(quiz_id=21, option_text="Purple", is_correct=True),
            QuizOption(quiz_id=21, option_text="Yellow", is_correct=False),
            
            # Grape: Question 2
            QuizOption(quiz_id=22, option_text="Juice", is_correct=False),
            QuizOption(quiz_id=22, option_text="Wine", is_correct=False),
            QuizOption(quiz_id=22, option_text="Jam", is_correct=False),
            QuizOption(quiz_id=22, option_text="All of the above", is_correct=True),
            
            # Grape: Question 3
            QuizOption(quiz_id=23, option_text="Tropical", is_correct=False),
            QuizOption(quiz_id=23, option_text="Mediterranean", is_correct=True),
            QuizOption(quiz_id=23, option_text="Cold", is_correct=False),
            QuizOption(quiz_id=23, option_text="Desert", is_correct=False),
            
            # Grape: Question 4
            QuizOption(quiz_id=24, option_text="Tree", is_correct=False),
            QuizOption(quiz_id=24, option_text="Bush", is_correct=False),
            QuizOption(quiz_id=24, option_text="Vine", is_correct=True),
            QuizOption(quiz_id=24, option_text="Shrub", is_correct=False),
            
            # Grape: Question 5
            QuizOption(quiz_id=25, option_text="2-4", is_correct=False),
            QuizOption(quiz_id=25, option_text="4-6", is_correct=False),
            QuizOption(quiz_id=25, option_text="6-8", is_correct=True),
            QuizOption(quiz_id=25, option_text="8-10", is_correct=False),
            
            # Grape: Question 6
            QuizOption(quiz_id=26, option_text="Vitis vinifera", is_correct=True),
            QuizOption(quiz_id=26, option_text="Malus domestica", is_correct=False),
            QuizOption(quiz_id=26, option_text="Solanum lycopersicum", is_correct=False),
            QuizOption(quiz_id=26, option_text="Fragaria × ananassa", is_correct=False),
            
            # Grape: Question 7
            QuizOption(quiz_id=27, option_text="Aphids", is_correct=True),
            QuizOption(quiz_id=27, option_text="Beetles", is_correct=False),
            QuizOption(quiz_id=27, option_text="Moths", is_correct=False),
            QuizOption(quiz_id=27, option_text="Birds", is_correct=False),
            
            # Grape: Question 8
            QuizOption(quiz_id=28, option_text="Spring", is_correct=False),
            QuizOption(quiz_id=28, option_text="Summer", is_correct=False),
            QuizOption(quiz_id=28, option_text="Autumn", is_correct=True),
            QuizOption(quiz_id=28, option_text="Winter", is_correct=False),
            
            # Grape: Question 9
            QuizOption(quiz_id=29, option_text="1 inch", is_correct=False),
            QuizOption(quiz_id=29, option_text="2 inches", is_correct=True),
            QuizOption(quiz_id=29, option_text="3 inches", is_correct=False),
            QuizOption(quiz_id=29, option_text="4 inches", is_correct=False),
            
            # Grape: Question 10
            QuizOption(quiz_id=30, option_text="Asia", is_correct=False),
            QuizOption(quiz_id=30, option_text="Europe", is_correct=True),
            QuizOption(quiz_id=30, option_text="Americas", is_correct=False),
            QuizOption(quiz_id=30, option_text="Africa", is_correct=False),

            # STRAWBERRY
            # Strawberry: Question 1
            QuizOption(quiz_id=31, option_text="Green", is_correct=False),
            QuizOption(quiz_id=31, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=31, option_text="Red", is_correct=True),
            QuizOption(quiz_id=31, option_text="Orange", is_correct=False),
            
            # Strawberry: Question 2
            QuizOption(quiz_id=32, option_text="Clay", is_correct=False),
            QuizOption(quiz_id=32, option_text="Sandy", is_correct=False),
            QuizOption(quiz_id=32, option_text="Loamy", is_correct=True),
            QuizOption(quiz_id=32, option_text="Rocky", is_correct=False),
            
            # Strawberry: Question 3
            QuizOption(quiz_id=33, option_text="Daily", is_correct=False),
            QuizOption(quiz_id=33, option_text="Twice a week", is_correct=True),
            QuizOption(quiz_id=33, option_text="Once a week", is_correct=False),
            QuizOption(quiz_id=33, option_text="Every other day", is_correct=False),
            
            # Strawberry: Question 4
            QuizOption(quiz_id=34, option_text="Snails", is_correct=False),
            QuizOption(quiz_id=34, option_text="Mites", is_correct=False),
            QuizOption(quiz_id=34, option_text="Beetles", is_correct=False),
            QuizOption(quiz_id=34, option_text="Aphids", is_correct=True),
            
            # Strawberry: Question 5
            QuizOption(quiz_id=35, option_text="Fragaria × ananassa", is_correct=True),
            QuizOption(quiz_id=35, option_text="Solanum lycopersicum", is_correct=False),
            QuizOption(quiz_id=35, option_text="Vitis vinifera", is_correct=False),
            QuizOption(quiz_id=35, option_text="Citrus sinensis", is_correct=False),
            
            # Strawberry: Question 6
            QuizOption(quiz_id=36, option_text="Tropical", is_correct=False),
            QuizOption(quiz_id=36, option_text="Temperate", is_correct=True),
            QuizOption(quiz_id=36, option_text="Cold", is_correct=False),
            QuizOption(quiz_id=36, option_text="Desert", is_correct=False),
            
            # Strawberry: Question 7
            QuizOption(quiz_id=37, option_text="1-2 years", is_correct=False),
            QuizOption(quiz_id=37, option_text="3-4 years", is_correct=True),
            QuizOption(quiz_id=37, option_text="5-6 years", is_correct=False),
            QuizOption(quiz_id=37, option_text="7-8 years", is_correct=False),
            
            # Strawberry: Question 8
            QuizOption(quiz_id=38, option_text="Spring", is_correct=True),
            QuizOption(quiz_id=38, option_text="Summer", is_correct=False),
            QuizOption(quiz_id=38, option_text="Autumn", is_correct=False),
            QuizOption(quiz_id=38, option_text="Winter", is_correct=False),
            
            # Strawberry: Question 9
            QuizOption(quiz_id=39, option_text="2-4 hours", is_correct=False),
            QuizOption(quiz_id=39, option_text="4-6 hours", is_correct=False),
            QuizOption(quiz_id=39, option_text="6-8 hours", is_correct=True),
            QuizOption(quiz_id=39, option_text="8-10 hours", is_correct=False),
            
            # Strawberry: Question 10
            QuizOption(quiz_id=40, option_text="Vitamin A", is_correct=False),
            QuizOption(quiz_id=40, option_text="Vitamin B", is_correct=False),
            QuizOption(quiz_id=40, option_text="Vitamin C", is_correct=True),
            QuizOption(quiz_id=40, option_text="Vitamin D", is_correct=False),

            # TOMATO
            # Tomato: Question 1
            QuizOption(quiz_id=41, option_text="Green", is_correct=False),
            QuizOption(quiz_id=41, option_text="Yellow", is_correct=False),
            QuizOption(quiz_id=41, option_text="Red", is_correct=True),
            QuizOption(quiz_id=41, option_text="Purple", is_correct=False),
            
            # Tomato: Question 2
            QuizOption(quiz_id=42, option_text="Shrub", is_correct=False),
            QuizOption(quiz_id=42, option_text="Tree", is_correct=False),
            QuizOption(quiz_id=42, option_text="Vine", is_correct=True),
            QuizOption(quiz_id=42, option_text="Bush", is_correct=False),
            
            # Tomato: Question 3
            QuizOption(quiz_id=43, option_text="Solanum lycopersicum", is_correct=True),
            QuizOption(quiz_id=43, option_text="Cucumis sativus", is_correct=False),
            QuizOption(quiz_id=43, option_text="Capsicum annuum", is_correct=False),
            QuizOption(quiz_id=43, option_text="Lycopersicon esculentum", is_correct=False),
            
            # Tomato: Question 4
            QuizOption(quiz_id=44, option_text="Tropical", is_correct=False),
            QuizOption(quiz_id=44, option_text="Temperate", is_correct=True),
            QuizOption(quiz_id=44, option_text="Cold", is_correct=False),
            QuizOption(quiz_id=44, option_text="Arctic", is_correct=False),
            
            # Tomato: Question 5
            QuizOption(quiz_id=45, option_text="Aphids", is_correct=True),
            QuizOption(quiz_id=45, option_text="Ants", is_correct=False),
            QuizOption(quiz_id=45, option_text="Whiteflies", is_correct=False),
            QuizOption(quiz_id=45, option_text="Snails", is_correct=False),
            
            # Tomato: Question 6
            QuizOption(quiz_id=46, option_text="1-2 days per week", is_correct=False),
            QuizOption(quiz_id=46, option_text="1-2 months", is_correct=False),
            QuizOption(quiz_id=46, option_text="5-6 days per week", is_correct=False),
            QuizOption(quiz_id=46, option_text="1-2 inches of water per week", is_correct=True),
            
            # Tomato: Question 7
            QuizOption(quiz_id=47, option_text="Sandy soil", is_correct=False),
            QuizOption(quiz_id=47, option_text="Loamy soil", is_correct=True),
            QuizOption(quiz_id=47, option_text="Clay soil", is_correct=False),
            QuizOption(quiz_id=47, option_text="Peaty soil", is_correct=False),
            
            # Tomato: Question 8
            QuizOption(quiz_id=48, option_text="Summer", is_correct=True),
            QuizOption(quiz_id=48, option_text="Spring", is_correct=False),
            QuizOption(quiz_id=48, option_text="Winter", is_correct=False),
            QuizOption(quiz_id=48, option_text="Autumn", is_correct=False),
            
            # Tomato: Question 9
            QuizOption(quiz_id=49, option_text="2-4 hours", is_correct=False),
            QuizOption(quiz_id=49, option_text="4-6 hours", is_correct=False),
            QuizOption(quiz_id=49, option_text="6-8 hours", is_correct=True),
            QuizOption(quiz_id=49, option_text="8-10 hours", is_correct=False),
            
            # Tomato: Question 10
            QuizOption(quiz_id=50, option_text="A", is_correct=False),
            QuizOption(quiz_id=50, option_text="B", is_correct=False),
            QuizOption(quiz_id=50, option_text="C", is_correct=True),
            QuizOption(quiz_id=50, option_text="D", is_correct=False),
        ]
            
        db.add_all(quiz_options)
        db.commit() # Catat Perubahan