# Database ER Diagram

```mermaid
erDiagram
    USER ||--o{ FILE : has
    USER ||--o{ FAVOTIRE_MOVIES : has
    USER {
        int id PK
        varchar(255) username 
        varchar(255) first_name
        varchar(255) last_name
        varchar(255) email
        varchar(255) password
        int avatar_id FK
        timestamp created_at
        timestamp updated_at
    }
    FAVOTIRE_MOVIES {
        int id PK
        int user_id FK
        int movie_id FK
        timestamp created_at
        timestamp updated_at
    }
    FILE ||--o{ PERSON_PHOTO : contains
    FILE {
        int id PK
        varchar(255) file_name
        varchar(255) mime_type
        varchar(255) key
        varchar(255) url
        timestamp created_at
        timestamp updated_at
    }
    MOVIE ||--o{ FAVOTIRE_MOVIES : has
    MOVIE ||--o{ FILE : has
    MOVIE ||--o{ GENRE : has
    MOVIE ||--o{ CHARACTER : contains
    MOVIE ||--o{ PERSON : has
    MOVIE {
        int id PK
        varchar(255) title
        text description
        int budget
        time duration
        varchar(255) country
        date release_date
        int director_id FK
        int poster_id FK
        timestamp created_at
        timestamp updated_at
    }
    GENRE {
        int id PK
        varchar(255) genre
        int movie_id FK
        timestamp created_at
        timestamp updated_at
    }
    PERSON ||--o{ PERSON_PHOTO : contains
    PERSON ||--o{ CHARACTER : has
    PERSON {
        int id PK
        varchar(255) first_name
        varchar(255) last_name
        text biography
        date date_of_birth
        varchar(255) gender "ENUM('male', 'female')"
        varchar(255) country
        timestamp created_at
        timestamp updated_at 
    }
    PERSON_PHOTO {
        int id PK
        boolean is_main_photo
        int person_id FK 
        int photo_id FK
        timestamp created_at
        timestamp updated_at
    }
    CHARACTER {
        int id PK
        varchar(255) name
        text description
        varchar(255) role "ENUM('leading', 'supporting', 'background')"
        int movie_id FK
        int person_id FK
        timestamp created_at
        timestamp updated_at
    }
