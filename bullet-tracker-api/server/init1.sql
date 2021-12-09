--C:\Program Files\PostgreSQL\12\bin\pg_dump.exe --file "C:\\Users\\dfarr\\OneDrive\\DOCUME~1\\bulletdb" --host "localhost" --port "5432" --username "postgres" --no-password --verbose --format=p --no-owner --no-comments "bullets"
-- Table: categories

-- DROP TABLE categories;

CREATE TABLE categories
(
    categoryid SERIAL NOT NULL,
    CONSTRAINT categories_pkey PRIMARY KEY (categoryid),
    category_name character varying(20) COLLATE pg_catalog."default" DEFAULT 'Unknown'::character varying,
)
-- Table: bullets

-- DROP TABLE bullets;

CREATE TABLE bullets
(   bulletid SERIAL NOT NULL,
    CONSTRAINT bullets_pkey PRIMARY KEY (bulletid),
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
    CONSTRAINT "bullets_CategoryId_fkey" FOREIGN KEY (category_id)
        REFERENCES categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

-- Table: bullets_categories_join

-- DROP TABLE bullets_categories_join;

CREATE TABLE bullets_categories_join
(
    relationshipid SERIAL,
    CONSTRAINT bullets_categories_join_pkey PRIMARY KEY (relationshipid),
    category_id integer NOT NULL,
    bullet_id integer NOT NULL,
    CONSTRAINT bulletid FOREIGN KEY (bullet_id)
        REFERENCES bullets (bulletid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT categoryid FOREIGN KEY (category_id)
        REFERENCES categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)
