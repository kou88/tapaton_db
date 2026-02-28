-- generated file: 00002_002_add_item.sql
-- source directory: ddl/002_add_item

BEGIN;

-- file: r_resource_div.sql
CREATE TABLE tapaton.r_resource_div (
    resource_div INTEGER,
    label TEXT NOT NULL,
    PRIMARY KEY (resource_div)
);

-- file: r_item_div.sql
CREATE TABLE tapaton.r_item_div (
    item_div INTEGER,
    label TEXT NOT NULL,
    PRIMARY KEY (item_div)
);

-- file: r_item_source_div.sql
CREATE TABLE tapaton.r_item_source_div (
    item_source_div INTEGER,
    label TEXT NOT NULL,
    PRIMARY KEY (item_source_div)
);

-- file: r_resource.sql
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

-- file: r_item.sql
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

-- file: r_item_data_format.sql
CREATE TABLE tapaton.r_item_data_format (
    item_div INTEGER REFERENCES tapaton.r_item_div(item_div) ON DELETE RESTRICT NOT NULL,
    version INTEGER NOT NULL,
    sample_data JSONB NOT NULL,
    comment TEXT NOT NULL,

    PRIMARY KEY (item_div, version)
);

-- file: r_food_2020.sql
-- 日本食品標準成分表
--
CREATE TABLE tapaton.r_food_2020 (
    food_number VARCHAR(10) NOT NULL, -- 食 品 番 号
    index_number VARCHAR(10) NOT NULL, -- 索 引 番 号

    food_name TEXT, -- 食 品 名
    refuse_rate TEXT, -- 廃 棄 率
    enerc TEXT, -- エネルギー (kJ)
    enerc_kcal TEXT, -- エネルギー (kcal)
    water TEXT, -- 水 分
    -------------- たんぱく質 ----------------
    protcaa TEXT, -- アミノ酸組成によるたんぱく質
    prot TEXT, -- たんぱく質
    -------------- 脂質 ----------------
    fatnlea TEXT, -- 脂肪酸のトリアシルグリセロール当量
    chole TEXT, -- コレステロール
    fat TEXT, -- 脂質
    -------------- 炭水化物 ----------------
    choavlm TEXT, -- 利用可能炭水化物 (単糖当量)
    choavlm_asta TEXT, -- 利用可能炭水化物 (単糖当量)*
    choavl TEXT, -- 利用可能炭水化物（質量計）
    choavl_df TEXT, -- 差引き法による 利用可能炭水化物
    choavl_df_asta TEXT, -- 差引き法による 利用可能炭水化物*
    fib TEXT, -- 食物繊維総量
    polyl TEXT, -- 糖アルコール
    chocdf TEXT, -- 炭水化物

    oa TEXT, -- 有機酸
    ash TEXT, -- 灰分

    -------------- 無機物 ----------------
    na TEXT, -- ナ ト リ ウ ム
    k TEXT, -- カ リ ウ ム
    ca TEXT, -- カ ル シ ウ ム
    mg TEXT, -- マ グ ネ シ ウ ム
    p TEXT, -- リ ン
    fe TEXT, -- 鉄
    zn TEXT, -- 亜 鉛
    cu TEXT, -- 銅
    mn TEXT, -- マ ン ガ ン
    id TEXT, -- ヨ ウ 素
    se TEXT, -- セ レ ン
    cr TEXT, -- ク ロ ム
    mo TEXT, -- モリブデン

    -------------- ビタミンA ----------------
    retol TEXT, -- レチノール
    carta TEXT, -- α|カロテン
    cartb TEXT, -- β|カロテン
    crypxb TEXT, -- β|クリプトキサンチン
    cartbeq TEXT, -- β|カロテン当量
    vita_rae TEXT, -- レチノール活性当量

    -------------- ビタミンD ----------------
    vitd TEXT, -- ビタミンD

    -------------- ビタミンE ----------------
    tocpha TEXT, -- α|トコフェロール
    tocpb TEXT, -- β|トコフェロール
    tocpg TEXT, -- γ|トコフェロール
    tocpd TEXT, -- δ|トコフェロール

    -------------- ビタミン他 ----------------
    vitk TEXT, -- ビタミンK
    thia TEXT, -- ビ タ ミ ン B1
    ribf TEXT, -- ビ タ ミ ン B2
    nia TEXT, -- ナイアシン
    ne TEXT, -- ナイアシン当量
    vitb6a TEXT, -- ビ タ ミ ン B6
    vitb12 TEXT, -- ビ タ ミ ン B12
    fol TEXT, -- 葉 酸
    pantac TEXT, -- パントテン酸
    biot TEXT, -- ビ オ チ ン
    vitc TEXT, -- ビタミンC

    -------------- 他 ----------------
    alc TEXT, -- アルコール
    nacl_eq TEXT, -- 食塩相当量

    -------------- 備考 ----------------
    description TEXT -- 備 考
);

-- file: c_item_has_resource.sql
CREATE TABLE tapaton.c_item_has_resource (
    item_id UUID REFERENCES tapaton.r_item(item_id) ON DELETE RESTRICT NOT NULL,
    resource_id UUID REFERENCES tapaton.r_resource(resource_id) ON DELETE RESTRICT NOT NULL,
    sort_num INTEGER NOT NULL,
    PRIMARY KEY (item_id, resource_id)
);

-- file: c_item_related_food.sql
CREATE TABLE tapaton.c_item_related_food (
    item_id UUID REFERENCES tapaton.r_item(item_id) ON DELETE RESTRICT NOT NULL,
    food_2020_id UUID REFERENCES tapaton.r_food_2020(food_2020_id) ON DELETE RESTRICT NOT NULL,
    PRIMARY KEY (item_id, food_2020_id)
);

COMMIT;

