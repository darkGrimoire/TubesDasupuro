(*Admin bisa melihat statistik yang berkaitan dengan pengguna dan buku.
* Statistik pengguna berisi daftar banyak pengguna per kategori admin dan pengunjung.
* Statistik buku berisi jumlah total buku pada setiap kategori.*)

Program Statistik;
uses pandas;

const
  _nama = 0;
  _Alamat = 1;
  _username = 2;
  _password = 3;
  _role = 4;

  _idBuku = 0;
  _judulBuku = 1;
  _author = 2;
  _sumBuku = 3;
  _tahun = 4;
  _kategori = 5;

var
	jumlahAdmin : integer;
	jumlahNonAdmin : integer;
	menu : integer;
	TUser: TCSVArr;
	TBuku : TCSVArr;
	jSastra : integer;
	jManga :integer;
	jProgramming :integer;
	jSains :integer;
	jSejarah :integer;
	i : integer;


begin
jumlahAdmin := 0; jumlahNonAdmin := 0; jSastra := 0; jManga := 0; jProgramming := 0; jSains := 0; jSejarah := 0;
readCSV('User.csv', TUser);
TWrite(TUser);
readCSV('Buku.csv', TBuku);
TWrite(TBuku);
for i:=0 to TUser.row-1 do
	if TUser.Arr[i][_role]='admin' then
		jumlahAdmin := 1 + jumlahAdmin
	else //pengunjung
		jumlahNonAdmin := 1 + jumlahNonAdmin;
writeln ('Jumlah admin: ', jumlahAdmin );
writeln ('Jumlah pengunjung: ', jumlahNonAdmin);
writeln ('Total: ', jumlahAdmin + jumlahNonAdmin);
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
writeln ('----------');
writeln ('Menu:');
writeln ('(1) Kembali ke menu utama');
writeln ('(2) Keluar dari program');
readln(menu);
end.

