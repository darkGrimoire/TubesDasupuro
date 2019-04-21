program pengembalianbuku;

uses pandas,crt;

function isTelat(d1, m1, y1, d2, m2, y2 : integer) : boolean;
{ true jika telat }
{ 1 = dikembalikan, 2 = harusnya balik kapan }
{ ALGORITMA }
begin
	if y1=y2 then
	begin
		if m1=m2 then
		begin
			if d1<=d2 then
			begin
				isTelat:= False;
			end else if d1>d2 then
			begin
				isTelat:= True;
			end;
		end else if m1<m2 then
		begin
			isTelat:= False;
		end else if m1>m2 then
		begin
			isTelat:= True;
		end;
	end else if y1<y2 then
	begin
		isTelat:= False;
	end else if y1>y2 then
	begin
		isTelat:= True;
	end;
end;


function nilai(date: char): integer; //ngubah string tanggal jadi integer
begin
	nilai:= ord(date)-48;
end;


Procedure kembalikan_buku();
const
	_user = 0;
	_id = 1;
	_tanggalPinjam = 2;
	_status = 3;
var
	i: integer;
	ID_Kembali, user, Judul_Kembali: string;
	Tanggal_Peminjaman, Tanggal_Batas, tanggaltoday: string;
	a,b,c,d,e,f: integer;
	TKembali: TCSVArr;
	TPinjam: TCSVArr;
	new: TRow;	
begin
	readCSV('file_history_pengembalian.csv', TKembali);
	TWrite(TKembali);
	
	readCSV('file_history_peminjaman.csv', TPinjam);
	TWrite(TPinjam);
	
	while i<TPinjam.row
	
	write('Masukkan id buku yang dikembalikan: ');
	readln(ID_kembali);
	writeln('Data peminjaman:');
	write('Username: ');
	readln(user);
	write('Judul buku: ');
	readln(Judul_Kembali);
	write('Tanggal peminjaman: ');
	readln(Tanggal_Peminjaman);
	write('Tanggal batas peminjaman: ');
	readln(Tanggal_Batas);
	writeln(' ');
	write('Masukkan tanggal hari ini: ');
	readln(tanggaltoday);
	
	{ MASUKIN KE FILE }
	SetLength(new.Arr,3);
	new.Arr[0] := user;
	new.Arr[1] := ID_Kembali;
	new.Arr[2] := tanggaltoday;
	addRow(TKembali,new);
	writeCSV('file_history_pengembalian.csv', TKembali);

	{ CONV TANGGAL }
	a := 10*nilai(tanggaltoday[1]) + nilai(tanggaltoday[2]);
	b := 10*nilai(tanggaltoday[4]) + nilai(tanggaltoday[5]);
	c := 1000*nilai(tanggaltoday[7]) + 100*nilai(tanggaltoday[8]) + 10*nilai(tanggaltoday[9]) + nilai(tanggaltoday[10]);
	d := 10*nilai(Tanggal_Batas[1]) + nilai(Tanggal_Batas[2]);
	e := 10*nilai(Tanggal_Batas[4]) + nilai(Tanggal_Batas[5]);
	f := 1000*nilai(Tanggal_Batas[7]) + 100*nilai(Tanggal_Batas[8]) + 10*nilai(Tanggal_Batas[9]) + nilai(Tanggal_Batas[10]);
	
	{ CEK TANGGAL }
	if isTelat(a, b, c, d, e, f) then
	begin
		writeln('Anda terlambat mengembalikan buku.');
	end else
	begin
		writeln('Terima kasih sudah meminjam.');
	end;
	TDestroy(TKembali);
	
	{ PERBAIKI STATUS }
	i:=1;
	while i<TPinjam.Row and TPinjam.Arr[i][_idBuku] <> ID_dipinjam and TPinjam.Arr[i][_tanggalPinjam] <> Tanggal_Dipinjam and TPinjam.Arr[i][_user] <> username do
	begin
		TPinjam[i][3] := 'sudah';
		inc(i);
	end;
end;

begin
kembalikan_buku();

end.
