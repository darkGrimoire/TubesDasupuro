Program hsjhd;
uses pandas;

var
TBuku : TCSVArr;
i : integer;


begin
	readCSV('Buku.csv',TBuku);
	for i := 0 to 20 do
	begin
	removeRow(TBuku,i);
	end;
	writeCSV('Buku.csv',TBuku);
	TDestroy(TBuku);

end.
