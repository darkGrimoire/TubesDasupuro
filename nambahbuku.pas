Program tambahbuku;

uses pandas;

procedure addBook (new : TRow);
begin
writeln('Masukkan data buku: ');
readln(new.Arr);

addRow(TCSVBuku,new);
writeCSV(Buku.csv, TCSVBuku);

end;



