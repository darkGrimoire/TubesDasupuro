(*Admin bisa menulis command untuk menampilkan laporan buku yang hilang/*)
// Format: ID_Buku | Judul_Buku | Tanggal_Pelaporan

Program lihat_laporan;
uses pandas;


const
  _nama = 0;
  _id = 1;
  _tanggal = 2;

  _idBuku = 0;
  _judulBuku = 1;
  _author = 2;
  _sumBuku = 3;
  _tahun = 4;
  _kategori = 5;

var
	j : integer;
	THilang: TCSVArr;
	TBuku : TCSVArr;
	i : integer;

begin
writeln('Buku yang hilang : ');
readCSV('Laporan_Buku_Hilang.csv', THilang);
//TWrite(THilang);
readCSV('Buku.csv', TBuku);
//TWrite(TBuku);
	
for i:=0 to THilang.row-1 do
	for j:=0 to TBuku.row-1 do
		begin
		if THilang.Arr[i][1] = TBuku.Arr[j][0] then
			begin
			write(THilang.Arr[i][1]);write('|');
			write(TBuku.Arr[j][1]);write('|');
			writeln(THilang.Arr[i][2]);
		end;
	end;
end.
