Program aplikasiPerpustakaan;

uses crt, uUser, uBuku;

var
  choice: integer;
  role: string;

begin
while true do
  begin
    Clrscr();
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