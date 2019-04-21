unit uPinjam;

interface
uses pandas,crt;

procedure pinjam_buku(username: string; TBuku: TCSVArr; var TPinjam: TCSVArr);
procedure riwayat(TPinjam: TCSVArr);

implementation
procedure pinjam_buku(username: string; TBuku: TCSVArr; var TPinjam: TCSVArr);
var
	i, tempint: integer;
	//ID_dipinjam: integer;
	ID_dipinjam, tanggal_dipinjam,tempstr: string;
	new: TRow;
	status: string;
	found: boolean = false;

begin
	// readCSV('file_history_peminjaman.csv', TPinjam);
	// TWrite(TPinjam);
	// readCSV('Buku.csv', TBuku);
	// TWrite(TBuku);
	Clrscr;
	write('Masukkan id buku yang ingin dipinjam: ');
	readln(ID_dipinjam);
	write('Masukkan tanggal hari ini: ');
	readln(tanggal_dipinjam);
	SetLength(new.Arr,4);
	i:=1;
	while (i < TBuku.Row) and (not found) do
	begin
		if TBuku.Arr[i][_idBuku] = ID_dipinjam then
		begin
			if TBuku.Arr[i][_sumBuku]>'0' then
			begin
				status:= 'belum';
				val(TBuku.Arr[i][_sumBuku],tempint);
				dec(tempint);
				str(tempint,tempstr);
				TBuku.Arr[i][_sumBuku]:=tempstr;
				new.Arr[0] := username;
				new.Arr[1] := ID_Dipinjam;
				new.Arr[2] := tanggal_dipinjam;
				new.Arr[3] := status;
				addRow(TPinjam,new);
				// writeCSV('file_history_peminjaman.csv', TPinjam);
				writeln('Tersisa ', TBuku.Arr[i][_sumBuku], ' buku ', TBuku.Arr[i][_judulBuku],'.');
				writeln('Terima kasih sudah meminjam.');
				found:=true;
			end else
			begin
				writeln('Buku ', TBuku.Arr[i][_judulBuku], ' sedang habis!');
				writeln('Coba lain kali.');
				found:=true;
			end;
		end else
		begin
			inc(i);
		end;
	end;
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
	// TDestroy(TPinjam);
end;

procedure riwayat(TPinjam: TCSVArr);

var
	i: integer;
	user: string;
begin 
	Clrscr;
	write('Masukkan username pengunjung: ');
	readln(user);
	writeln('Riwayat:');
	// readCSV('file_history_peminjaman.csv', TPinjam);
	//Lowercase(TPinjam.Arr[i][_user]);
	//Lowercase(user);
	for i:=1 to TPinjam.row-1 do
	begin
		if user=TPinjam.Arr[i][_user] then
		begin
			write(TPinjam.Arr[i][_tanggalPinjam]); write(' | ');
			write(TPinjam.Arr[i][_idPinjam]); write(' | ');
			write(TPinjam.Arr[i][_judulBuku]); writeln('');
		end;
	end;
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.