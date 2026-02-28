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
