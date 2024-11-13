from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine("mysql+pymysql://root@localhost:3306/leafyfun")
# engine = create_engine("mysql+pymysql://njczidlb:nioke8090@125.166.12.84/njczidlb_leafyfun")

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()