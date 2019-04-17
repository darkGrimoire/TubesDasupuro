Program tes;

uses pandas, uBuku;

var
TBuku : TCSVArr;


begin
	readCSV('Buku.csv',TBuku);
	TWrite(TBuku);
	tambahJumlahBuku(TBuku);
	TWrite(TBuku);

end.