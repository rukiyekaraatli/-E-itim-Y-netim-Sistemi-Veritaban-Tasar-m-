# 🎓 Egitim Yonetim Sistemi Veritabani Tasarimi

Merhaba! 👋 Bu repo, kullanıcıların eğitimlere katıldığı, sertifika kazandığı ve blog gönderileri paylaştığı bir **Eğitim Yönetim Sistemi** için kapsamlı bir **veritabanı tasarımı** sunar. 🚀

---

## 🧠 Projenin Amacı

Bu proje, modern bir eğitim platformunda ihtiyaç duyulan tüm temel veritabanı yapılarını barındırır:

- Kullanıcı (üye) kayıtları
- Eğitim içerikleri ve kategorileri
- Katılım bilgileri
- Sertifika yönetimi
- Blog gönderileri

Veritabanı, **ilişkisel bütünlüğü sağlayan yabancı anahtarlar**, **tekil kısıtlamalar** ve **detaylı şema diyagramı** ile yapılandırılmıştır.

---

## 🛠️ Kullanılan Teknolojiler

- **PostgreSQL**
- **pgAdmin 4**
- **dbdiagram.io** (şema diyagramı için)
- **SQL (DDL)**

---

## 📦 Tablolar ve Açıklamalar

| Tablo Adı              | Açıklama |
|------------------------|----------|
| `members`              | Üye bilgilerini saklar |
| `courses`              | Eğitimleri saklar |
| `categories`           | Eğitim kategorileri |
| `enrollments`          | Üyelerin eğitimlere katılım bilgileri |
| `certificates`         | Sertifika bilgileri |
| `certificate_assignments` | Hangi üyeye hangi sertifikanın verildiği |
| `blog_posts`           | Üyelerin blog gönderileri |

---

## 📌 Veritabanı Şeması

Aşağıda, tablo ilişkilerini ve veri tiplerini gösteren diyagramın ekran görüntüsünü bulabilirsiniz:


![db-schema](https://github.com/user-attachments/assets/ef3aded1-2808-4258-b711-b51ea33f31f9)


---
