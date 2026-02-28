CREATE TABLE tapaton.c_item_related_food (
    item_id UUID REFERENCES tapaton.r_item(item_id) ON DELETE RESTRICT NOT NULL,
    food_2020_id UUID REFERENCES tapaton.r_food_2020(food_2020_id) ON DELETE RESTRICT NOT NULL,
    PRIMARY KEY (item_id, food_2020_id)
);
