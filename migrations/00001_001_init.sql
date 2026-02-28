-- generated file: 00001_001_init.sql
-- source directory: ddl/001_init

BEGIN;

-- file: schema.sql
CREATE SCHEMA IF NOT EXISTS tapaton;
-- file: r_plan.sql
CREATE TABLE tapaton.r_plan (
    plan_id UUID,
    plan_number INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    
    CHECK (plan_number > 0),
    
    PRIMARY KEY (plan_id)
)
;

INSERT INTO tapaton.r_plan (plan_id, plan_number, name, description) VALUES
('00000000-0000-0000-0000-000000000001', 1, 'Free', 'Free plan'),
('00000000-0000-0000-0000-000000000002', 2, 'Premium', 'Premium plan')
;

-- file: c_user_plan.sql
CREATE TABLE tapaton.c_user_plan (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
    plan_id UUID REFERENCES tapaton.r_plan(plan_id) ON DELETE RESTRICT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    source TEXT,

    PRIMARY KEY (user_id, plan_id)
);

-- file: e_revenuecat_event.sql
CREATE TABLE tapaton.e_revenuecat_event (
    event_id TEXT PRIMARY KEY,
    app_user_id TEXT,
    environment TEXT,
    event_type TEXT,
    payload JSONB NOT NULL,
    process_status TEXT NOT NULL DEFAULT 'pending',
    processed_at TIMESTAMPTZ,
    error TEXT,
    received_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_e_revenuecat_event_status
    ON tapaton.e_revenuecat_event (process_status, received_at);

CREATE INDEX idx_e_revenuecat_event_user
    ON tapaton.e_revenuecat_event (app_user_id);

-- file: e_account_delete_request.sql
CREATE TABLE tapaton.e_account_delete_request (
    request_id TEXT PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    reason TEXT,
    process_status TEXT NOT NULL DEFAULT 'pending',
    processed_at TIMESTAMPTZ,
    error TEXT,
    requested_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX uniq_e_account_delete_request_pending_user
    ON tapaton.e_account_delete_request (user_id)
    WHERE process_status = 'pending';

CREATE INDEX idx_e_account_delete_request_status
    ON tapaton.e_account_delete_request (process_status, requested_at);

CREATE INDEX idx_e_account_delete_request_user
    ON tapaton.e_account_delete_request (user_id, requested_at);

COMMIT;

