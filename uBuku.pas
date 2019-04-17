unit uBuku;

interface
uses pandas, crt;
const
  _idBuku = 0;
  _judulBuku = 1;
  _author = 2;
  _sumBuku = 3;
  _tahun = 4;
  _kategori = 5;

{ Subprogram Pembantu }
function isKategoriValid(Text: string) : boolean;
function isValidTahun(i: integer; optr: string; j: integer): boolean;
function searchCellContain(TCSV: TCSVArr; Where: integer; Text: string) : integer;

{ Modul Utama }
procedure cariBukuKategori();
procedure cariBukuTahun();
procedure tambahBuku(TBuku: TCSVArr);
procedure tambahJumlahBuku(var TBuku: TCSVArr);

implementation

{ Subprogram Pembantu }
function isKategoriValid(Text: string) : boolean;
begin
  isKategoriValid := (Text='Sastra') or (Text='Sains') or (Text='Manga') or (Text='Sejarah') or (Text='Programming');
end;

function isValidTahun(i: integer; optr: string; j: integer): boolean;
begin
  case optr of
    '=' : isValidTahun:= i=j;
    '<' : isValidTahun:= i<j;
    '>' : isValidTahun:= i>j;
    '>=' : isValidTahun:= i>=j;
    '<=' : isValidTahun:= i<=j;
  end;
end;

function searchCellContain(TCSV: TCSVArr; Where: integer; Text: string) : integer;
var
  i: integer;
begin
  i:=0;
  searchCellContain:=-1;
  while (i<=TCSV.Row-1) and (searchCellContain=-1) do
  begin
    if Text=TCSV.Arr[i][Where] then
      searchCellContain:=i;
    Inc(i);
  end;
end;


{ Modul Utama }

procedure cariBukuKategori();
var
  TBuku: TCSVArr;
  input: string;
  i: integer;

begin
  readCSV('Buku.csv',TBuku);
  sortCSV(TBuku,_judulBuku);
  Clrscr();
  write('Masukkan kategori: ');
  readln(input);
  while not isKategoriValid(input) do
    begin
      writeln('Kategori ', input, ' tidak valid.');
      write('Masukkan kategori: ');
      readln(input);
    end;
  writeln('');
  i:=0;
  while i < TBuku.Row do
  begin
    if (input <> TBuku.Arr[i][_kategori]) then
      removeRow(TBuku,i)
    else
      inc(i);
  end;
  writeln('Hasil pencarian:');
  if TBuku.Row=0 then
  begin
    writeln('Tidak ada buku dalam kategori ini.');
  end else
  begin
    for i:=0 to TBuku.Row-1 do
    begin
      write(TBuku.Arr[i][_idBuku]); write(' | ');
      write(TBuku.Arr[i][_judulBuku]); write(' | ');
      write(TBuku.Arr[i][_author]); writeln('');
    end;
  end;
  readkey;
  TDestroy(TBuku);
end;

procedure cariBukuTahun();
var
  TBuku: TCSVArr;
  inOpt: string;
  input,i,tahun: integer;

begin
  readCSV('Buku.csv',TBuku);
  sortCSV(TBuku,_judulBuku);
  Clrscr();
  write('Masukkan tahun: ');
  readln(input);
  write('Masukkan kategori: ');
  readln(inOpt);
  writeln;
  i:=1;
  while i < TBuku.Row do
  begin
    Val(TBuku.Arr[i][_tahun],tahun);
    if not isValidTahun(tahun,inOpt,input) then
      removeRow(TBuku,i)
    else
      inc(i);
  end;
  writeln('Hasil pencarian:');
  if TBuku.Row=1 then
  begin
    writeln('Tidak ada buku dalam kategori ini.');
  end else
  begin
    for i:=0 to TBuku.Row-1 do
    begin
      write(TBuku.Arr[i][_idBuku]); write(' | ');
      write(TBuku.Arr[i][_judulBuku]); write(' | ');
      write(TBuku.Arr[i][_author]); writeln('');
    end;
  end;
  readkey;
  TDestroy(TBuku);
end;

procedure tambahBuku(TBuku: TCSVArr);

var
	
	new: TRow;
	input: string;
	i: integer;


begin
	SetLength(new.Arr,TBuku.Col);
	writeln('Masukkan data buku: ');
	for i := 0 to TBuku.Col-1 do 
	begin
		case i of 
		0 : begin
			write('ID Buku: ');
			end;
		1 : begin
			write('Judul Buku: ');
			end;
		2 : begin
			write('Author: ');
			end;
		3 : begin
			write('Jumlah Buku: ');
			end;
		4 : begin
			write('Tahun penerbitan: ');
			end;
		5 : begin
			write('Kategori: ');
			end;
		end;
	readln(input);
	new.Arr[i] := input;
	end;
	addRow(TBuku,new);
	writeCSV('Buku.csv', TBuku);
	TWrite(TBuku);

end;

procedure tambahJumlahBuku(var TBuku: TCSVArr);
	var
		input, sJumlah: string;
		new, rowbuku, vJumlah: integer;

	begin
		writeln('Masukkan judul buku: ');
		readln(input);
		rowbuku := searchCellContain(TBuku, 1, input);
		
		write('Masukkan jumlah tambahan buku: ');
		readln(new);
		val(TBuku.Arr[rowbuku][3], vJumlah);
		vJumlah := vJumlah + new;
		str(vJumlah, sJumlah);
		TBuku.Arr[rowbuku][3] := sJumlah;
		writeCSV('Buku.csv', TBuku);
		writeln('Jumlah buku berhasil diperbarui.');
		

	end;

end.