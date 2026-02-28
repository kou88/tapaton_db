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
