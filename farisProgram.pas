Program mainFaris;

uses pandas,crt;

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
  role: string;
  choice: integer;

function Crypt(aText: string): string;
const
  PWD = 'hM!7JG$YeP9W~Smr*NK3&L2@cdy?Vx+M';
var
  i,j,len: integer;
begin
  len := Length(aText);
  SetLength(Crypt, len);
  j:=1;
  for i := 1 to len do
  begin
    Crypt[i] := Chr(Ord(aText[i]) + Ord(PWD[j]));
    Inc(j);
    if j>Length(PWD) then j:=1;
  end;
end;

procedure readMasked(var line: string);
var
  key: char;
  specialChar: boolean = false;

begin
line:='';
key:=readkey;
while ord(key)<>13 do
begin
  if ord(key)=8 then
  begin
    write(key);
    write(' ');
    write(key);
    delete(line,Length(line),1);
  end else
  if ord(key)=0 then
  begin
    specialChar:=true;
  end else
  if (ord(key)>31) and (ord(key)<126) then
  begin
    if not specialChar then
    begin
      write('*');
      line:= line + key
    end else
    begin
      specialChar:=false;
    end;
  end;
  key:=readkey;
end;
writeln;
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


function isUsernameExist(TCSV: TCSVArr; Text: string) : boolean;
begin
  if searchCellContain(TCSV,_username,Text)=-1 then
    isUsernameExist:=false
  else
    isUsernameExist:=true;
end;

function isKategoriValid(Text: string) : boolean;
begin
  isKategoriValid := (Text='Sastra') or (Text='Sains') or (Text='Manga') or (Text='Sejarah') or (Text='Programming');
end;

procedure register();
var
  TUser: TCSVArr;
  aRow: TRow;
  i: integer;
  input: string;

begin
  readCSV('user.csv',TUser);
  SetLength(aRow.Arr,TUser.Col);
  //TWrite(TUser);
  for i:=0 to TUser.Col-1 do
  begin
    case i of
      0 : begin
          write('Masukkan nama: ');
          end;
      1 : begin
          write('Masukkan alamat: ');
          end;
      2 : begin
          write('Masukkan username: ');
          end;
      3 : begin
          write('Masukkan password: ');
          end;
      4 : begin
          write('Masukkan role: ');
          end;
    end;
    if i=3 then
      readMasked(input)
    else
      readln(input);
    if i=2 then
      while isUsernameExist(TUser,input) do
      begin
        writeln('Username Sudah ada!');
        write('Masukkan username: ');
        readln(input);
      end;
    if i=3 then
      // aRow.Arr[i]:=Crypt(input)
      aRow.Arr[i]:=input
    else
      aRow.Arr[i]:=input;
  end;
  addRow(TUser,aRow);
  writeCSV('user.csv',TUser);
  TDestroy(TUser);
end;

procedure login(var Role : string);
var
  TUser: TCSVArr;
  username,password: string;
  ret: integer;
begin
  readCSV('user.csv',TUser);
  TWrite(TUser);
  write('Masukkan username: ');
  readln(username);
  write('Masukkan password: ');
  readln(password); writeln('');
  // password:=Crypt(password);
  ret := searchCellContain(TUser,_username,username);
  //writeln(ret,' ',password, ' ', d.cells[3,ret]);
  if (ret=-1) or (password <> TUser.Arr[ret][_password]) then
  begin
    // writeln(ret);
    // writeln(password);
    // writeln(TUser.Arr[ret][_password]);
    writeln('Username / password salah! Silakan coba lagi.');
    Role := '';
    TDestroy(TUser);
  end else
  begin
    writeln('Selamat datang ', TUser.Arr[ret,_nama], '!');
    Role := TUser.Arr[ret,_role];
    TDestroy(TUser);
  end;
end;

procedure cariBukuKategori();
var
  TBuku: TCSVArr;
  input: string;
  i: integer;

begin
  readCSV('Buku.csv',TBuku);
  sortCSV(TBuku,_judulBuku);
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
  TDestroy(TBuku);
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

procedure cariBukuTahun();
var
  TBuku: TCSVArr;
  inOpt: string;
  input,i,tahun: integer;

begin
  readCSV('Buku.csv',TBuku);
  sortCSV(TBuku,_judulBuku);
  write('Masukkan tahun: ');
  readln(input);
  write('Masukkan kategori: ');
  readln(inOpt);
  writeln;
  i:=0;
  while i < TBuku.Row do
  begin
    Val(TBuku.Arr[i][_tahun],tahun);
    if not isValidTahun(tahun,inOpt,input) then
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
  TDestroy(TBuku);
end;

begin
  {
  d := tcsvdocument.create();
  d.loadFromFile('User.csv');
  for y:=0 to d.rowcount-1 do
  begin
    for x:=0 to d.maxcolcount-1 do
    begin
      write('"', d.cells[x,y], '" ');
    end;
    writeln();
  end;
  writeln();
  }
  //txt:=Crypt('Shafa Amarsya Madyaratri 16518336');
  //writeln('Encrypted: ', txt);
  //writeln('Decrypted: ', Crypt(txt));
  //writeln();
  //register();
  while true do
  begin
    writeln('-----MENU [WIP]-----');
    writeln('[1] Registrasi Akun ');
    writeln('[2] Login Akun');
    writeln('[3] Cari Buku (Kategori)');
    writeln('[4] Cari Buku (Tahun)'); writeln('');
    write('Pilihan: ');
    readln(choice);
    case choice of
      1 : register();
      2 : begin
          login(role);
          writeln(role);
          end;
      3 : cariBukuKategori();
      4 : cariBukuTahun();
    end;
    writeln('---'); writeln('');
  end;
end.