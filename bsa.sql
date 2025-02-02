PGDMP  2    7                |           bsa_db    15.7    16.3 V    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            w           1262    24592    bsa_db    DATABASE     {   CREATE DATABASE bsa_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Ukraine.1251';
    DROP DATABASE bsa_db;
                postgres    false            _           1247    24824    gender    TYPE     @   CREATE TYPE public.gender AS ENUM (
    'male',
    'female'
);
    DROP TYPE public.gender;
       public          postgres    false            \           1247    24816    role    TYPE     W   CREATE TYPE public.role AS ENUM (
    'leading',
    'supporting',
    'background'
);
    DROP TYPE public.role;
       public          postgres    false            �            1255    24956    check_main_photo()    FUNCTION     i  CREATE FUNCTION public.check_main_photo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  
    IF NEW.is_main_photo THEN
        PERFORM 1 FROM person_photos WHERE person_id = NEW.person_id AND is_main_photo = TRUE;
        IF FOUND THEN
            RAISE EXCEPTION 'Person already has a main photo';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.check_main_photo();
       public          postgres    false            �            1255    24986    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public          postgres    false            �            1259    24931 
   characters    TABLE     ]  CREATE TABLE public.characters (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    role public.role,
    movie_id integer NOT NULL,
    person_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.characters;
       public         heap    postgres    false    860            �            1259    24930    characters_id_seq    SEQUENCE     �   CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.characters_id_seq;
       public          postgres    false    229            x           0    0    characters_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;
          public          postgres    false    228            �            1259    24878    favorite_movies    TABLE     
  CREATE TABLE public.favorite_movies (
    id integer NOT NULL,
    user_id integer NOT NULL,
    movie_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.favorite_movies;
       public         heap    postgres    false            �            1259    24877    favorite_movies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorite_movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.favorite_movies_id_seq;
       public          postgres    false    223            y           0    0    favorite_movies_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.favorite_movies_id_seq OWNED BY public.favorite_movies.id;
          public          postgres    false    222            �            1259    24752    files    TABLE     s  CREATE TABLE public.files (
    id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    mime_type character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.files;
       public         heap    postgres    false            �            1259    24751    files_id_seq    SEQUENCE     �   CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.files_id_seq;
       public          postgres    false    215            z           0    0    files_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;
          public          postgres    false    214            �            1259    24897    genres    TABLE       CREATE TABLE public.genres (
    id integer NOT NULL,
    genre character varying(255) NOT NULL,
    movie_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.genres;
       public         heap    postgres    false            �            1259    24896    genres_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.genres_id_seq;
       public          postgres    false    225            {           0    0    genres_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;
          public          postgres    false    224            �            1259    24855    movies    TABLE       CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    budget integer DEFAULT 0 NOT NULL,
    duration time without time zone NOT NULL,
    country character varying(255),
    release_date date,
    director_id integer,
    poster_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT movies_country_check CHECK (((country)::text ~ '^[A-Za-z ]+$'::text))
);
    DROP TABLE public.movies;
       public         heap    postgres    false            �            1259    24854    movies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.movies_id_seq;
       public          postgres    false    221            |           0    0    movies_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;
          public          postgres    false    220            �            1259    24911    person_photos    TABLE     3  CREATE TABLE public.person_photos (
    id integer NOT NULL,
    is_main_photo boolean DEFAULT false,
    person_id integer NOT NULL,
    photo_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.person_photos;
       public         heap    postgres    false            �            1259    24910    person_photos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.person_photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.person_photos_id_seq;
       public          postgres    false    227            }           0    0    person_photos_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.person_photos_id_seq OWNED BY public.person_photos.id;
          public          postgres    false    226            �            1259    24830    persons    TABLE     �  CREATE TABLE public.persons (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    biography text,
    date_of_birth date,
    gender public.gender,
    country character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_no_comma_in_country CHECK ((POSITION((','::text) IN (country)) = 0))
);
    DROP TABLE public.persons;
       public         heap    postgres    false    863            �            1259    24829    persons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.persons_id_seq;
       public          postgres    false    219            ~           0    0    persons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.persons_id_seq OWNED BY public.persons.id;
          public          postgres    false    218            �            1259    24763    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    avatar_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    24762    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    217                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    216            �           2604    24934    characters id    DEFAULT     n   ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);
 <   ALTER TABLE public.characters ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    24881    favorite_movies id    DEFAULT     x   ALTER TABLE ONLY public.favorite_movies ALTER COLUMN id SET DEFAULT nextval('public.favorite_movies_id_seq'::regclass);
 A   ALTER TABLE public.favorite_movies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    24755    files id    DEFAULT     d   ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);
 7   ALTER TABLE public.files ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    24900 	   genres id    DEFAULT     f   ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);
 8   ALTER TABLE public.genres ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    24858 	   movies id    DEFAULT     f   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    24914    person_photos id    DEFAULT     t   ALTER TABLE ONLY public.person_photos ALTER COLUMN id SET DEFAULT nextval('public.person_photos_id_seq'::regclass);
 ?   ALTER TABLE public.person_photos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    24833 
   persons id    DEFAULT     h   ALTER TABLE ONLY public.persons ALTER COLUMN id SET DEFAULT nextval('public.persons_id_seq'::regclass);
 9   ALTER TABLE public.persons ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    24766    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            q          0    24931 
   characters 
   TABLE DATA           n   COPY public.characters (id, name, description, role, movie_id, person_id, created_at, updated_at) FROM stdin;
    public          postgres    false    229   �m       k          0    24878    favorite_movies 
   TABLE DATA           X   COPY public.favorite_movies (id, user_id, movie_id, created_at, updated_at) FROM stdin;
    public          postgres    false    223   6o       c          0    24752    files 
   TABLE DATA           [   COPY public.files (id, file_name, mime_type, key, url, created_at, updated_at) FROM stdin;
    public          postgres    false    215   �o       m          0    24897    genres 
   TABLE DATA           M   COPY public.genres (id, genre, movie_id, created_at, updated_at) FROM stdin;
    public          postgres    false    225   jp       i          0    24855    movies 
   TABLE DATA           �   COPY public.movies (id, title, description, budget, duration, country, release_date, director_id, poster_id, created_at, updated_at) FROM stdin;
    public          postgres    false    221   �p       o          0    24911    person_photos 
   TABLE DATA           g   COPY public.person_photos (id, is_main_photo, person_id, photo_id, created_at, updated_at) FROM stdin;
    public          postgres    false    227   s       g          0    24830    persons 
   TABLE DATA              COPY public.persons (id, first_name, last_name, biography, date_of_birth, gender, country, created_at, updated_at) FROM stdin;
    public          postgres    false    219   ss       e          0    24763    users 
   TABLE DATA           x   COPY public.users (id, username, first_name, last_name, email, password, avatar_id, created_at, updated_at) FROM stdin;
    public          postgres    false    217   �t       �           0    0    characters_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.characters_id_seq', 6, true);
          public          postgres    false    228            �           0    0    favorite_movies_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.favorite_movies_id_seq', 8, true);
          public          postgres    false    222            �           0    0    files_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.files_id_seq', 8, true);
          public          postgres    false    214            �           0    0    genres_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.genres_id_seq', 7, true);
          public          postgres    false    224            �           0    0    movies_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.movies_id_seq', 6, true);
          public          postgres    false    220            �           0    0    person_photos_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.person_photos_id_seq', 6, true);
          public          postgres    false    226            �           0    0    persons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.persons_id_seq', 6, true);
          public          postgres    false    218            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    216            �           2606    24940    characters characters_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_pkey;
       public            postgres    false    229            �           2606    24885 $   favorite_movies favorite_movies_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.favorite_movies DROP CONSTRAINT favorite_movies_pkey;
       public            postgres    false    223            �           2606    24761    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            postgres    false    215            �           2606    24904    genres genres_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public            postgres    false    225            �           2606    24866    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    221            �           2606    24919     person_photos person_photos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.person_photos DROP CONSTRAINT person_photos_pkey;
       public            postgres    false    227            �           2606    24840    persons persons_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.persons DROP CONSTRAINT persons_pkey;
       public            postgres    false    219            �           2606    24776    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            �           2606    24772    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            �           2606    24774    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    217            �           2620    24957 (   person_photos before_insert_person_photo    TRIGGER     �   CREATE TRIGGER before_insert_person_photo BEFORE INSERT ON public.person_photos FOR EACH ROW EXECUTE FUNCTION public.check_main_photo();
 A   DROP TRIGGER before_insert_person_photo ON public.person_photos;
       public          postgres    false    230    227            �           2620    24992 &   characters update_character_updated_at    TRIGGER     �   CREATE TRIGGER update_character_updated_at BEFORE UPDATE ON public.characters FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 ?   DROP TRIGGER update_character_updated_at ON public.characters;
       public          postgres    false    229    231            �           2620    24994 1   favorite_movies update_favorite_movies_updated_at    TRIGGER     �   CREATE TRIGGER update_favorite_movies_updated_at BEFORE UPDATE ON public.favorite_movies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 J   DROP TRIGGER update_favorite_movies_updated_at ON public.favorite_movies;
       public          postgres    false    231    223            �           2620    24988    files update_file_updated_at    TRIGGER     �   CREATE TRIGGER update_file_updated_at BEFORE UPDATE ON public.files FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 5   DROP TRIGGER update_file_updated_at ON public.files;
       public          postgres    false    231    215            �           2620    24991    genres update_genre_updated_at    TRIGGER     �   CREATE TRIGGER update_genre_updated_at BEFORE UPDATE ON public.genres FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 7   DROP TRIGGER update_genre_updated_at ON public.genres;
       public          postgres    false    231    225            �           2620    24990    movies update_movie_updated_at    TRIGGER     �   CREATE TRIGGER update_movie_updated_at BEFORE UPDATE ON public.movies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 7   DROP TRIGGER update_movie_updated_at ON public.movies;
       public          postgres    false    221    231            �           2620    24993 ,   person_photos update_person_photo_updated_at    TRIGGER     �   CREATE TRIGGER update_person_photo_updated_at BEFORE UPDATE ON public.person_photos FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 E   DROP TRIGGER update_person_photo_updated_at ON public.person_photos;
       public          postgres    false    227    231            �           2620    24989     persons update_person_updated_at    TRIGGER     �   CREATE TRIGGER update_person_updated_at BEFORE UPDATE ON public.persons FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 9   DROP TRIGGER update_person_updated_at ON public.persons;
       public          postgres    false    219    231            �           2620    24987    users update_user_updated_at    TRIGGER     �   CREATE TRIGGER update_user_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 5   DROP TRIGGER update_user_updated_at ON public.users;
       public          postgres    false    231    217            �           2606    24941 #   characters characters_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_movie_id_fkey;
       public          postgres    false    3255    229    221            �           2606    24946 $   characters characters_person_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_person_id_fkey;
       public          postgres    false    219    229    3253            �           2606    24891 -   favorite_movies favorite_movies_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.favorite_movies DROP CONSTRAINT favorite_movies_movie_id_fkey;
       public          postgres    false    3255    221    223            �           2606    24886 ,   favorite_movies favorite_movies_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.favorite_movies DROP CONSTRAINT favorite_movies_user_id_fkey;
       public          postgres    false    223    217    3249            �           2606    24905    genres genres_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_movie_id_fkey;
       public          postgres    false    3255    225    221            �           2606    24867    movies movies_director_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.persons(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_director_id_fkey;
       public          postgres    false    219    221    3253            �           2606    24872    movies movies_poster_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES public.files(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_poster_id_fkey;
       public          postgres    false    215    221    3245            �           2606    24920 *   person_photos person_photos_person_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.person_photos DROP CONSTRAINT person_photos_person_id_fkey;
       public          postgres    false    3253    227    219            �           2606    24925 )   person_photos person_photos_photo_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.person_photos
    ADD CONSTRAINT person_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.files(id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.person_photos DROP CONSTRAINT person_photos_photo_id_fkey;
       public          postgres    false    227    3245    215            �           2606    24777    users users_avatar_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.files(id);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_avatar_id_fkey;
       public          postgres    false    215    217    3245            �           2606    24951    users users_avatar_id_fkey1    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_avatar_id_fkey1 FOREIGN KEY (avatar_id) REFERENCES public.files(id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_avatar_id_fkey1;
       public          postgres    false    217    3245    215            q   b  x����n�0�sx
� �MӦi��e�u[�ԩ���/�&�q��S�$����L�l6M�����B�T J�#h�XZa��$5��L�!�YJ5SZ�^����N@��2YO�d������H���ص�#/)ʑ����h�� ׍co%�X�3�>*<�*>�wʩ��hu��=�\�[C,R0�<z*5
�9T��Tl��q�Ѐ�:�[kx��c>رP[�f�Ğt?FbS��][�I�ء;³pY�k���D��l_�&�����o8Wr��=�������Q����g9ؓ�=c��(�8t�*9��B=&���1�x�[I���lN�]-I7��,_��h����j      k   V   x����� �w3E �IB�,�������ur�~t��Y�'�"������9I�!I�tI7�F&eJr�WmۋR[�f��V      c   �   x���M
�0�������D#���PBZ�j����BI�lg����l&����w�k6β�[������Ș��ٿ-},3Kŀ�j�n������B�n���<	\#�
��e6v�?�l�N��be$
+#'ǊS'�XI�3��:��:����J�'Q�HT��"'G��NR�2�+#'ǊS'�XɝB~>�C      m   s   x�3�N��u��4�4202�50�52S02�25�22ճ037��'�e��R����iD�~cN���TNc2��p:&�d��q��i�)�cJYj^IiQ*�)�f��aF���P$W� 6�]      i     x����r�0���S����m���L�Iw��c�1HTq��=�8v7^�Ҡ�(�LCC�ֈ�iGe���Cc�`O���y��c��M0z���#���i�B�F����Y�ΏH�ZVk�~��fi�>$Y)��x*�8�%H�^��Y��WUU�K)��I�O6�E;�g!�G�����z2��f�� �����O��/�\]Q�3eV�|v��\���-�\<�� �u�f�'���õ	��Q��v��[;h��	��ݻ���.�y�%ۙLY�IYL^~Bw�F�*�z4���ƣ|�Aau8Mx{l�O]�n�8����\^O�)���\M�?18��N6�F�6|6t�9;��	��M5�vgn�=8�M���#r1Z���Q�5��;��(󋤬�2�N�<ɹ�w_��t,g@�CG�nX"�$����Fq���0{k<� ���C��迬���ǎ�W�-�3�
�0Dݳz;JQ7L��oڵ�S~ׯƘ<���������Aqk�d2ƚ���b���-?�      o   Q   x����� �3�"��⏠�����M9Xs=mOS�	�3;����=4S��Yj|���^����XM;����`5}y#�F�      g   7  x����J�0���ӧ�,#M���MQq(S���؞m�6'�|}��)(�]%����?	,<���b��}'^��#�5���L��<�7l�mM�M����kO<���
�(�L�Ö�e1%U&d)T+5ͳi��U%�I��Q��z��y�Y�ܶhટ��Z��n��JF�� �?��Ӗ����1l,�:%��a�$��T�T���b�t�+zg�Va�s�����h��ۆ�U_%IK��K�W�+��w��u���?��Af<dHK!!�K30G��&x����1R��)h����>A3I�4�1��g���Q}f���      e   �   x���A
�0����)z%���Z�g(H��V4#���oԭ�p�����?�j����rw?���k�1�i�yl%P I:�yDم�Hu��X)));x��x�A!6(�.��p�$��t��U-{7�t�������ғ��e[ّg��-ʵ¶+IE8:w$�c!���p     