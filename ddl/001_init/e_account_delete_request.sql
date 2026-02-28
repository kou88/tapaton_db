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
