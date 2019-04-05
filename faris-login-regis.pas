Program LoginRegis;

uses csvdocument;

var
  choice: integer;
  role: string;

function Crypt(aText: string): string;
const
  PWD = '2u3r9upvjwq892kduw3ytnbjlxdhbaq3';
var
  i, len: integer;
begin
  len := Length(aText);
  if len > Length(PWD) then
    len := Length(PWD);
  SetLength(Crypt, len);
  for i := 1 to len do
    Crypt[i] := Chr(Ord(aText[i]) xor Ord(PWD[i]));
end;

procedure register();
var
  d: tcsvdocument;
  i, ROW: integer;
  input: string;

begin
  d := tcsvdocument.create();
  d.loadFromFile('User.csv');
  d.addRow('');
  ROW := d.rowcount-1;
  for i:=0 to 4 do
  begin
    case i of
      0 : begin
          write('Masukkan nama pengunjung: ');
          end;
      1 : begin
          write('Masukkan alamat pengunjung: ');
          end;
      2 : begin
          write('Masukkan username pengunjung: ');
          end;
      3 : begin
          write('Masukkan password pengunjung: ');
          end;
      4 : begin
          write('Masukkan role pengunjung: ');
          end;
    end;
    readln(input);
    input:=Crypt(input);
    d.cells[i,ROW]:=input;
    //writeln(d.cells[i,ROW]);
    //writeln(Crypt(d.cells[i,ROW]));
  end;
  d.savetofile('User.csv');
  d.destroy;
end;

function searchCellContain(d: tcsvdocument; OPT: integer; Where: integer; Text: string) : integer;
begin
  case OPT of
    1 : begin //Search Col
        searchCellContain := d.indexofcol(Text, Where);
        end;
    2 : begin //Search Row
        searchCellContain := d.indexofrow(Text, Where);
        end;
    end;
end;

procedure login(var Role : string);
var
  d: tcsvdocument;
  username,password: string;
  ret: integer;
begin
  d := tcsvdocument.create();
  d.loadfromfile('User.csv');
  write('Masukkan username: ');
  readln(username);
  write('Masukkan password: ');
  readln(password); writeln('');
  username:=Crypt(username);
  password:=Crypt(password);
  ret := searchCellContain(d,2,2,username);
  writeln(ret,' ',password, ' ', d.cells[3,ret]);
  if (ret=-1) or (password <> d.cells[3,ret]) then
  begin
    writeln('Username / password salah! Silakan coba lagi.');
    Role := '';
    d.destroy;
  end else
  begin
    writeln('Selamat datang ', Crypt(d.cells[0,ret]), '!');
    Role := Crypt(d.cells[4,ret]);
    d.destroy;
  end;
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
    writeln('[2] Login Akun'); writeln('');
    write('Pilihan: ');
    readln(choice);
    case choice of
      1 : begin
          register();
          end;
      2 : begin
          login(role);
          writeln(role);
          end;
    end;
    writeln('---'); writeln('');
  end;
end.