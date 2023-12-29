# Akmal Ramadhan - POK B - 2206081534
# Lab 1 - Simple Calculation
# Latihan 2 : Sistem Pembayaran Restoran
# Kode Asdos: KD

# Asumsi soal: Jika banyak menu yang dipesan pada kategori ke-n menerima input bernilai 0, program langsung dihentikan

# Inisialisasi data untuk string prompt program
.data
	input1	: .asciiz "Selamat datang di Restoran Peokra!\nMasukkan banyak kategori pesanan: "
	input2	: .asciiz "total menu yang dipesan pada kategori "
	input3	: .asciiz ": "
	input4	: .asciiz "\nMasukan nominal pembayaran: "
	output1	: .asciiz "Total Harga Pesanan: "
	output2	: .asciiz "Minimal pesan satu makanan!"
	output3	: .asciiz "\nTotal ppn: "
	output4 : .asciiz "\nTotal service: "
	output5	: .asciiz "\nTotal Harga yang perlu dibayar: "
	output6	: .asciiz "Terima kasih, berikut kembalian sebesar "
	output7	: .asciiz "Maaf, uang anda kurang sebesar "

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
	
	li $t1, 1			# Siapkan $t1: counter untuk loop
	li $t2, 0			# Siapkan $t2: jumlah menu total
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
		mul $t2, $t2, $t3		# Melakukan $t2 *= 5000 -> $t2: harga total pesanan
	
	# -------------------------------- MENGHITUNG PPN DAN SERVICE ---------------------------------
	
	# Menghitung ppn
	li $t3, 10				# Siapkan $t3 = 10
	div $t2, $t3				# Lakukan $t2 / $t3 = $t2 / 10
	mflo $t0				# Melakukan overwrite isi $t0 dengan quotient dati $t2 / 10 -> $t0: total ppn
	
	# Menghitung service
	srl $t1, $t0, 1				# Karena service 5%, maka sama saja (total ppn / 2) = (total ppn shift right sekali)
	
	# Menghitung harga total yang perlu dibayar
	add $t3, $t2, $t0			# Melakukan $t3 = $t2 + $t0
	add $t3, $t3, $t1			# Melakukan $t3 += $t1
	
	j valid					# Lompat ke valid
	
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
		
		# Mencetak output3
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output3 		# Load output3 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
		
		# Mencetak total ppn
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t0			# Memindahkan isi $t0 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak output4
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output4 		# Load output4 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
		
		# Mencetak total service
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t1			# Memindahkan isi $t1 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
		# Mencetak output5
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output5 		# Load output5 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
		
		# Mencetak total harga yang harus dibayar
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		move $a0, $t3			# Memindahkan isi $t3 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
		
	# ------------------------------- MEMINTA NOMINAL PEMBAYARAN ----------------------------------
	
	# Mencetak output6
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, input4 			# Load input4 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Meminta masukkan dari user berupa nomimal pembayaran (integer)
	li $v0, 5			# Load syscall 5: Untuk membaca masukkan berupa integer
	syscall				# Eksekusi (membaca masukkan integer dan simpan ke $v0)
	
	# Cek apakah uang cukup
	sub $t4, $v0, $t3		# Melakukan $t4 = $v0 - $t3 -> $t4: kembalian
	bltz $t4, fail			# Cek apakah $t4 < 0), jika iya lompat ke fail
	
	# Mencetak output6
	li $v0, 4			# Load syscall 4: Untuk mencetak string
	la $a0, output6 		# Load output6 ke $a0
	syscall				# Eksekusi (mencetak string yang ada di $a0)
	
	# Mencetak kembalian
	li $v0, 1			# Load syscall 1: Untuk mencetak integer
	move $a0, $t4			# Memindahkan isi $t4 ke $a0
	syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
	j end				# Selesaikan program
	
	# Kasus jika uang tidak cukup
	fail:
		# Mencetak output7
		li $v0, 4			# Load syscall 4: Untuk mencetak string
		la $a0, output7 		# Load output7 ke $a0
		syscall				# Eksekusi (mencetak string yang ada di $a0)
	
		# Mencetak kembalian
		li $v0, 1			# Load syscall 1: Untuk mencetak integer
		abs $t4, $t4			# Melakukan $t4 = absolute($t4)
		move $a0, $t4			# Memindahkan isi $t4 ke $a0
		syscall				# Eksekusi (mencetak integer yang ada di $a0)
	
	# ------------------------------------ PROGRAM SELESAI ------------------------------------------
	end:
		li $v0, 10			# Exit command
		syscall				# Eksekusi (mengakhiri program)