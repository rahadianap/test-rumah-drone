# Initial Setup

## 1. Clone repository
Launch a cmd and clone the project.

`git clone https://github.com/rahadianap/test-rumah-drone.git`

## 2. Lakukan perintah cd ke dalam folder.

`cd test-rumah-drone`

## 3. Install composer dependencies.

`composer install`

## 4. Install NPM dependencies.

`npm install`

## 5. Copy .env file
Copy file .env.example dan rename menjadi .env.

`cp .env.example .env`

## 6. Generate app encryption key
Jalankan perintah berikut untuk generate encryption key.

`php artisan key:generate`

## 7. Buat sebuah database baru untuk menyimpan data.

## 8. Konfigurasi .env.
Konfigurasi .env file yang sudah dibuat tadi, masukkan pengaturan database sesuai dengan yang sudah dibuat.

## 10. Database migration.
Jalankan perintah berikut untuk menjalankan migration (create table) atau import file .sql yang tersedia.

`php artisan migrate`

## 11. Jalankan server
Untuk menjalankan service, cukup ketikkan perintah berikut.

`php artisan serve`

# Fitur
## 1. Admin
### 1.1 List Produk

![alt text](https://github.com/rahadianap/test-rumah-drone/blob/main/admin_product.png?raw=true)

### 1.2 Export PDF

![alt text](https://github.com/rahadianap/test-rumah-drone/blob/main/admin_report.png?raw=true)

## 2. Staff
### 2.1 List Produk

![alt text](https://github.com/rahadianap/test-rumah-drone/blob/main/staff_product.png?raw=true)

### 2.2 CRUD Delivery

![alt text](https://github.com/rahadianap/test-rumah-drone/blob/main/staff_delivery.png?raw=true)

### 2.3 Notifikasi Stok Minimum

![alt text](https://github.com/rahadianap/test-rumah-drone/blob/main/stock_notif.png?raw=true)

# Initial Data
Untuk login, bisa menggunakan `name: admin` `password: admin123` untuk akses admin atau `name: staff` `password: staff123` untuk akses staff. (Jika sudah import .sql file).
