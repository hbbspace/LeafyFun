from sqlalchemy import Column, Enum, Integer, String, Text
from lib.services.database import Base
from sqlalchemy.orm import Session

class Plant(Base):
    __tablename__ = "plants"
    
    plant_id = Column(Integer, primary_key=True, index=True)
    common_name = Column(String(100))
    latin_name = Column(String(100))
    description = Column(Text)
    fruit_content = Column(String(255))
    fruit_season = Column(String(50))
    region = Column(String(100))
    price_range = Column(String(50))
    image_file = Column(String(255))

def plant_init(db: Session):
    if db.query(Plant).count() == 0:
            plants = [
                Plant(
                    common_name="Apple",
                    latin_name="Malus domestica",
                    description="Apple tree is a deciduous tree that produces sweet and crispy apples. It thrives in temperate climates and is a popular choice for orchards. The tree is medium-sized with blossoms that attract pollinators. Apple trees require proper care to ensure healthy fruit production.",
                    fruit_content="Vitamin C, Vitamin A, Vitamin K, Fiber, Potassium, Antioxidants",
                    fruit_season="Autumn",
                    region="Malang (East Java) and other temperate regions in Indonesia",
                    price_range="Rp100,000 - Rp300,000",
                    image_file="apple_tree.jpg"
                ),
                Plant(
                    common_name="Cherry",
                    latin_name="Prunus avium",
                    description="Cherry trees are known for their beautiful blossoms and sweet or tart cherries. These trees require a cooler climate to grow well. The fruits are small, juicy, and vibrant red, often used in desserts and beverages.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Potassium, Anthocyanins",
                    fruit_season="Spring to early Summer",
                    region="Highlands such as Dieng",
                    price_range="Rp200,000 - Rp500,000",
                    image_file="cherry_tree.jpg"
                ),
                Plant(
                    common_name="Corn",
                    latin_name="Zea mays",
                    description="Corn is a versatile plant that grows in various climates. It produces ears of corn that are rich in carbohydrates and widely consumed as food. Corn plants are tall with long green leaves and tassels at the top.",
                    fruit_content="Carbohydrates, Vitamin B, Magnesium, Phosphorus, Lutein, Zeaxanthin",
                    fruit_season="Summer",
                    region="Java, Sulawesi, Sumatra",
                    price_range="Rp5,000 - Rp20,000",
                    image_file="corn_plant.jpg"
                ),
                Plant(
                    common_name="Grape",
                    latin_name="Vitis vinifera",
                    description="Grape vines are climbing plants that produce clusters of sweet or tart grapes. The fruits are used for eating fresh, making juices, or producing wine. These plants prefer sunny and warm climates.",
                    fruit_content="Vitamin C, Vitamin K, Potassium, Fiber, Resveratrol",
                    fruit_season="Summer",
                    region="Probolinggo (East Java), Bali",
                    price_range="Rp50,000 - Rp150,000",
                    image_file="grape_vine.jpg"
                ),
                Plant(
                    common_name="Guava",
                    latin_name="Psidium guajava",
                    description="Guava trees are tropical plants that produce round or oval fruits with a sweet and tangy taste. The tree is hardy and adapts well to warm climates. Guavas are commonly consumed fresh or as juice.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Folate, Potassium, Lycopene",
                    fruit_season="Year-round",
                    region="Java, Sumatra",
                    price_range="Rp10,000 - Rp50,000",
                    image_file="guava_tree.jpg"
                ),
                Plant(
                    common_name="Jackfruit",
                    latin_name="Artocarpus heterophyllus",
                    description="Jackfruit trees are large and tropical, producing massive fruits with sweet yellow flesh. The tree is fast-growing and highly valued for its versatile uses, including its timber and edible fruit.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Potassium, Magnesium, Antioxidants",
                    fruit_season="Year-round",
                    region="Java, Kalimantan, Sumatra",
                    price_range="Rp30,000 - Rp100,000",
                    image_file="jackfruit_tree.jpg"
                ),
                Plant(
                    common_name="Lime",
                    latin_name="Citrus aurantiifolia",
                    description="Lime trees are small citrus trees that produce small, green, and tangy fruits. They are popular for culinary uses and thrive in tropical regions with plenty of sunlight.",
                    fruit_content="Vitamin C, Calcium, Magnesium, Flavonoids, Citric Acid",
                    fruit_season="Year-round",
                    region="Java, Bali, and other tropical regions",
                    price_range="Rp15,000 - Rp50,000",
                    image_file="lime_tree.jpg"
                ),
                Plant(
                    common_name="Papaya",
                    latin_name="Carica papaya",
                    description="Papaya trees are fast-growing tropical plants that produce sweet and juicy fruits. The tree is low-maintenance and provides both fruit and leaves with medicinal properties.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Folate, Papain Enzyme, Antioxidants",
                    fruit_season="Year-round",
                    region="All Indonesia",
                    price_range="Rp10,000 - Rp30,000",
                    image_file="papaya_tree.jpg"
                ),
                Plant(
                    common_name="Peach",
                    latin_name="Prunus persica",
                    description="Peach trees are deciduous plants that produce juicy and sweet peaches. The tree is small to medium-sized and requires a cold climate to thrive, making it rare in tropical regions.",
                    fruit_content="Vitamin C, Vitamin A, Potassium, Fiber, Polyphenol Antioxidants",
                    fruit_season="Summer",
                    region="Imported or experimental farms in Indonesia",
                    price_range="Rp250,000 - Rp500,000",
                    image_file="peach_tree.jpg"
                ),
                Plant(
                    common_name="Starfruit",
                    latin_name="Averrhoa carambola",
                    description="Starfruit trees produce star-shaped fruits with a unique sweet-tangy flavor. They grow well in tropical climates and are commonly found in Indonesia.",
                    fruit_content="Vitamin C, Vitamin A, Fiber, Potassium, Antioxidants",
                    fruit_season="Year-round",
                    region="Java, Sumatra, Kalimantan",
                    price_range="Rp20,000 - Rp70,000",
                    image_file="starfruit_tree.jpg"
                ),
                Plant(
                    common_name="Strawberry",
                    latin_name="Fragaria x ananassa",
                    description="Strawberry plants are low-growing perennials that produce small, sweet, and red berries. These plants thrive in cooler climates and are popular in highland regions.",
                    fruit_content="Vitamin C, Manganese, Folate, Fiber, Antioxidants",
                    fruit_season="Winter",
                    region="Ciwidey (West Java), Batu (East Java)",
                    price_range="Rp50,000 - Rp150,000",
                    image_file="strawberry_plant.jpg"
                ),
                Plant(
                    common_name="Tomato",
                    latin_name="Solanum lycopersicum",
                    description="Tomato plants are widely cultivated for their versatile fruits, which can be eaten raw or cooked. They are easy to grow and thrive in warm climates.",
                    fruit_content="Vitamin C, Vitamin K, Potassium, Folate, Lycopene",
                    fruit_season="Year-round",
                    region="All Indonesia",
                    price_range="Rp5,000 - Rp20,000",
                    image_file="tomato_plant.jpg"
                )
            ]
            db.add_all(plants)
            db.flush()  # Catat perubahan