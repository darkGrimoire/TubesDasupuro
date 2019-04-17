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

{ Modul Utama }
procedure cariBukuKategori();
procedure cariBukuTahun();

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

end.