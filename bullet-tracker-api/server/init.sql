-- Table: public.bullets

-- DROP TABLE public.bullets;

CREATE TABLE public.bullets
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
    bulletid integer NOT NULL DEFAULT nextval('bullets_bulletid_seq'::regclass),
    CONSTRAINT bullets_pkey PRIMARY KEY (bulletid),
    CONSTRAINT "bullets_CategoryId_fkey" FOREIGN KEY (category_id)
        REFERENCES public.categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public.bullets
    OWNER to postgres;

COMMENT ON COLUMN public.bullets.creation_date
    IS 'Date of Bullet Item Creation';

COMMENT ON COLUMN public.bullets.start_date
    IS 'Date of Bullet Action Start';

COMMENT ON COLUMN public.bullets.end_date
    IS 'Date of Bullet Action End';

-- Table: public.bullets_categories_join

-- DROP TABLE public.bullets_categories_join;

CREATE TABLE public.bullets_categories_join
(
    relationshipid integer NOT NULL DEFAULT nextval('bullets_categories_join_relationshipid_seq'::regclass),
    category_id integer NOT NULL,
    bullet_id integer NOT NULL,
    CONSTRAINT bullets_categories_join_pkey PRIMARY KEY (relationshipid),
    CONSTRAINT bulletid FOREIGN KEY (bullet_id)
        REFERENCES public.bullets (bulletid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT categoryid FOREIGN KEY (category_id)
        REFERENCES public.categories (categoryid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE public.bullets_categories_join
    OWNER to postgres;

-- Table: public.categories

-- DROP TABLE public.categories;

CREATE TABLE public.categories
(
    categoryid integer NOT NULL DEFAULT nextval('"Categories_CategoryId_seq"'::regclass),
    category_name character varying(20) COLLATE pg_catalog."default" DEFAULT 'Unknown'::character varying,
    CONSTRAINT "Categories_pkey" PRIMARY KEY (categoryid)
)

TABLESPACE pg_default;

ALTER TABLE public.categories
    OWNER to postgres;

COMMENT ON TABLE public.categories
    IS 'Bullet Types';

COMMENT ON COLUMN public.categories.categoryid
    IS 'Primary Key of Categories';

COMMENT ON COLUMN public.categories.category_name
    IS 'Type of Bullet';