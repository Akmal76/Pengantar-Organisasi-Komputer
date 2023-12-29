# Akmal Ramadhan - POK B - 2206081534
# Lab 0 - Robot
# Latihan 2 : Jangan buat Robot Marah!
# Kode Asdos: KD

# Inisialisasi data untuk string prompt program
.data
	message	: .asciiz "Selamat datang pada awal perjalananmu, petualang!\nSebelum memulai petualanganmu, silahkan memperkenalkan dirimu terlebih dahulu.\n"
	input1	: .asciiz "Masukkan NPM kamu: "
	input2	: .asciiz "Masukkan jumlah SKS yang kamu ambil: "
	output1	: .asciiz "Halo petualang dengan NPM "
	output2	: .asciiz ". Semoga dengan mengambil "
	output3	: .asciiz " SKS anda bisa menyelesaikan petualangan ini dengan baik!"
	output4 : .asciiz "Berbohong itu tidak baik!."

# Perintah program
.text
.globl main
main:
	# ------------------------------------ PESAN PEMBUKA ------------------------------------------
	
	# Mencetak message
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, message 		# Load message ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# ----------------------------------- MEMINTA INPUT NPM ---------------------------------------
	
	# Mencetak input1
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input1 			# Load input1 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa NPM (integer)
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	
	move $t0, $v0			# Memindahkan isi $v0 ke $t0 -> $t0: NPM
	
	# -------------------------------- MEMINTA INPUT JUMLAH SKS -----------------------------------
	
	# Mencetak input2
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input2 			# Load input2 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa jumlah SKS (integer)
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	move $t1, $v0			# Memindahkan isi $v0 ke $t1 -> $t1: Jumlah SKS
	
	# ---------------------------------- VALIDASI JUMLAH SKS --------------------------------------
	
	ble $t1, 24, valid		# Cek apakah $t1 <= 24. Jika iya, jalankan perintah valid. Jika tidak lanjutkan perintah selanjutnya.

	# --------------------------------------- KELUARAN --------------------------------------------
	
	# Kasus jika jumlah SKS > 24
	# Mencetak output4
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, output4 		# Load output4 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	j end				# Selesaikan program
	
	# Kasus jika jumlah SKS <= 24
	valid:
		# Mencetak output1
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output1 		# Load output1 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak isi dari $t0: NPM
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t0			# Memindahkan isi $t0 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
		# Mencetak output2
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output2 		# Load output2 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak isi dari $t1: Jumlah SKS
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t1			# Memindahkan isi $t1 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak output3
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output3 		# Load output3 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)