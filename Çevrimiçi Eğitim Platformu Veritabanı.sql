-- "Çevrimiçi Eğitim Platformu" Veritabanı Oluşturma 

-- 1. Üyeler (Members) Tablosu

-- MEMBERS: Kullanıcı bilgilerini saklamak için oluşturulmuş tablo.
-- Her üye için benzersiz bir ID ve diğer gerekli bilgiler saklanır.
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,              -- Birincil anahtar: Benzersiz kullanıcı ID
    username VARCHAR(50) UNIQUE NOT NULL,      -- Tekil anahtar: Kullanıcı adı, boş olamaz
    email VARCHAR(100) UNIQUE NOT NULL,        -- Tekil anahtar: E-posta, boş olamaz
    password VARCHAR(255) NOT NULL,            -- Şifre, boş olamaz
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Kayıt tarihi
    first_name VARCHAR(50),                    -- Kullanıcının adı
    last_name VARCHAR(50)                      -- Kullanıcının soyadı
);

-- 2. Eğitimler (Courses) Tablosu

-- COURSES: Eğitim bilgilerini saklamak için oluşturulmuş tablo.
-- Eğitimlerin adı, açıklaması, başlangıç ve bitiş tarihleri gibi bilgiler tutulur.
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,              -- Birincil anahtar: Benzersiz eğitim ID
    name VARCHAR(200) NOT NULL,                -- Eğitim adı
    description TEXT,                          -- Eğitim açıklaması
    start_date DATE NOT NULL,                  -- Başlangıç tarihi, boş olamaz
    end_date DATE NOT NULL,                    -- Bitiş tarihi, boş olamaz
    instructor VARCHAR(100)                   -- Eğitmen adı
);

-- 3. Kategoriler (Categories) Tablosu

-- CATEGORIES: Eğitim kategorileri için tablo.
-- Eğitimleri kategorilere ayırmak için kullanılır (Örneğin: yapay zeka, siber güvenlik).
CREATE TABLE categories (
    category_id SMALLINT PRIMARY KEY,          -- Birincil anahtar: Benzersiz kategori ID
    name VARCHAR(100) NOT NULL                 -- Kategori adı
);

-- 4. Katılımlar (Enrollments) Tablosu

-- ENROLLMENTS: Kullanıcıların eğitimlere katılımını takip eden ara tablo.
-- Çok-çok ilişkisi: Bir kullanıcı birden fazla eğitime katılabilir ve eğitimlere birden fazla kişi katılabilir.
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,          -- Birincil anahtar: Benzersiz katılım ID
    member_id INTEGER NOT NULL,                -- Kullanıcı ID (Yabancı anahtar)
    course_id INTEGER NOT NULL,                -- Eğitim ID (Yabancı anahtar)
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Katılım tarihi
    
    CONSTRAINT fk_member_enrollment
        FOREIGN KEY (member_id)               -- Üye bilgilerini referans alır
        REFERENCES members(member_id)
        ON DELETE CASCADE,                    -- Üye silindiğinde katılım da silinir
    
    CONSTRAINT fk_course_enrollment
        FOREIGN KEY (course_id)               -- Eğitim bilgilerini referans alır
        REFERENCES courses(course_id)
        ON DELETE CASCADE,                    -- Eğitim silindiğinde katılım da silinir

    CONSTRAINT uc_member_course UNIQUE (member_id, course_id) -- Bir kullanıcı aynı eğitime birden fazla katılamaz
);

-- 5. Sertifikalar (Certificates) Tablosu

-- CERTIFICATES: Tamamlanan eğitimler için sertifika bilgilerini saklayan tablo.
-- Sertifikalar her katılımla ilişkilendirilir.
CREATE TABLE certificates (
    certificate_id SERIAL PRIMARY KEY,         -- Birincil anahtar: Benzersiz sertifika ID
    enrollment_id INTEGER UNIQUE NOT NULL,     -- Katılım ID (Yabancı anahtar)
    certificate_code VARCHAR(100) UNIQUE NOT NULL, -- Sertifika kodu, tekil olmalı
    issue_date DATE DEFAULT CURRENT_DATE,      -- Sertifika veriliş tarihi
    
    CONSTRAINT fk_enrollment_certificate
        FOREIGN KEY (enrollment_id)           -- Katılım bilgilerini referans alır
        REFERENCES enrollments(enrollment_id)
        ON DELETE CASCADE
);

-- 6. Sertifika Atamaları (CertificateAssignments) Tablosu

-- CERTIFICATE_ASSIGNMENTS: Sertifikaların kullanıcılara atanmasını takip eden tablo.
-- Hangi kullanıcı hangi sertifikayı almış, burada saklanır.
CREATE TABLE certificate_assignments (
    assignment_id SERIAL PRIMARY KEY,         -- Birincil anahtar: Benzersiz atama ID
    member_id INTEGER NOT NULL,               -- Kullanıcı ID (Yabancı anahtar)
    certificate_id INTEGER NOT NULL,          -- Sertifika ID (Yabancı anahtar)
    received_date DATE DEFAULT CURRENT_DATE,  -- Sertifika alım tarihi
    
    CONSTRAINT fk_member_assignment
        FOREIGN KEY (member_id)               -- Kullanıcı bilgilerini referans alır
        REFERENCES members(member_id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_certificate_assignment
        FOREIGN KEY (certificate_id)          -- Sertifika bilgilerini referans alır
        REFERENCES certificates(certificate_id)
        ON DELETE CASCADE,

    CONSTRAINT uc_member_certificate UNIQUE (member_id, certificate_id) -- Aynı sertifika birden fazla kez atanamaz
);

-- 7. Blog Gönderileri (BlogPosts) Tablosu

-- BLOG_POSTS: Kullanıcıların blog yazılarını saklayan tablo.
-- Her yazı bir kullanıcıya ait olup, başlık ve içerik gibi bilgileri içerir.
CREATE TABLE blog_posts (
    post_id SERIAL PRIMARY KEY,               -- Birincil anahtar: Benzersiz yazı ID
    title VARCHAR(255) NOT NULL,               -- Yazı başlığı
    content TEXT NOT NULL,                     -- Yazı içeriği
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Yayın tarihi
    author_id INTEGER NOT NULL,                -- Yazar ID (Yabancı anahtar)
    
    CONSTRAINT fk_author
        FOREIGN KEY (author_id)               -- Yazar bilgilerini referans alır
        REFERENCES members(member_id)
        ON DELETE CASCADE
);

