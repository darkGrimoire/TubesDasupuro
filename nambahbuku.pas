Program tambahbuku;

uses pandas;

var
TBuku : TCSVArr;
i : integer;

function searchCellContain(TCSV: TCSVArr; Where: integer; Text: string) : integer;
var
  i: integer;
begin
  i:=0;
  searchCellContain:=-1;
  while (i<=TCSV.Row-1) and (searchCellContain=-1) do
  begin
    if Text=TCSV.Arr[i][Where] then
      searchCellContain:=i;
    Inc(i);
  end;
end;


procedure addBook(TBuku: TCSVArr);

const
	idBuku = 0;
	judul = 1;
	author = 2;
	jumlah = 3;
	tahun = 4;
	kategori = 5;


var
	
	new: TRow;
	input: string;


begin
	SetLength(new.Arr,TBuku.Col);
	writeln('Masukkan data buku: ');
	for i := 0 to TBuku.Col-1 do 
	begin
		case i of 
		0 : begin
			write('ID Buku: ');
			end;
		1 : begin
			write('Judul Buku: ');
			end;
		2 : begin
			write('Author: ');
			end;
		3 : begin
			write('Jumlah Buku: ');
			end;
		4 : begin
			write('Tahun penerbitan: ');
			end;
		5 : begin
			write('Kategori: ');
			end;
		end;
	readln(input);
	new.Arr[i] := input;
	end;
	addRow(TBuku,new);
	writeCSV('Buku.csv', TBuku);
	TWrite(TBuku);
end;

procedure addBookNumber(var TBuku: TCSVArr);
	var
		new: integer;
		input, newnumber: string;
		rowbuku, jmlbuku: integer;

	begin
		writeln('Pilih buku: ');
		readln(input);
		rowbuku := searchCellContain(TBuku, 1, input);
		
		write('Masukkan jumlah tambahan buku: ');
		readln(new);
		val(TBuku.Arr[rowbuku][3], jmlbuku);
		jmlbuku := jmlbuku + new;
		str(jmlbuku, newnumber);
		TBuku.Arr[rowbuku][3] := newnumber;

	end;



begin
	readCSV('Buku.csv',TBuku);
	TWrite(TBuku);
	addBook(TBuku);
	addBookNumber(TBuku);

end.




