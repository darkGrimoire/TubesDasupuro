Program uLaporHilang;

uses pandas, crt;


procedure laporHilang();
var

	new: TRow;
	input: string;
	i: integer;
	THilang: TCSVArr;

begin
	readCSV('Laporan_Buku_Hilang.csv', THilang);
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
	// writeCSV('Laporan_Buku_Hilang.csv', THilang);
	TWrite(THilang);

end;

begin
	laporHilang();
end.