unit shafaCapek;

interface
uses pandas, crt;
var
	TBuku : TCSVArr;
	TUser : TCSVArr;
	TPinjam : TCSVArr;
	TKembali : TCSVArr;
	THilang : TCSVArr;

procedure Load();
procedure Save();

implementation
procedure Load();
begin
	clrscr();
	window(1,1,80,25);
	GotoXY(1,12);
	writeln('0|0%');
	Delay(1000);
	GotoXY(1,12);
	writeln('0██10%');
	Delay(500);
	GotoXY(1,12);
	writeln('0████20%');
	Delay(500);
	GotoXY(1,12);
	writeln('0██████30%');
	Delay(250);
	GotoXY(1,12);
	writeln('0████████40%');
	Delay(100);
	GotoXY(1,12);
	writeln('0██████████50%');
	Delay(150);
	GotoXY(1,12);
	writeln('0████████████60%');
	Delay(200);
	GotoXY(1,12);
	writeln('0██████████████70%');
	Delay(100);
	GotoXY(1,12);
	writeln('0████████████████80%');
	Delay(300);
	GotoXY(1,12);
	writeln('0██████████████████90%');
	Delay(1500);
	readCSV('Buku.csv', TBuku);
	readCSV('User.csv', TUser);
	readCSV('file_history_peminjaman.csv', TPinjam);
	readCSV('file_history_pengembalian.csv', TKembali);
	readCSV('Laporan_Buku_Hilang.csv', THilang);
	GotoXY(1,12);
	writeln('0████████████████████100%');
	GotoXY(1,13);
	writeln('Tekan tombol apapun untuk melanjutkan');
	readkey;
end;

procedure Save();
begin
	writeCSV('Buku.csv', TBuku);
	writeCSV('User.csv', TUser);
	writeCSV('file_history_peminjaman.csv', TPinjam);
	writeCSV('file_history_pengembalian.csv', TKembali);
	writeCSV('Laporan_Buku_Hilang.csv', THilang);
	TDestroy(TBuku);
	TDestroy(TUser);
	TDestroy(TPinjam);
	TDestroy(TKembali);
	TDestroy(THilang);
end;
