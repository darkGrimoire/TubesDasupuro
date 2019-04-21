Program plis;

uses pandas, uBuku;

var
TBuku : TCSVArr;


begin
readCSV('Buku.csv',TBuku);
tambahBuku(TBuku);

tambahJumlahBuku(TBuku);

TWrite(TBuku);

end.

