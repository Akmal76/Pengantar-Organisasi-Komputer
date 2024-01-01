// Akmal Ramadhan - POK B - 2206081534
// Lab 6 - Memory
// Latihan 1 : Peokra Sequence
// Kode Asdos: KD

.include "m8515def.inc"		// Memasukkan definisi tipe prosesor
.def input = r16			// Definisikan "input" sebagai register r16
.def hasil = r17			// Definisikan "hasil" sebagai register r17
.def min1  = r18			// Definisikan "min1" sebagai register r18
.def min2  = r19			// Definisikan "min2" sebagai register r19
.def temp  = r20			// Definisikan "temp" sebagai register r20
.def count = r21			// Definisikan "count" sebagai register r21
.def n     = r22			// Definisikan "n" sebagai register r22

// ---------- SIAPKAN STACK POINTER ----------
main:
	ldi temp, low(RAMEND)	// Siapkan stack pointer
	out SPL, temp			// yang merujuk pada
	ldi temp, high(RAMEND)	// akhir dari RAM
	out SPH, temp			// internal

// ---------- SIAPKAN POINTER X & PERULANGAN ----------
	ldi XL, $60				// X(low) = 0x60 untuk menyimpan hasil mulai dari alamat 0x60
	ldi input, 8			// Register input (akan diubah-ubah oleh asdos)
	ldi count, 1			// count = 1

// ---------- PERULANGAN ----------
loop:
	cp input, count			// Bandingkan input dengan count
	brlt forever			// Jika input < counter, selesaikan program
	mov n, count			// n = count
	rcall sequence			// Panggil rekursif sequence P(n)
	st X+, hasil			// Store hasil ke pointer-X. Lalu pointer-X++
	inc count				// count++
	rjmp loop				// Jalankan loop lagi

// ---------- AWAL FUNGSI REKURSIF PEOKRA SEQUENCE ----------
sequence:
	push n					// Push n ke stack
	push min1				// Push min1 ke stack
	push min2				// Push min2 ke stack
	push temp				// Push temp ke stack

	// ---------- CEK BASE CASE ----------
	cpi n, 1				// Cek apakah n == 1
	breq baseCase1			// Jika iya, lompat ke base case n = 1
	cpi n, 2				// Cek apakah n == 2
	breq baseCase2			// Jika iya, lompat ke base case n = 2

	// ---------- SIAPKAN PARAMETER UNTUK P(n-1) & P(n-2) ----------
	mov min1, n				// min1 = n
	subi min1, 1			// min1 -= 1
	mov min2, n				// min2 = n
	subi min2, 2			// min2 -= 2

	// ---------- PANGGIL P(n-1) ----------
	mov n, min1			// n = min1
	rcall sequence			// Panggil P(n-1)
	mov temp, hasil			// temp = hasil (simpan hasil P(n-1))
	
	// ---------- PANGGIL P(n-2) ----------
	mov n, min2			// n = min2
	rcall sequence			// Panggil P(n-2)
	add hasil, hasil		// hasil += hasil karena P(n-2) * 2
	add hasil, temp			// hasil += temp  karena + P(n-1)
	inc hasil				// hasil++ 		  karena + 1
	rjmp stop				// Selesaikan rekursif

	// ---------- BASE CASE n == 1 ----------
	baseCase1:
		ldi hasil, 1		// hasil = 1
		rjmp stop			// Selesaikan rekursif
	
	// ---------- BASE CASE n == 2 ----------
	baseCase2:
		ldi hasil, 2		// hasil = 2
		rjmp stop			// Selesaikan rekursif

// ---------- AKHIR FUNGSI REKURSIF PEOKRA SEQUENCE ----------
stop:
	pop temp				// Pop temp dari stack
	pop min2				// Pop min2 dari stack
	pop min1				// Pop min1 dari stack
	pop n					// Pop n dari stack
	ret						// Kembali ke main (perintah rcall)

// ---------- AKHIR PROGRAM ----------
forever:
	rjmp forever			// Infinite loop
