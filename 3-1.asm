# Akmal Ramadhan - POK B - 2206081534
# Lab 3 - Advanced Array Manipulation
# Latihan 1 : Alphabetisme
# Kode Asdos: KD

# Inisialisasi data untuk string prompt program dan array string
.data
	input	: .asciiz "Masukkan string berukuran 10: "
	output	: .asciiz "\nHasil: "
	string	: .space 11

# Perintah program
.text
.globl main
main:
	# ---------------------------------- MEMINTA INPUT STRING ---------------------------------------
	
	# Mencetak input
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input 			# Load input ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa string
	li $v0, 8			# Load sycall 8: Untuk membaca masukkan berupa string
	li $a1, 11			# Membaca input maksimal 10 karakter
	la $a0, string			# Load alamat memori string ke $a0
	syscall				# Eksekusi (membaca masukkan string dan simpan ke $v0)
	
	# ------------------------------ ITERASI TIAP KARAKTER STRING -----------------------------------
	
	# Mencetak output
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, output 			# Load input ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Siapkan register yang ingin digunakan
	li $t0, 0			# $t0: counter loop
	
	# Perulangan untuk mencari uppercase pada 5 karakter pertama
	upperLoop:
		lb $t1, string ($t0)	# Load byte isi dari string[$t0] ke $t1 -> $t1: Karakter sekarang
		
		# Cek apakah karakter sekarang merupakan karakter uppercase
		blt $t1, 'A', continueUpper	# Jika $t1 < 'A', skip
		bgt $t1, 'Z', continueUpper	# Jika $t1 > 'Z', skip
		
		# Mencetak karakter sekarang
		li $v0, 11		# Load syscall 4: Untuk mencetak char
		move $a0, $t1		# Load output1 ke $a0
		syscall			# Eksekusi (mencetak char yang ada di $a0)
		
		# Update counter dan cek kondisional loop
		continueUpper:
			addi $t0, $t0, 1	# Tambahkan counter ($t0++)
			bne $t0, 5, upperLoop	# Jika $t0 != 5, lakukan loop	
	
	# Perulangan untuk mencari lowecase pada 5 karakter terakhir
	lowerLoop:
		lb $t1, string ($t0)	# Load byte isi dari string[$t0] ke $t1 -> $t1: Karakter sekarang
		
		# Cek apakah karakter sekarang merupakan karakter lowercase
		blt $t1, 'a', continueLower	# Jika $t1 < 'a', skip
		bgt $t1, 'z', continueLower	# Jika $t1 > 'z', skip
		
		# Mencetak karakter sekarang
		li $v0, 11		# Load syscall 4: Untuk mencetak char
		move $a0, $t1		# Load output1 ke $a0
		syscall			# Eksekusi (mencetak char yang ada di $a0)
		
		# Update counter dan cek kondisional loop
		continueLower:
			addi $t0, $t0, 1	# Tambahkan counter ($t0++)
			bne $t0, 10, lowerLoop	# Jika $t0 != 10, lakukan loop
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)