program riwayatpeminjaman;

uses pandas,crt;

procedure riwayat();
const
	_user = 0;
	_tanggal = 1;
	_id = 2;
	_judul = 3;
var
	i: integer;
	TPinjam: TCSVArr;
	user: string;
begin 
	write('Masukkan username pengunjung: ');
	readln(user);
	writeln('Riwayat:');
	readCSV('file_history_peminjaman.csv', TPinjam);
	//Lowercase(TPinjam.Arr[i][_user]);
	//Lowercase(user);
	for i:=1 to TPinjam.row-1 do
	begin
		if user=TPinjam.Arr[i][_user] then
		begin
			write(TPinjam.Arr[i][_tanggal]); write(' | ');
			write(TPinjam.Arr[i][_id]); write(' | ');
			write(TPinjam.Arr[i][_judul]); writeln('');
		end;
	end;
end;

begin
riwayat();

end.
