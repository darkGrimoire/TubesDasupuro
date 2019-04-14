Program shafaCapek;

uses pandas;
var
	TBuku : TCSVArr;
	TUser : TCSVArr;
	TPinjam : TCSVArr;
	TKembali : TCSVArr;
	THilang : TCSVArr;

procedure Load();
begin
	readCSV('Buku.csv', TBuku);
	readCSV('User.csv', TUser);
	//readCSV('file_history_peminjaman.csv', TPinjam);
	readCSV('file_history_pengembalian.csv', TKembali);
	readCSV('Laporan_Buku_Hilang.csv', THilang);
end;

procedure Save();
begin
	writeCSV('Buku.csv', TBuku);
	writeCSV('User.csv', TUser);
	//writeCSV('file_history_peminjaman.csv', TPinjam);
	writeCSV('file_history_pengembalian.csv', TKembali);
	writeCSV('Laporan_Buku_Hilang.csv', THilang);
end;