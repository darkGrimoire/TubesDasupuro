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
// prosedur ini digunakan oleh admin untuk melihat statistik yang berkaitan dengan pengguna
	// dan buku. Statistik pegguna berisi daftar banyak anggota per kategori admin dan pengunjung.
	// STatistik buku berisi jumlah total buku pada setiap kategori
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
  Clrscr;																// membersihkan tampilan dari jendela sebelumnya
  jumlahAdmin := 0; jumlahNonAdmin := 0; jSastra := 0; jManga := 0; jProgramming := 0; jSains := 0; jSejarah := 0;
  // readCSV('User.csv', TUser);
  // TWrite(TUser);
  // readCSV('Buku.csv', TBuku);
  // TWrite(TBuku);
  for i:=0 to TUser.row-1 do											// pengulangan dari baris pertama hingga terakhir dari User.csv
    if TUser.Arr[i][_role]='admin' then									// ketika ditemukan role dari seorang pengguna adalah 'admin'
      jumlahAdmin := 1 + jumlahAdmin									// maka jumlah admin bertambah 1
    else 																// ketika ditemukan role dari seorang pengguna bukan 'admin' melainkan 'pengunjung'
      jumlahNonAdmin := 1 + jumlahNonAdmin;								// maka jumlah pengguna bertambah 1
  writeln ('Jumlah admin: ', jumlahAdmin );								// program menuliskan jumlah admin
  writeln ('Jumlah pengunjung: ', jumlahNonAdmin);						// program menuliskan jumlah pengunjung
  writeln ('Total: ', jumlahAdmin + jumlahNonAdmin);					// program menuliskan jumlah admin dan pengunjung
  writeln('Tekan tombol apapun untuk melanjutkan');						// prorgam akan menyuruh pengguna untuk menekan tombol apapun untuk melanjutkan program setelah ditampilkan statistika pengguna
  readkey;
  for i:=0 to TBuku.row-1 do											// pengulangan dari baris pertama hingga terakhir dari Buku.csv
  begin
    if TBuku.Arr[i][_kategori]='Sastra' then							// ketika kategori buku adalah sastra
      jSastra := 1 + jSastra											// maka jumlah buku sastra bertambah 1
    else if TBuku.Arr[i][_kategori]='Manga' then						// ketika kategori buku adalah manga
      jManga := 1 + jManga												// maka jumlah buku manga bertambah 1
    else if TBuku.Arr[i][_kategori]='Programming' then					// ketika kategori buku adalah programming
      jProgramming := 1 + jProgramming									// maka jumlah buku programming bertambah 1
    else if TBuku.Arr[i][_kategori]='Sains' then						// ketika kategori buku adalah sanis
      jSains := 1 + jSains												// maka jumlah buku sains bertambah 1
    else if TBuku.Arr[i][_kategori]='Sejarah' then						// ketika kategori buku adalah sejarah
      jSejarah := 1 + jSejarah;											// maka jumlah buku sejarah bertambah 1
  end;
  writeln ('Jumlah buku sastra : ', jSastra);							// program menuliskan jumlah buku sastra
  writeln ('Jumlah buku manga : ', jManga);								// program menuliskan jumlah buku manga
  writeln ('Jumlah buku programming : ', jProgramming);					// prorgam menuliskan jumlah buku programming
  writeln ('Jumlah buku sains : ', jSains);								// program menuliskan jumlah buku sains
  writeln ('Jumlah buku sejarah : ', jSejarah);							// program menuliskan jumlah buku sejarah
  writeln ('Total: ', jSastra + jManga + jProgramming + jSains + jSejarah);			// program menjumlahkan seluruh buku
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');			// program akan menyuruh pengguna untuk menekan tombol apapun untuk melanjutkan program
  readkey;
end;

end.
