CREATE TABLE tapaton.r_item (
    item_id UUID,
    item_name TEXT NOT NULL,
    item_div INTEGER REFERENCES tapaton.r_item_div(item_div) ON DELETE RESTRICT NOT NULL,
    item_source_div INTEGER REFERENCES tapaton.r_item_source_div(item_source_div) ON DELETE RESTRICT NOT NULL,
    data JSONB NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    create_user_id UUID REFERENCES auth.users(id) ON DELETE RESTRICT NOT NULL,
    update_user_id UUID REFERENCES auth.users(id) ON DELETE RESTRICT NOT NULL,

    PRIMARY KEY (item_id)
);
