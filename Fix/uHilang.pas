unit uHilang;

interface
uses pandas, crt;

procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
procedure laporHilang(var THilang: TCSVArr);

implementation

procedure lihatLaporHilang(THilang, TBuku: TCSVArr);
var
	j : integer;
	// THilang: TCSVArr;
	// TBuku : TCSVArr;
	i : integer;

begin
ClrScr;
writeln('Buku yang hilang : ');
// readCSV('Laporan_Buku_Hilang.csv', THilang);
// //TWrite(THilang);
// readCSV('Buku.csv', TBuku);
//TWrite(TBuku);
	
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
	// THilang: TCSVArr;

begin
	// readCSV('Laporan_Buku_Hilang.csv', THilang);
	ClrScr;
	SetLength(new.Arr,THilang.Col);
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
	new.Arr[i] := input;
	end;
	addRow(THilang,new);
	//writeCSV('Laporan_Buku_Hilang.csv', THilang);
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.