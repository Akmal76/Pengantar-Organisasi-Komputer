# Akmal Ramadhan - POK B - 2206081534
# Lab 1 - Simple Calculation
# Latihan 1 : Restoran Peokra
# Kode Asdos: KD

# Asumsi soal: Jika banyak menu yang dipesan pada kategori ke-n menerima input bernilai 0, program langsung dihentikan

# Inisialisasi data untuk string prompt program
.data
	input1	: .asciiz "Selamat datang di Restoran Peokra!\nMasukkan banyak kategori pesanan: "
	input2	: .asciiz "total menu yang dipesan pada kategori "
	input3	: .asciiz ": "
	output1	: .asciiz "Total Harga Pesanan: "
	output2	: .asciiz "Minimal pesan satu makanan!"

# Perintah program
.text
.globl main
main:
	# -------------------------- MEMINTA INPUT KATEGORI PESANAN ----------------------------
	
	# Mencetak input1
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input1 			# Load input1 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa banyak kategori pesanan
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	
	# Handle kasus banyak kategori pesanan = 0
	beqz $v0, error			# Jika banyak kategori pesanan = 0, keluarkan string "Minimal pesan satu makanan!"
	
	move $t0, $v0			# Memindahkan isi $v0 ke $t0 -> $t0: Banyak kategori pesanan
	
	# ---------------------- MEMINTA INPUT TOTAL MENU TIAP KATEGORI -----------------------------
	
	li $t1, 1			# Siapkan $t1 sebagai counter untuk loop
	li $t2, 0			# Siapkan $t2 sebagai counter jumlah menu total
	loop:
		# Mencetak input2
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, input2 			# Load input2 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak counter
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t1			# Memindahkan isi $t1 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak input3
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, input3 			# Load input3 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Meminta masukkan dari user berupa total menu tiap kategori (integer)
		li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
		syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
		
		# Handle kasus total menu = 0
		beqz $v0, error			# Jika total menu sekarang = 0, keluarkan string "Minimal pesan satu makanan!"
		
		# Handle penambahan harga pesanan
		mul $t3, $t1, $v0		# Melakukan $t3 = $t1 * $v0 -> $t1: counter loop sekarang dan $v0: total menu sekarang
		add $t2, $t2, $t3		# Melakukan $t2 += $t3
		
		# Cek counter loop
		addi $t1, $t1, 1		# Melakukan $t1++ (menambahkan $t1 + 1)
		ble $t1, $t0, loop		# Jika $t1 (counter Loop) < $t0 (banyak kategori pesanan), lakukan loop dan sebaliknya.
	endLoop:
		li $t3, 5000			# Melakukan overwrite isi $t3 dengan 5000
		mul $t2, $t2, $t3		# Melakukan $t2 *= 5000
		
		j valid
	
	# --------------------------------------- KELUARAN --------------------------------------------
	
	# Kasus terdapat total menu yang bernilai 0
	error:
		# Mencetak output2
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output2 		# Load output2 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		j end				# Selesaikan program
	
	# Kasus jika total menu tidak ada yang bernilai 0
	valid:
		# Mencetak output1
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output1 		# Load output1 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak total harga pesanan
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t2			# Memindahkan isi $t2 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)