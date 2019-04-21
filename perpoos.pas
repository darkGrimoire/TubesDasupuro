Program Perpoos;

uses crt, pandas, uUser, uBuku, uLoadSave;

var
  choice: integer;
  role: string;
  logged: boolean = false;

begin
Load();
while true do
  begin
  while not logged do
  begin
    Clrscr;
    GotoXY(1,1);
    writeln('                                                      ___________');
    writeln('____________________________________________________/  L O G I N |_');
    GotoXY(1,5);
    login(role, TUser);
    if role<>'' then logged:=true;
  end;
    Clrscr();
    writeln('-----MENU [WIP]----- [ROLE: ',role,']');
    writeln('[1] Registrasi Akun ');
    // writeln('[2] Login Akun');
    writeln('[3] Cari Buku (Kategori)');
    writeln('[4] Cari Buku (Tahun)');
    writeln('[5] Tambah Buku');
    writeln('[6] Tambah Jumlah Buku');
    writeln('[9] Exit (Save)'); writeln('');
    // TWrite(TUser);
    write('Pilihan: ');
    readln(choice);
    case choice of
      1 : register(TUser);
      // 2 : begin
      //     login(role,TUser);
      //     writeln(role);
      //     end;
      3 : cariBukuKategori(TBuku);
      4 : cariBukuTahun(TBuku);
      5 : tambahBuku(TBuku);
      6 : tambahJumlahBuku(TBuku);
      9 : begin
          Save();
          logged:=false;
          Load();
          end;
    end;
    writeln('---'); writeln('');
  end;

end.