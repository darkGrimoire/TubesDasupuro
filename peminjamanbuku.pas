program peminjamanbuku;

uses pandas,crt;

procedure pinjam_buku(username: string);
const
	//tpinjam
	_user = 0;
	_id = 1;
	_tanggalPinjam = 2;
	_status = 3;
	//tbuku
	_idBuku = 0;
	_judulBuku = 1;
	_author = 2;
	_jumlah = 3;
	_tahun = 4;
	_kategori = 5;
var
	i, tempint: integer;
	//ID_dipinjam: integer;
	ID_dipinjam, tanggal_dipinjam,tempstr: string;
	TBuku: TCSVArr;
	TPinjam: TCSVArr;
	new: TRow;
	status: string;
	found: boolean = false;
begin
	readCSV('file_history_peminjaman.csv', TPinjam);
	TWrite(TPinjam);
	readCSV('Buku.csv', TBuku);
	TWrite(TBuku);
	write('Masukkan id buku yang ingin dipinjam: ');
	readln(ID_dipinjam);
	write('Masukkan tanggal hari ini: ');
	readln(tanggal_dipinjam);
	SetLength(new.Arr,4);
	i:=1;
	while i < TBuku.Row) do
	begin
		if TBuku.Arr[i][_idBuku] = ID_dipinjam then
		begin
			if TBuku.Arr[i][_jumlah]>'0' then
			begin
				status:= 'belum';
				val(TBuku.Arr[i][_jumlah],tempint);
				dec(tempint);
				str(tempint,tempstr);
				TBuku.Arr[i][_jumlah]:=tempstr;
				new.Arr[0] := username;
				new.Arr[1] := ID_Dipinjam;
				new.Arr[2] := tanggal_dipinjam;
				new.Arr[3] := status;
				addRow(TPinjam,new);
				writeCSV('file_history_peminjaman.csv', TPinjam);
				writeln('Tersisa ', TBuku.Arr[i][_jumlah], ' buku ', TBuku.Arr[i][_judulBuku],'.');
				writeln('Terima kasih sudah meminjam.');
			end else
			begin
				writeln('Buku ', TBuku.Arr[i][_judulBuku], ' sedang habis!');
				writeln('Coba lain kali.');
			end;
		end else
		begin
			inc(i);
		end;
	end;
	TDestroy(TPinjam);
end;

begin
pinjam_buku('Fawwis');

end.
