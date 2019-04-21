Program Perpoos;

uses crt, pandas, uUser, uBuku, uLoadSave, uPinjam, uKembali, uHilang;

var
  choice: integer;
  role: string;
  logged: boolean = false;
  loggedUser: string;
  yn: string;

begin
Load();
while true do
  begin
  while not logged do
  begin
    Clrscr;
    GotoXY(1,1);
    writeln('+--------------------------------+                                 ');
    writeln('| WAN SHI TONG MENUNGGU ANDA!1!1 |                    ___________  ');
    writeln('+________________________________+__________________/  L O G I N |_');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('                                                                  |');
    writeln('__________________________________________________________________|');
    GotoXY(1,5);
    login(role,loggedUser, TUser);
    if role<>'' then logged:=true;
  end;
  if role='admin' then
  begin
    Clrscr();
    writeln('*******************************************************************');
    writeln('*             APLIKASI PERPOOS WAN SHI TONG                       *');
    writeln('*******************************************************************');
    writeln('                                      \        Status: ADMIN      |');
    writeln('[1] Registrasi Akun                    \  Hai, ',loggedUser:17,'! |');
    writeln('[2] Cari Buku (Kategori)                \_________________________|');
    writeln('[3] Cari Buku (Tahun)                                             |');
    writeln('[4] Lihat Laporan Buku                                            |');
    writeln('[5] Tambah Buku                                                   |');
    writeln('[6] Tambah Jumlah Buku                                            |');
    writeln('[7] Lihat Riwayat Peminjaman                                      |');
    writeln('[8] Statistik                                                     |');
    writeln('[9] Cari Anggota                                                  |');
    writeln('[0] Exit (Save)                                                   |');
    writeln('                                                                  |');
    writeln('                                  +-------------------------------+');
    writeln('                                  | Copyrighted and Authored by:  |');
    writeln('     _   _          _   _         |          16518245 Faris-kun   |');
    writeln('    | | | |_      _| | | |        |          16518336 Shafa       |');
    writeln('    | | | \ \ /\ / / | | |        |          16518301 Jingga      |');
    writeln('    | |_| |\ V  V /| |_| |        |          16518399 Nisa Rifdah |');
    writeln('     \___/  \_/\_/  \___/         |          16518357 Tifany      |');
    writeln('__________________________________+_______________________________|');
    GotoXY(1,15);
    write('Pilihan: ');
    readln(choice);
    case choice of
      1 : register(TUser);
      2 : cariBukuKategori(TBuku);
      3 : cariBukuTahun(TBuku);
      4 : lihatLaporHilang(THilang, TBuku);
      5 : tambahBuku(TBuku);
      6 : tambahJumlahBuku(TBuku);
      7 : riwayat(TPinjam);
      8 : Statistik(TUser,TBuku);
      9 : cariAnggota(TUser);
      0 : begin
          writeln('Simpan file (Y/N) ? ');
          readln(yn);
          Lowercase(yn);
          if yn='y' then
          begin
            Save();
            logged:=false;
            Load();
          end;
          end;
    end;
  end else //role='user'
  begin
    Clrscr();
    writeln('*******************************************************************');
    writeln('*             APLIKASI PERPOOS WAN SHI TONG                       *');
    writeln('*******************************************************************');
    writeln('                                      \        Status: USER       |');
    writeln('[1] Cari Buku (Kategori)               \  Hai, ',loggedUser:17,'! |');
    writeln('[2] Cari Buku (Tahun)                   \_________________________|');
    writeln('[3] Peminjaman Buku                                               |');
    writeln('[4] Pengembalian Buku                                             |');
    writeln('[5] Lapor Buku Hilang                                             |');
    writeln('[0] Exit (Save)                                                   |');
    writeln('                                                                  |');
    writeln('                                  +-------------------------------+');
    writeln('                                  | Copyrighted and Authored by:  |');
    writeln('     _   _          _   _         |          16518245 Faris-kun   |');
    writeln('    | | | |_      _| | | |        |          16518336 Shafa       |');
    writeln('    | | | \ \ /\ / / | | |        |          16518301 Jingga      |');
    writeln('    | |_| |\ V  V /| |_| |        |          16518399 Nisa Rifdah |');
    writeln('     \___/  \_/\_/  \___/         |          16518357 Tifany      |');
    writeln('__________________________________+_______________________________|');
    GotoXY(1,12);
    write('Pilihan: ');
    readln(choice);
    case choice of
      1 : cariBukuKategori(TBuku);
      2 : cariBukuTahun(TBuku);
      3 : pinjam_buku(loggedUser,TBuku,TPinjam);
      4 : kembalikan_buku(TKembali, TPinjam);
      5 : laporHilang(THilang);
      0 : begin
          writeln('Simpan file (Y/N) ? ');
          readln(yn);
          Lowercase(yn);
          if yn='y' then
          begin
            Save();
            logged:=false;
            Load();
          end;
          end;
    end;
  end;
end;

end.