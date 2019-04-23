unit uHilang;

interface
uses pandas, crt;

{ Modul Utama }
//Modul melihat isi dari Laporan Hilang
procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
//Modul melaporkan buku Hilang dan masukkan ke dalam databasenya
procedure laporHilang(var THilang: TCSVArr);

implementation

procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
var
	j : integer;
	i : integer;

begin
//ClearScreen
ClrScr;
//Baca isi laporan buku yang hilang, ambil judulnya dari TBuku (jika idnya ada)
writeln('Buku yang hilang : ');	
for i:=0 to THilang.row-1 do
	for j:=0 to TBuku.row-1 do
		if THilang.Arr[i][_idHilang] = TBuku.Arr[j][_idBuku] then
		begin
			write(THilang.Arr[i][_idHilang]);write('|');
			write(TBuku.Arr[j][_judulBuku]);write('|');
			writeln(THilang.Arr[i][2]);
		end;
writeln; writeln('Tekan tombol apapun untuk melanjutkan');
readkey;
end;

procedure laporHilang(var THilang: TCSVArr);
var
	new: TRow;
	input: string;
	i: integer;

begin
	//ClearScreen
	ClrScr;
	//set panjang baris
	SetLength(new.Arr,THilang.Col);
	//input
	writeln('Masukkan data buku: ');
	for i := 0 to THilang.Col-1 do 
	begin
		case i of 
		0 : begin
			write('Masukkan ID Buku: ');
			end;
		1 : begin
			write('Masukkan Judul Buku: ');
			end;
		2 : begin
			write('Masukkan Tanggal Pelaporan: ');
			end;
		end;
	readln(input);
	//masukkan input ke baris
	new.Arr[i] := input;
	end;
	//tambahkan baris ke THilang
	addRow(THilang,new);
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.