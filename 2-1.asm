# Akmal Ramadhan - POK B - 2206081534
# Lab 2 - ...
# Latihan 1 : Bisreng Automotive Dealer
# Kode Asdos: KD

# Inisialisasi data untuk string prompt program dan array NPM
.data
	input	: .asciiz "Masukkan Input 10 digit: "
	output1	: .asciiz "Total penjualan mobil: "
	output2	: .asciiz "\nTotal penjualan motor: "
	npm	: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

# Perintah program
.text
.globl main
main:
	# ----------------------------------- MEMINTA INPUT NPM -----------------------------------------
	
	# Mencetak input
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input 			# Load input ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa NPM
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	
	# ------------------------------ ASSIGN DIGIT NPM KE DALAM ARRAY --------------------------------
	
	# Menyiapkan register yang dibutuhkan
	la $t0, npm			# $t0: array NPM
	li $t1, 0			# $t1: counter loop
	
	loop1:
		# Ambil satuan dari NPM
		div $v0, $v0, 10	# Bagi NPM dengan 10
		mfhi $t2		# Simpan sisa bagi ke dalam $t2
		
		# Simpan ke dalam array
		sw $t2, 0 ($t0)		# Store isi $t2 ke alamat atau pointer (0 + $t0)
		addi $t0, $t0, 4	# Tambahkan pointer untuk ke indeks selanjutnya
		addi $t1, $t1, 1	# Tambahkan counter loop ($t1++)
		
		# Cek kondisi loop
		bne $t1, 10, loop1	# Jika $t1 != 10, lanjutkan loop

	# ----------------------------- HITUNG PENJUALAN MOBIL DAN MOTOR --------------------------------
	
	# Ide solusi: Walaupun assign NPM kita mulai dari belakang (yang berarti array sekarang berisi 
	# NPM terbalik), dalam perhitungan kita akan mulai dari indeks array terbelakang sehingga diperoleh
	# parity mobil motor yang sama sesuai dengan ketentuan soal.
	# Contoh: NPM = 2006081234
	# Isi Array: 4, 3, 2, 1, 8, 0, 6, 0, 0, [2]
	# Indeks   : 0, 1, 2, 3, 4, 5, 6, 7, 8,  9
	#                                 pointer sekarang
	# Geser pointer kekiri sampai indeks nol.
	
	# Menyiapkan register yang dibutuhkan
	li $t1, 9			# $t1: counter loop
	li $t3, 0			# $t3: penjualan mobil
	li $t4, 0			# $t4: penjualan motor
	
	loop2:
		# Update indeks dan ambil atau load npm[$t0]
		subi $t0, $t0, 4	# Kurangkan pointer untuk ke indeks sebelumnya
		lw $t2, 0 ($t0)		# Load isi alamat atau pointer (0 + $t0) ke $t2
		
		# Branching penjualan mobil atau motor
		# Ide: Untuk cek apakah sekarang indeks genap atau ganjil cukup (indeks AND 1).
		# Jika hasilnya 0 maka indeks sekarang genap dan sebaliknya.
		andi $t5, $t1, 1	# $t5: parameter parity $t1
		bnez $t5, odd		# Jika $t5 != 0, maka tambahkan $t2 ke penjualan motor
		
		# Jika indeks genap
			add $t3, $t3, $t2	# $t3 += $t2
			j endOdd
		# Jika indeks ganjil
		odd:	
			add $t4, $t4, $t2	# $t4 += $t2
		endOdd:
		
		# Cek kondisi loop
		subi $t1, $t1, 1	# Kurangkan counter loop ($t1--)
		bne $t1, -1, loop2	# Jika $t1 != -1, lanjutkan loop
			
	# ---------------------------------------- KELUARAN ---------------------------------------------
	
	# Mencetak output1
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, output1 		# Load output1 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Mencetak total penjualan mobil
	li $v0, 1			# Load syscall 1: Untuk mencetak integer
	move $a0, $t3			# Memindahkan isi $t3 ke $a0
	syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
	# Mencetak output2
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, output2 		# Load output2 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Mencetak total penjualan motor
	li $v0, 1			# Load syscall 1: Untuk mencetak integer
	move $a0, $t4			# Memindahkan isi $t4 ke $a0
	syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)
