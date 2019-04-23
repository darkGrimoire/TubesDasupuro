unit uBuku;

interface
uses pandas, crt;

{ Subprogram Pembantu }
function isKategoriValid(Text: string) : boolean;
function isValidTahun(i: integer; optr: string; j: integer): boolean;
function searchCellContain(TCSV: TCSVArr; Where: integer; Text: string) : integer;
function isJudulExist(TCSV: TCSVArr; Text: string) : boolean;

{ Modul Utama }
procedure cariBukuKategori(TBuku: TCSVArr);
procedure cariBukuTahun(TBuku: TCSVArr);
procedure tambahBuku(var TBuku: TCSVArr);
procedure tambahJumlahBuku(var TBuku: TCSVArr);
procedure statistik(TUser, TBuku: TCSVArr);

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

function isJudulExist(TCSV: TCSVArr; Text: string) : boolean;
begin
  if searchCellContain(TCSV,_judulBuku,Text)=-1 then
    isJudulExist:=false
  else
    isJudulExist:=true;
end;


{ Modul Utama }

procedure cariBukuKategori(TBuku: TCSVArr);
var
  input: string;
  i: integer;

begin
  // readCSV('Buku.csv',TBuku);
  SetLength(TBuku.Arr,TBuku.Row,TBuku.Col);
  // TWrite(TBuku);
  // readkey;
  sortCSV(TBuku,_judulBuku);
  // TWrite(TBuku);
  // readkey;
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
  i:=1;
  while i < TBuku.Row do
  begin
    if (input <> TBuku.Arr[i][_kategori]) then
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
      write(TBuku.Arr[i][_idBuku]:5); write(' | ');
      write(TBuku.Arr[i][_judulBuku]); write(' | ');
      write(TBuku.Arr[i][_author]); writeln('');
    end;
  end;
  // TWrite(TBuku);
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
  // TDestroy(TBuku);
end;

procedure cariBukuTahun(TBuku: TCSVArr);
var
  inOpt: string;
  input,i,tahun: integer;

begin
  // readCSV('Buku.csv',TBuku);
  SetLength(TBuku.Arr,TBuku.Row,TBuku.Col);
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
      write(TBuku.Arr[i][_idBuku]:5); write(' | ');
      write(TBuku.Arr[i][_judulBuku]); write(' | ');
      write(TBuku.Arr[i][_author]); writeln('');
    end;
  end;
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
  // TDestroy(TBuku);
end;

procedure tambahBuku(var TBuku: TCSVArr);

var
	
	new: TRow;
	input: string;
	i: integer;


begin
  Clrscr();
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
	// writeCSV('Buku.csv', TBuku);
	// TWrite(TBuku);
	writeln('Buku berhasil ditambahkan.');
	
end;

procedure tambahJumlahBuku(var TBuku: TCSVArr);
	var
		input, sJumlah: string;
		new, rowbuku, vJumlah: integer;

	begin
    Clrscr();
		writeln('Masukkan judul buku: ');
		readln(input);
		while not(isJudulExist(TBuku,input)) do
		begin
		writeln('Buku tidak ditemukan.');
		write('Masukkan judul buku: ');
		readln(input);
		end;
		rowbuku := searchCellContain(TBuku, _judulBuku, input);
		
		write('Masukkan jumlah tambahan buku: ');
		readln(new);
		val(TBuku.Arr[rowbuku][_sumBuku], vJumlah);
		vJumlah := vJumlah + new;
		str(vJumlah, sJumlah);
		TBuku.Arr[rowbuku][_sumBuku] := sJumlah;
		// writeCSV('Buku.csv', TBuku);
		writeln('Jumlah buku berhasil diperbarui.');
    writeln; writeln('Tekan tombol apapun untuk melanjutkan');
    readkey;
	end;

procedure statistik(TUser, TBuku: TCSVArr);
var
  jumlahAdmin : integer;
  jumlahNonAdmin : integer;
  // TUser: TCSVArr;
  // TBuku : TCSVArr;
  jSastra : integer;
  jManga :integer;
  jProgramming :integer;
  jSains :integer;
  jSejarah :integer;
  i : integer;

begin
  Clrscr;
  jumlahAdmin := 0; jumlahNonAdmin := 0; jSastra := 0; jManga := 0; jProgramming := 0; jSains := 0; jSejarah := 0;
  // readCSV('User.csv', TUser);
  // TWrite(TUser);
  // readCSV('Buku.csv', TBuku);
  // TWrite(TBuku);
  for i:=0 to TUser.row-1 do
    if TUser.Arr[i][_role]='admin' then
      jumlahAdmin := 1 + jumlahAdmin
    else //pengunjung
      jumlahNonAdmin := 1 + jumlahNonAdmin;
  writeln ('Jumlah admin: ', jumlahAdmin );
  writeln ('Jumlah pengunjung: ', jumlahNonAdmin);
  writeln ('Total: ', jumlahAdmin + jumlahNonAdmin);
  writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
  for i:=0 to TBuku.row-1 do
  begin
    if TBuku.Arr[i][_kategori]='Sastra' then
      jSastra := 1 + jSastra
    else if TBuku.Arr[i][_kategori]='Manga' then
      jManga := 1 + jManga
    else if TBuku.Arr[i][_kategori]='Programming' then
      jProgramming := 1 + jProgramming
    else if TBuku.Arr[i][_kategori]='Sains' then
      jSains := 1 + jSains
    else if TBuku.Arr[i][_kategori]='Sejarah' then
      jSejarah := 1 + jSejarah;
  end;
  writeln ('Jumlah buku sastra : ', jSastra);
  writeln ('Jumlah buku manga : ', jManga);
  writeln ('Jumlah buku programming : ', jProgramming);
  writeln ('Jumlah buku sains : ', jSains);
  writeln ('Jumlah buku sejarah : ', jSejarah);
  writeln ('Total: ', jSastra + jManga + jProgramming + jSains + jSejarah);
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.