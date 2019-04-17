unit uUser;

interface
uses pandas, crt;

const
  _nama = 0;
  _Alamat = 1;
  _username = 2;
  _password = 3;
  _role = 4;

{ Subprogram Pembantu }
function Crypt(aText: string): string;
function Decrypt(aText: string): string;
procedure hashPassword(var TCSV: TCSVArr);
procedure unhashPassword(var TCSV: TCSVArr);
procedure readMasked(var line: string);
function isUsernameExist(TCSV: TCSVArr; Text: string) : boolean;

{ Modul Utama }
procedure register();
procedure login(var Role : string);

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
  for i := 1 to len do
  begin
    Crypt[i] := Chr(Ord(aText[i]) + Ord(PWD[j]));
    Inc(j);
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
while ord(key)<>13 do
begin
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
  if ord(key)=0 then
  begin
    specialChar:=true;
  end else
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

procedure register();
var
  TUser: TCSVArr;
  aRow: TRow;
  i: integer;
  input,input2: string;

begin
  readCSV('user.csv',TUser);
  SetLength(aRow.Arr,TUser.Col);
  // hashPassword(TUser);
  Clrscr();
  writeln('Kosongkan input untuk UNDO'); writeln;
  //TWrite(TUser);
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
    //input
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
  Clrscr();
  unhashPassword(TUser);
  TWrite(TUser);
  hashPassword(TUser);
  write('Masukkan username: ');
  readln(username);
  write('Masukkan password: ');
  readMasked(password); writeln;
  // password:=Crypt(password);
  ret := searchCellContain(TUser,_username,username);
  //writeln(ret,' ',password, ' ', d.cells[3,ret]);
  if (ret=-1) or (password <> Decrypt(TUser.Arr[ret][_password])) then
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
    writeln(Role);
    TDestroy(TUser);
  end;
  readkey;
end;

end.