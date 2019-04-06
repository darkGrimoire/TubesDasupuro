Program LoginRegis;

uses csvdocument, csvreadwrite;

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

function isUsernameExist(d: tcsvdocument; Text: string) : boolean;
begin
  Text:=ChangeLineEndings(Crypt(Text), sLineBreak);
  if searchCellContain(d,2,2,Text)=-1 then
  begin
    isUsernameExist:=false;
  end else
  begin
    isUsernameExist:=true;
  end;
end;

function isKategoriValid(Text: string) : boolean;
begin
  isKategoriValid := (Text='sastra') or (Text='sains') or (Text='manga') or (Text='sejarah') or (Text='programming');
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
    readln(input);
    if i=2 then
      while isUsernameExist(d,input) do
      begin
        writeln('Username Sudah ada!');
        write('Masukkan username: ');
        readln(input);
      end;
    d.cells[i,ROW]:=Crypt(input);
    //writeln(d.cells[i,ROW]);
    //writeln(Crypt(d.cells[i,ROW]));
  end;
  d.savetofile('User.csv');
  d.destroy;
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
  username := ChangeLineEndings(Crypt(username), sLineBreak);
  password := ChangeLineEndings(Crypt(password), sLineBreak);
  ret := searchCellContain(d,2,2,username);
  //writeln(ret,' ',password, ' ', d.cells[3,ret]);
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

procedure cariBukuKategori();
var
  d: tcsvdocument;
  input: string;
  i: integer;

begin
  d := tcsvdocument.create();
  d.loadfromfile('Buku.csv');
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
  while i < d.rowcount do
  begin
    if (input <> d.Cells[5,i]) then
    begin
      d.RemoveRow(i);
    end else
    begin
      i:=i+1;
    end;
  end;
  writeln('Hasil pencarian:');
  if d.rowcount=0 then
  begin
    writeln('Tidak ada buku dalam kategori ini.');
  end else
  begin
    for i:=0 to d.rowcount-1 do
    begin
      write(d.Cells[0,i]); write(' | ');
      write(d.Cells[1,i]); write(' | ');
      write(d.Cells[2,i]); writeln('');
    end;
  end;
  d.destroy;
end;

procedure cariBukuTahun();
var
  d: tcsvdocument;
  tahun, kategori: string;

begin
  write('Masukkan tahun: '); readln(tahun);
  write('Masukkan kategori: '); readln(kategori);

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
    writeln('[3] Cari Buku (Kategori)'); writeln('');
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
      3 : begin
          cariBukuKategori();
          end;
    end;
    writeln('---'); writeln('');
  end;
end.