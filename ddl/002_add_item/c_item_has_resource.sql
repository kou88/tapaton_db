CREATE TABLE tapaton.c_item_has_resource (
    item_id UUID REFERENCES tapaton.r_item(item_id) ON DELETE RESTRICT NOT NULL,
    resource_id UUID REFERENCES tapaton.r_resource(resource_id) ON DELETE RESTRICT NOT NULL,
    sort_num INTEGER NOT NULL,
    PRIMARY KEY (item_id, resource_id)
);
