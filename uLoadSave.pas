unit uLoadSave;

interface
uses pandas, crt;
var
	TBuku : TCSVArr;
	TUser : TCSVArr;
	TPinjam : TCSVArr;
	TKembali : TCSVArr;
	THilang : TCSVArr;

//Load semua file
procedure Load();
//Save semua file
procedure Save();

implementation
procedure Load();
begin
	clrscr();
	GotoXY(1,1);
	writeln('  ____                                                 ');
	writeln('/\  _ `\                                               ');
	writeln('\ \ \L\ \ __   _ __   _____     ___     ___     ____   ');
	writeln(' \ \ ,__/''__`\/\`''__\/\ ''__`\  / __`\  / __`\  /'',__\  ');
	writeln('  \ \ \/\  __/\ \ \/ \ \ \L\ \/\ \L\ \/\ \L\ \/\__, `\ ');
	writeln('   \ \ \/\  __/\ \ \/ \ \ \L\ \/\ \L\ \/\ \L\ \/\__, `\');
	writeln('    \ \_\ \____\\ \_\  \ \ ,__/\ \____/\ \____/\/\____/');
	writeln('     \/_/\/____/ \/_/   \ \ \/  \/___/  \/___/  \/___/ ');
	writeln('                         \ \_\                         ');
	writeln('                          \/_/                         ');
	GotoXY(1,11);
	writeln('      SELAMAT DATANG DI PERPOOS WAN SHI TONG!         ___________  ');
	writeln('____________________________________________________/ Loading... |_');
	GotoXY(1,14);
	writeln('0|_____________________|0%');
	Delay(1000);
	GotoXY(1,14);
	writeln('0|##___________________|10%');
	Delay(500);
	GotoXY(1,14);
	writeln('0|####_________________|20%');
	Delay(500);
	GotoXY(1,14);
	writeln('0|######_______________|30%');
	Delay(250);
	GotoXY(1,14);
	writeln('0|########_____________|40%');
	Delay(100);
	GotoXY(1,14);
	writeln('0|##########___________|50%');
	Delay(150);
	GotoXY(1,14);
	writeln('0|############_________|60%');
	Delay(200);
	GotoXY(1,14);
	writeln('0|##############_______|70%');
	Delay(100);
	GotoXY(1,14);
	writeln('0|################_____|80%');
	Delay(300);
	GotoXY(1,14);
	writeln('0|##################___|90%');
	Delay(1500);
	readCSV('Buku.csv', TBuku);
	readCSV('User.csv', TUser);
	readCSV('file_history_peminjaman.csv', TPinjam);
	readCSV('file_history_pengembalian.csv', TKembali);
	readCSV('Laporan_Buku_Hilang.csv', THilang);
	GotoXY(1,14);
	writeln('0|####################|100%');
	GotoXY(1,17);
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

end.
