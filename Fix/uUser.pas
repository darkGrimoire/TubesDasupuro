unit uUser;

interface
uses pandas, crt;

{ Subprogram Pembantu }
//Fungsi Hash Password
function Crypt(aText: string): string;
//Fungsi decrypt Hash Password (for debug purpose)
function Decrypt(aText: string): string;
//prosedur hash semua password dalam satu TCSV (for debug purpose)
procedure hashPassword(var TCSV: TCSVArr);
//prosedur decrypt hash semua password dalam satu TCSV (for debug purpose)
procedure unhashPassword(var TCSV: TCSVArr);
//procedure read agar kelihatannya bintang2
procedure readMasked(var line: string);
//fungsi cek username sudah ada atau tidak
function isUsernameExist(TCSV: TCSVArr; Text: string) : boolean;

{ Modul Utama }
//Modul registrasi akun, hanya bisa dilakukan administrator
procedure register(var TUser: TCSVArr);
//Modul login tiap kali aplikasi jalan
procedure login(var Role : string; var loggedUser: string; var TUser: TCSVArr);
//Modul cari anggota (username) dan tampilkan datanya
procedure cariAnggota(TUser: TCSVArr);

implementation

function Crypt(aText: string): string;
const
  PWD = 'hM!7JG$YeP9W~Smr*NK3&L2@cdy?Vx+M';
var
  i,j,len: integer;
begin
  len := Length(aText);
  SetLength(Crypt, len);
  j:=1;
  //geser aText dengan PWD yang telah ditentukan per karakternya
  for i := 1 to len do
  begin
    Crypt[i] := Chr(Ord(aText[i]) + Ord(PWD[j]));
    Inc(j);
    //Jika length aText melebihi length PWD, PWD akan di loop dari awal.
    if j>Length(PWD) then j:=1;
  end;
end;

function Decrypt(aText: string): string;
const
  PWD = 'hM!7JG$YeP9W~Smr*NK3&L2@cdy?Vx+M';
var
  i,j,len: integer;
begin
  len := Length(aText);
  SetLength(Decrypt, len);
  j:=1;
  //Geser kembali ke semula hash menjadi password biasa
  for i := 1 to len do
  begin
    Decrypt[i] := Chr(Ord(aText[i]) - Ord(PWD[j]));
    Inc(j);
    if j>Length(PWD) then j:=1;
  end;
end;

procedure hashPassword(var TCSV: TCSVArr);
var
  i: integer;
begin
for i:=1 to TCSV.Row-1 do
  TCSV.Arr[i][_password]:=Crypt(TCSV.Arr[i][_password]);
end;

procedure unhashPassword(var TCSV: TCSVArr);
var
  i: integer;
begin
for i:=1 to TCSV.Row-1 do
  TCSV.Arr[i][_password]:=Decrypt(TCSV.Arr[i][_password]);
end;

procedure readMasked(var line: string);
var
  key: char;
  specialChar: boolean = false;

begin
line:='';
key:=readkey;
//Selama tidak terketik enter
while ord(key)<>13 do
begin
  //Jika terketik backspace, hapus karakter dan keluarkan dari buffer. Berhenti jika buffer sudah habis.
  if ord(key)=8 then
  begin
    write(key);
    write(' ');
    if length(line)<>0 then
    begin
      write(key);
      delete(line,Length(line),1);
    end;
  end else
  //Aktifkan flag special char (ESC, ARROW, F1-F12, DSB) 
  if ord(key)=0 then
  begin
    specialChar:=true;
  end else
  //Karakter yang terbaca keyboard masukkan ke buffer, kecuali flag special char sedang aktif
  if (ord(key)>31) and (ord(key)<126) then
  begin
    if not specialChar then
    begin
      write('*');
      line:= line + key;
    end else
    begin
      specialChar:=false;
    end;
  end;
  key:=readkey;
end;
writeln;
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

procedure register(var TUser: TCSVArr);
var
  aRow: TRow;
  i: integer;
  input,input2: string;

begin
  //set panjang array aRow
  SetLength(aRow.Arr,TUser.Col);
  //ClearScreen
  Clrscr();
  //input
  writeln('Kosongkan input untuk UNDO'); writeln;
  i:=0;
  while i<=TUser.Col-1 do
  begin
    case i of
      0 : begin
          write('Masukkan nama: ');  //write(wherex(), ' ', wherey());
          end;
      1 : begin
          write('Masukkan alamat: ');  //write(wherex(), ' ', wherey());
          end;
      2 : begin
          write('Masukkan username: ');  //write(wherex(), ' ', wherey());
          end;
      3 : begin
          write('Masukkan password: ');  //write(wherex(), ' ', wherey());
          end;
      4 : begin
          write('Masukkan role: ');  //write(wherex(), ' ', wherey());
          end;
    end;
    //input password
    if i=3 then
    begin
      readMasked(input);
      if input<>'' then
      begin
        write('Konfirmasi Password: ');
        readMasked(input2);
      end;
      if (input<>input2) and (input<>'') then
      begin
        writeln('Password salah! Ulangi.');
        inc(i);
        input:='';
      end;
    end else
      readln(input);
    //UNDO
    if input='' then
    begin
      if i=0 then
      begin
        dec(i);
        writeln('TIDAK BISA UNDO');
      end else
      begin
        DelLine;
        dec(i,2);
        DelLine;
      end;
    end else
    begin
      //validation
      if i=2 then
        while isUsernameExist(TUser,input) do
        begin
          writeln('Username Sudah ada!');
          write('Masukkan username: ');
          readln(input);
        end;
      //process
      if i=3 then
        aRow.Arr[i]:=Crypt(input)
        // aRow.Arr[i]:=input
      else
        aRow.Arr[i]:=input;
    end;
    inc(i);
  end;
  addRow(TUser,aRow);
end;

procedure login(var Role : string; var loggedUser: string; var TUser: TCSVArr);
var
  username,password: string;
  ret: integer;
begin
  write('Masukkan username: ');
  readln(username);
  write('Masukkan password: ');
  readMasked(password); writeln;
  ret := searchCellContain(TUser,_username,username);
  if (ret=-1) or (password <> Decrypt(TUser.Arr[ret][_password])) then
  begin
    writeln('Username / password salah! Silakan coba lagi.');
    Role := '';
    loggedUser := '';
  end else
  begin
    writeln('Selamat datang ', TUser.Arr[ret,_nama], '!');
    Role := TUser.Arr[ret,_role];
    loggedUser := TUser.Arr[ret,_username];
  end;
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

procedure cariAnggota(TUser: TCSVArr);
var
  input: string;
  ret: integer;

begin
  Clrscr;
  write('Masukkan username: ');
  readln(input);
  ret:=searchCellContain(TUser,_username,input);
  if ret<>-1 then
  begin
    writeln('Nama Anggota: ', TUser.Arr[ret][_nama]);
    writeln('Alamat Anggota: ', TUser.Arr[ret][_alamat]);
  end else //ret=-1, not found
  begin
    writeln('Anggota tidak ditemukan!');
  end;
  writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.