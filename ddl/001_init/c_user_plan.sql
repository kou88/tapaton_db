CREATE TABLE tapaton.c_user_plan (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
    plan_id UUID REFERENCES tapaton.r_plan(plan_id) ON DELETE RESTRICT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    source TEXT,

    PRIMARY KEY (user_id, plan_id)
);
