unit uBuku;

interface
uses pandas, crt;

{ Subprogram Pembantu }
//Cek Kategori buku yang dimasukkan valid tidaknya
function isKategoriValid(Text: string) : boolean;
//Cek operator tahun yang dimasukkan valid tidaknya
function isValidTahun(i: integer; optr: string; j: integer): boolean;
//cek judulnya ada atau tidak
function isJudulExist(TCSV: TCSVArr; Text: string) : boolean;

{ Modul Utama }
//Modul mencari buku berdasarkan kategorinya
procedure cariBukuKategori(TBuku: TCSVArr);
//Modul mencari buku berdasarkan tahun terbitnya
procedure cariBukuTahun(TBuku: TCSVArr);
//Modul menambah data buku dalam database
procedure tambahBuku(var TBuku: TCSVArr);
//Modul menambah jumlah buku yang ada di stock
procedure tambahJumlahBuku(var TBuku: TCSVArr);

procedure statistik(TUser, TBuku: TCSVArr);								
// prosedur ini digunakan oleh admin untuk melihat statistik yang berkaitan dengan pengguna
	// dan buku. Statistik pegguna berisi daftar banyak anggota per kategori admin dan pengunjung.
	// STatistik buku berisi jumlah total buku pada setiap kategori
	
implementation

{ Subprogram Pembantu }
function isKategoriValid(Text: string) : boolean;
begin
  //Validasi
  isKategoriValid := (Text='Sastra') or (Text='Sains') or (Text='Manga') or (Text='Sejarah') or (Text='Programming');
end;

function isValidTahun(i: integer; optr: string; j: integer): boolean;
begin
  //Validasi sesuai operator yang digunakan
  case optr of
    '=' : isValidTahun:= i=j;
    '<' : isValidTahun:= i<j;
    '>' : isValidTahun:= i>j;
    '>=' : isValidTahun:= i>=j;
    '<=' : isValidTahun:= i<=j;
  end;
end;

function isJudulExist(TCSV: TCSVArr; Text: string) : boolean;
begin
  //Cek ada tidaknya cell yang mengandung judul buku (Text) tersebut
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
  //Sesuaikan length array
  SetLength(TBuku.Arr,TBuku.Row,TBuku.Col);
  //Sortir array berdasakan judul buku
  sortCSV(TBuku,_judulBuku);
  //ClearScreen
  Clrscr();
  //Input
  writeln('Pilihan kategori: [Manga] [Programming] [Sains] [Sastra] [Sejarah]');
  write('Masukkan kategori: ');
  readln(input);
  //Validasi input
  while not isKategoriValid(input) do
    begin
      writeln('Kategori ', input, ' tidak valid.');
      write('Masukkan kategori: ');
      readln(input);
    end;
  writeln('');
  i:=1;
  //Buang Buku yang kategorinya tidak sesuai dari TBuku.Arr
  while i < TBuku.Row do
  begin
    if (input <> TBuku.Arr[i][_kategori]) then
      removeRow(TBuku,i)
    else
      inc(i);
  end;
  writeln('Hasil pencarian:');
  //Jika semua buku terbuang kecuali headernya
  if TBuku.Row=1 then
  begin
    writeln('Tidak ada buku dalam kategori ini.');
  end else
  //Buku yang sesuai kategori ada, lalu di print.
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
end;

procedure cariBukuTahun(TBuku: TCSVArr);
var
  inOpt: string;
  input,i,tahun: integer;

begin
  //Sesuaikan panjang array
  SetLength(TBuku.Arr,TBuku.Row,TBuku.Col);
  //Sortir array berdasakan judul buku
  sortCSV(TBuku,_judulBuku);
  //ClearScreen
  Clrscr();
  //Input
  write('Masukkan tahun: ');
  readln(input);
  write('Masukkan kategori (=,>,<,>=,<=): ');
  readln(inOpt);
  writeln;
  i:=1;
  //Buang buku yang tidak sesuai tahun terbitnya
  while i < TBuku.Row do
  begin
    Val(TBuku.Arr[i][_tahun],tahun);
    if not isValidTahun(tahun,inOpt,input) then
      removeRow(TBuku,i)
    else
      inc(i);
  end;
  writeln('Hasil pencarian:');
  //Jika semua buku terbuang kecuali headernya
  if TBuku.Row=1 then
  begin
    writeln('Tidak ada buku dalam kategori ini.');
  end else
  //Buku yang sesuai kategori ada, lalu di print.
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
end;

procedure tambahBuku(var TBuku: TCSVArr);

var
	
	new: TRow;
	input: string;
	i: integer;


begin
  //ClearScreen
  Clrscr();
  //Set cell dalam baris new.Arr
	SetLength(new.Arr,TBuku.Col);
  //input
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
  //Masukkan ke baris new.Arr
	new.Arr[i] := input;
	end;
  //tambahkan baris ke TBuku
	addRow(TBuku,new);
	writeln('Buku berhasil ditambahkan.');
end;

procedure tambahJumlahBuku(var TBuku: TCSVArr);
	var
		input, sJumlah: string;
		new, rowbuku, vJumlah: integer;

	begin
    //ClearScreen
    Clrscr();
    //Input
		writeln('Masukkan judul buku: ');
		readln(input);
    //Validasi judul
		while not(isJudulExist(TBuku,input)) do
		begin
		writeln('Buku tidak ditemukan.');
		write('Masukkan judul buku: ');
		readln(input);
		end;
    //cari index row input di TBuku
		rowbuku := searchCellContain(TBuku, _judulBuku, input);
		//set tambahan bukunya
		write('Masukkan jumlah tambahan buku: ');
		readln(new);
    //ubah string menjadi integer
		val(TBuku.Arr[rowbuku][_sumBuku], vJumlah);
		vJumlah := vJumlah + new;
    //ubah integer balik ke string
		str(vJumlah, sJumlah);
    //set cell tersebut jadi jumlah yang sudah ditambahkan
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
