CREATE TABLE tapaton.r_item_data_format (
    item_div INTEGER REFERENCES tapaton.r_item_div(item_div) ON DELETE RESTRICT NOT NULL,
    version INTEGER NOT NULL,
    sample_data JSONB NOT NULL,
    comment TEXT NOT NULL,

    PRIMARY KEY (item_div, version)
);
