-- Table: bullets

-- DROP TABLE bullets;

CREATE TABLE bullets
(
    creation_date date NOT NULL,
    start_date date NOT NULL,
    end_date date,
    category_id integer NOT NULL,
    strength integer,
    summary character varying(120) COLLATE pg_catalog."default",
    narrative text COLLATE pg_catalog."default",
    user_id integer NOT NULL,
    bullet_format character varying(120) COLLATE pg_catalog."default",
    bullet_action character varying(120) COLLATE pg_catalog."default",
    bullet_impact character varying(120) COLLATE pg_catalog."default",
    bullet_result character varying(120) COLLATE pg_catalog."default",
    bulletid SERIAL,
    CONSTRAINT bullets_pkey PRIMARY KEY (bulletid),
    CONSTRAINT "bullets_CategoryId_fkey" FOREIGN KEY (category_id)
        REFERENCES categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE bullets
    OWNER to postgres;

COMMENT ON COLUMN bullets.creation_date
    IS 'Date of Bullet Item Creation';

COMMENT ON COLUMN bullets.start_date
    IS 'Date of Bullet Action Start';

COMMENT ON COLUMN bullets.end_date
    IS 'Date of Bullet Action End';

-- Table: bullets_categories_join

-- DROP TABLE bullets_categories_join;

CREATE TABLE bullets_categories_join
(
    relationshipid SERIAL,
    category_id integer NOT NULL,
    bullet_id integer NOT NULL,
    CONSTRAINT bullets_categories_join_pkey PRIMARY KEY (relationshipid),
    CONSTRAINT bulletid FOREIGN KEY (bullet_id)
        REFERENCES bullets (bulletid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT categoryid FOREIGN KEY (category_id)
        REFERENCES categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE bullets_categories_join
    OWNER to postgres;

-- Table: categories

-- DROP TABLE categories;

CREATE TABLE categories
(
    categoryid SERIAL,
    category_name character varying(20) COLLATE pg_catalog."default" DEFAULT 'Unknown'::character varying,
    CONSTRAINT "Categories_pkey" PRIMARY KEY (categoryid)
)

TABLESPACE pg_default;

ALTER TABLE categories
    OWNER to postgres;

COMMENT ON TABLE categories
    IS 'Bullet Types';

COMMENT ON COLUMN categories.categoryid
    IS 'Primary Key of Categories';

COMMENT ON COLUMN categories.category_name
    IS 'Type of Bullet';