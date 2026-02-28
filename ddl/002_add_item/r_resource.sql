CREATE TABLE tapaton.r_resource (
    resource_id UUID,
    resource_name TEXT NOT NULL,
    resource_div INTEGER REFERENCES tapaton.r_resource_div(resource_div) ON DELETE RESTRICT NOT NULL,
    resource_path TEXT NOT NULL,
    data JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    create_user_id UUID REFERENCES auth.users(id) ON DELETE RESTRICT NOT NULL,
    update_user_id UUID REFERENCES auth.users(id) ON DELETE RESTRICT NOT NULL,

    PRIMARY KEY (resource_id)
);
