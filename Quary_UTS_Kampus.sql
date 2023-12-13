USE kampus;

CREATE TABLE makul (
	id_makul INT PRIMARY KEY,
	kode_makul VARCHAR(5),
	nama_makul VARCHAR(50),
	bobot_makul INT
);

CREATE TABLE mahasiswa (
	id_mahasiswa INT PRIMARY KEY,
	nim VARCHAR(29),
	nama VARCHAR(50),
);

CREATE TABLE krs (
	id_krs INT PRIMARY KEY,
	id_makul INT FOREIGN KEY REFERENCES makul(id_makul),
	id_mahasiswa INT FOREIGN KEY REFERENCES mahasiswa(id_mahasiswa),
	nilai_angka INT,
	nilai_huruf VARCHAR(5),
);

INSERT INTO makul 
(id_makul,kode_makul,nama_makul,bobot_makul)
VALUES 
(1,'MK1','Pemograman Basis Data',4),
(2,'MK2','Algoritma dan Struktur Data',2),
(3,'MK3','Pemograman Web',4)
;

 
INSERT INTO mahasiswa
(id_mahasiswa,nim,nama)
VALUES
(1,'21.11.0001','Arman'),
(2,'21.11.0002','Burhan'),
(3,'21.11.0003','Cindy')
;

INSERT INTO krs
(id_krs,id_makul,id_mahasiswa,nilai_angka,nilai_huruf)
VALUES
(1,1,1,80,'A'),
(2,1,2,70,'B'),
(3,1,3,60,'C'),
(4,2,1,60,'C'),
(5,2,2,70,'B'),
(6,2,3,80,'A'),
(7,3,1,75,'B'),
(8,3,2,75,'B')
;

SELECT * FROM makul;
SELECT * FROM mahasiswa;
SELECT * FROM krs;

--1
/*A. Buatlah Sebuah INNER JOIN Statement untuk mrnampilkan data
	(NIM,Nama,Nama_Makul,Nilai_Angka,dan Hururf)
	kemudian urutkan secara ascending berdasrkan NIM	*/

	SELECT mahasiswa.nim, mahasiswa.nama, makul.nama_makul, krs.nilai_angka, krs.nilai_huruf	--Menampilkan (Tabel.kolom)
		FROM krs inner join mahasiswa															S	--Dari tabel krs digabungkan ke tabel mahasiswa
			on krs.id_mahasiswa = mahasiswa.id_mahasiswa inner join makul 
			on krs.id_makul = makul.id_makul 
		order by mahasiswa.nim
	ASC;
/*B. Menggunakan Subquary,tampilkan nama nim mahasiswa yang tidak mengambil mata kuliah Pemograman Web */
	SELECT nama,nim FROM Mahasiswa
		WHERE id_mahasiswa IN
		(
			SELECT id_mahasiswa FROM krs
			WHERE id_makul IN
		(
			SELECT id_makul FROM makul 
			WHERE nama_makul = 'Pemograman Web'
		)
	);

/*2. Buat sebuah transaction dengan diawali perintah START TRANSACTION, daftarkan perintah DML berikut ini:
	a. Masukkan sebuah baris baru ke tabel makul, kode_makul: MK4, nama_makul: Pemrograman Beorientasi Objek, bobot_makul: 4
	b. Tampilkan seluruh baris dari tabel makul
	c. Hapus baris dengan kode_makul: MK3
	d. Simpan semua perubahan yang terjadi secara permanen ke dalam basisdata */

	
	--A
	BEGIN TRANSACTION;
	INSERT INTO makul VALUES (4,'MK4','Pemrograman Berorientasi Objek',4);

	--B
	SELECT * FROM makul;  
	
	--C
	DELETE FROM makul WHERE kode_makul= 'MK4'

	--D
	COMMIT;


/*3. Pada cursor terdapat beberapa perintah antara lain: DECLARE, OPEN, CLOSE, dan FETCH statement. 
	Jelaskan secara singkat fungsi masing-masing perintah tersebut! */
	DECLARE: memproses setiap baris yang dikembalikan oleh kueri.
	OPEN : Untuk membuak cursor yang elah terbuka sebelumnya.
	CLOSE : Untuk menutup cursor yang telah dideklarasikan sebelumnya.
	FETCH STATEMENT : Untuk mengambil baris data yang sedang aktif pada cursor

/*4. Buat sebuah SELECT statement dengan CASE, untuk menampilkan kode dan nama makul, dan keterangan SKS. Ketentuan kolom keterangan SKS:
	a. Jika sks sama dengan 2, maka tampilkan “Mata kuliah 2 sks, durasi ujian maksimal 75 menit”
	b. Jika sks sama dengan 4, maka tampilkan “Mata kuliah 4 sks, durasi ujian maksimal 100 menit” */


SELECT
    kode_makul,
    nama_makul,
    CASE
/*A*/	WHEN bobot_makul = 2 THEN 'Mata kuliah 2 sks, durasi ujian maksimal 75 menit'
/*B*/	WHEN bobot_makul = 4 THEN 'Mata kuliah 4 sks, durasi ujian maksimal 100 menit'
        ELSE 'Keterangan SKS tidak diketahui'
    END AS keterangan_bobot_makul
FROM
    makul;







	


