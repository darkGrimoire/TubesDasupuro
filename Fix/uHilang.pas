unit uHilang;

interface
uses pandas, crt;

procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
(*Procedure ini digunakan untuk melihat laporan buku yang hilang. Perintah ini hanya bisa dilakukan oleh admin*)
procedure laporHilang(var THilang: TCSVArr);
(*Procedure ini digunakan oleh pengunjung untuk melaporkan buku yang hilang.
* Untuk membuat laporan buku yang hilang, dibutuhkan masukan berupa ID Buku, judul buku,
* dan tanggal pelaporan buku yang hilang*)

implementation

procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
var
	j : integer; 														// digunakan untuk pengulangan dalam pengecekan dalam data buku
	i : integer;														// digunakan untuk pengulangan dalam pengecekan dalam data laporan buku yang hilang
	// THilang: TCSVArr;
	// TBuku : TCSVArr;
	
begin
ClrScr;																	// untuk membersihkan jendela sebelumnya
writeln('Buku yang hilang : ');											// program menuliskan 'Buku yang hilang: '
// readCSV('Laporan_Buku_Hilang.csv', THilang);							// membaca file Laporan_Buku_Hilang.csv
// //TWrite(THilang);													// digunakan untuk mengecek data yang sudah diproses dalam Laporan_Buku_Hilang.csv
// readCSV('Buku.csv', TBuku);											// membaca file Buku.csv
//TWrite(TBuku);														// digunakan untuk mengecek data yang sudah diproses dalam Buku.csv
	
for i:=0 to THilang.row-1 do											// pengulangan dari baris pertama hingga baris terakhir dalam data laporan buku yang hilang
	for j:=0 to TBuku.row-1 do											// pengulangan dari baris pertama hingga baris terakhir dalam data buku keseluruhan
		if THilang.Arr[i][_idHilang] = TBuku.Arr[j][_idBuku] then		// ketika data buku ditemukan di dalam data laporan buku yang hilang
		begin
			write(THilang.Arr[i][_idHilang]);write('|');				// program menuliskan ID Buku yang hilang dan dipisahkan dengan '|'
			write(TBuku.Arr[j][_judulBuku]);write('|');					// program menuliskan judul buku yang hilang dan dipisahkan dengan '|'
			writeln(THilang.Arr[i][2]);									// program menuliskan tanggal pelaporan
		end;
writeln; writeln('Tekan tombol apapun untuk melanjutkan');				// program akan menyuruh pengguna untuk menekan tombol apapun ketika program telah selesai menampilkan seluruh laporan kehilangan
readkey;
end;

procedure laporHilang(var THilang: TCSVArr);
var
	new: TRow;
	input: string;
	i: integer;															
	// THilang: TCSVArr;

begin
	// readCSV('Laporan_Buku_Hilang.csv', THilang);
	ClrScr;																// membersihkan dari jendela sebelumnya
	SetLength(new.Arr,THilang.Col);										// menentukan panjang dari string
	writeln('Masukkan data buku: ');									// program menulisnkan 'Masukkan data buku: ' ke layar dan pengguna harus memasukkan data buku
	for i := 0 to THilang.Col-1 do 										// pengulangan dari kolom pertama hingga kolom terakhir dalam Laporan_Buku_Hilang.csv
	begin
		case i of 														
		0 : begin
			write('Masukkan ID Buku: ');								// pengguna diminta untuk memasukkan ID Buku
			end;
		1 : begin
			write('Masukkan Judul Buku: ');								// pengguna diminta untuk memasukkan judul buku
			end;
		2 : begin
			write('Masukkan Tanggal Pelaporan: ');						// pengguna diminta untuk memasukkan tanggal pelaporan
			end;
		end;
	readln(input);														// pengguna harus memasukkan data buku yang hilang
	new.Arr[i] := input;												// data yang telah dimasukkan akan disimpan di array new
	end;
	addRow(THilang,new);												// data baru tersebut ditambahkan di THilang
	//writeCSV('Laporan_Buku_Hilang.csv', THilang);
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');			// program akan menyuruh pengguna untuk menekan tombol apapun ketika program telah selesai menampilkan seluruh laporan kehilangan
  readkey;
end;

end.
