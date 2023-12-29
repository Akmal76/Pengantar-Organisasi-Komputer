# Akmal Ramadhan - POK B - 2206081534
# Lab 0 - Robot
# Latihan 3 : Side Quest! (Bonus)
# Kode Asdos: KD

# Inisialisasi data untuk string prompt program
.data
	message	: .asciiz "Selamat datang pada awal perjalananmu, petualang!\nSebelum memulai petualanganmu, silahkan memperkenalkan dirimu terlebih dahulu.\n"
	input1	: .asciiz "Masukkan NPM kamu: "
	input2	: .asciiz "Masukkan jumlah mata kuliah yang kamu ambil: "
	input3  : .asciiz "Masukkan SKS mata pelajaran "
	input4  : .asciiz ": "
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
	
	# -------------------------- MEMINTA INPUT JUMLAH MATA KULIAH ---------------------------------
	
	# Mencetak input2
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input2 			# Load input2 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa jumlah mata kuliah (integer)
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	move $t1, $v0			# Memindahkan isi $v0 ke $t1 -> $t1: Jumlah mata kuliah
	
	# --------------------- MEMINTA INPUT JUMLAH SKS TIAP MATA KULIAH -----------------------------
	
	li $t2, 1			# Siapkan $t2 sebagai counter untuk loop
	li $t3, 0			# Siapkan $t3 sebagai counter jumlah SKS total
	loop:
		# Mencetak input3
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, input3 			# Load input3 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak counter
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t2			# Memindahkan isi $t2 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak input4
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, input4 			# Load input4 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Meminta masukkan dari user berupa jumlah SKS (integer)
		li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
		syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
		add $t3, $t3, $v0		# Melakukan $t3 += $v0 -> $t3: Jumlah SKS total
		
		# Cek counter loop
		addi $t2, $t2, 1		# Melakukan $t2++ (menambahkan $t2 + 1)
		ble $t2, $t1, loop		# Jika $t2 (counter Loop) < $t1 (jumlah mata kuliah), lakukan loop dan sebaliknya.
	endLoop:
	
	# ---------------------------------- VALIDASI JUMLAH SKS --------------------------------------
	
	ble $t3, 24, valid		# Cek apakah $t3 <= 24. Jika iya, jalankan perintah valid. Jika tidak lanjutkan perintah selanjutnya.

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
	
		# Mencetak isi dari $t1: Jumlah SKS total
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t3			# Memindahkan isi $t3 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak output3
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output3 		# Load output3 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)