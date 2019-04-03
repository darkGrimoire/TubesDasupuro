Program LoginRegis;

uses csvdocument;

var
  d: tcsvdocument;
  x,y: integer;
  txt: string;

function Crypt(aText: string): string;
const
  PWD = '2u3r9upvjwq892kduw3ytnbjlxdhbaq398thewo392trgh8ghg98gpgpqu9ghq8ghwghq4i3uq0g93rygprjber8ugqmfzpbjmw340235u9tjrehoidjghoitjabhdxu';
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
  i: integer;
  input: string;

begin
  d := tcsvdocument.create();
  d.loadFromFile('User.csv');
  for i:=0 to 4 do
  begin
    case i of
      0 : begin
          write('Masukkan nama pengunjung:');
          end;
      1 : begin
          write('Masukkan alamat pengunjung:');
          end;
      2 : begin
          write('Masukkan username pengunjung:');
          end;
      3 : begin
          write('Masukkan password pengunjung:');
          end;
      4 : begin
          write('Masukkan role pengunjung:');
          end;
    end;
    readln(input);
    input:=Crypt(input);
    d.cells[d.rowcount,i]:=input;
    writeln(d.cells[d.rowcount,i]);
    writeln(Crypt(d.cells[d.rowcount,i]));
  end;
  d.savetofile('Users.csv')
end;

procedure login();
var
  d: tcsvdocument;
  input: string;
begin
  d := tcsvdocument.create();
  d.loadfromfile('User.csv');
  
end;

begin
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
  txt:=Crypt('Shafa Amarsya Madyaratri 16518336');
  writeln('Encrypted: ', txt);
  writeln('Decrypted: ', Crypt(txt));
  writeln();
  register();
end.