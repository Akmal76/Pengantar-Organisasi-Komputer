// Akmal Ramadhan - POK B - 2206081534
// Lab 5 - Instructions + Register Operations
// Latihan 2 : MTK
// Kode Asdos: KD

.include "m8515def.inc"		// Memasukkan definisi tipe prosesor
.def a = r1					// Definisikan "a" sebagai register r1
.def b = r2					// Definisikan "b" sebagai register r2
.def temp = r3				// Definisikan "temp" sebagai register r3
.def hasil = r4				// Definisikan "hasil" sebagai register r4

// ---------- AMBIL ALAMAT DATA ----------
main:
	ldi ZH, HIGH(2*DATA)	// Load high byte alamat DATA ke ZH
	ldi ZL, LOW(2*DATA)		// Load low byte alamat DATA ke ZL

// ----------- MENYIAPKAN REGISTER ----------
	lpm						// Load program memory dari Z ke r0
	mov a, r0				// Pindahkan isi dari r0 ke r1
	adiw ZL, 1				// Pindahkan pointer ke byte selanjutnya (ZL += 1)
	lpm						// Load program memory dari Z ke r0
	mov b, r0				// Pindahkan isi dari r0 ke r2

// ----------- IDE SOLUSI ----------
// Akan dicari KPK(a, b). Daripada menggunakan rumus KPK(a, b) = (a * b)/FPB(a, b),
// lebih baik kita bruteforce saja. Algortima bruteforce di Python:
// i = a
// while (i % b != 0):
// 		i += a
// hasil = i

// ---------- AWAL PERULANGAN ----------
loop:
	// ---------- UPDATE hasil & temp ----------
	add hasil, a			// hasil += a
	mov temp, hasil			// Siapkan variabel temp untuk kondisional modulo

	// ---------- MENCARI MODULO temp % b ----------
	modulo:
		cp temp, b			// Bandingkan isi temp dengan b
		brlt selesai		// Jika temp < b, selesaikan pencarian modulo
		sub temp, b			// temp -= b
		rjmp modulo
	
	selesai:
		tst temp			// Cek apakah hasil modulo-nya == 0
		breq stop			// Jika iya, selesaikan loop
	
	rjmp loop				// Lakukan loop lagi

// ---------- AKHIR PERULANGAN ----------
stop:
	mov r1, hasil			// Pindahkan isi dari a ke r1

// ---------- AKHIR PROGRAM ----------
forever:
	rjmp forever			// Infinite loop

// ---------- INISIALISASI DATA ----------
DATA:
.db 12, 4					// Data array
.db 0, 0					// Padding data
