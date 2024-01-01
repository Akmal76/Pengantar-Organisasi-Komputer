// Akmal Ramadhan - POK B - 2206081534
// Lab 5 - Instructions + Register Operations
// Latihan 1 : Sama Tapi Beda?
// Kode Asdos: KD

.include "m8515def.inc"		// Memasukkan definisi tipe prosesor
.def result = r2			// Definisikan "result" sebagai register r2

// ---------- AMBIL ALAMAT DATA ----------
main:
	ldi ZH, HIGH(2*DATA)	// Load high byte alamat DATA ke ZH
	ldi ZL, LOW(2*DATA)		// Load low byte alamat DATA ke ZL

// ---------- AWAL PERULANGAN ----------
loop:
	lpm						// Load program memory dari Z ke r0
	tst r0					// Cek apakah r0 == 0
	breq stop				// Jika iya, lompat ke label stop
	mov r16, r0				// Pindahkan isi dari r0 ke r16

// ---------- FUNGSI 1 ----------
funct1:
	cpi r16, 3				// Bandingkan isi r16 dengan 3
	brlt funct2				// Jika r16 < 3, lompat ke label funct2
	subi r16, 3				// Kurangkan r16 dengan 3 atau r16 -= 3
	rjmp funct1				// Lakukan loop funct1

// Dari fungsi diatas, bisa disimpulkan bahwa funct1 mencari nilai
// (DATA[i] % 3) dimana i adalah byte alamat untuk DATA.

// ---------- FUNGSI 2 ----------
funct2:						
	add r1, r16				// Tambahkan r1 dengan r16 atau r1 += r16
	adiw ZL, 1				// Pindahkan pointer ke byte selanjutnya (ZL += 1)
	rjmp loop				// Kembali keatas yaitu label loop

// Dari fungsi diatas, hasil dari funct1 tadi ditambahkan pada register
// result atau r2. Sehingga dapat disimpulkan bahwa program ini menghitung jumlahan
// bilangan pada DATA yang dimodulo dengan 3.

// ---------- AKHIR PERULANGAN ----------
stop:
	mov result, R1			// Pindahkan isi dari r1 ke result (r2)

// ---------- AKHIR PROGRAM ----------
forever:
	rjmp forever			// Infinite loop

// ---------- INISIALISASI DATA ----------
DATA:
.db 2, 11, 7, 8				// Data array
.db 0, 0					// Padding data

// ---------- HASIL AKHIR ----------
// Nilai register result atau r2 di akhir pogram yaitu 0x07
// Penjelasan sesuai simpulan yang diperoleh:
// = (2 % 3) + (11 % 3) + (7 % 3) + (8 % 3)
// = 2 + 2 + 1 + 2
// = 7
