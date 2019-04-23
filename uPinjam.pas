unit uPinjam;

interface
uses pandas,crt,uTanggal;

procedure pinjam_buku(username: string; TBuku: TCSVArr; var TPinjam: TCSVArr);
procedure riwayat(TBuku, TPinjam: TCSVArr);

implementation
procedure pinjam_buku(username: string; TBuku: TCSVArr; var TPinjam: TCSVArr);
var
	i, tempint: integer;
	//ID_dipinjam: integer;
	ID_dipinjam, tanggal_dipinjam,tanggal_batas,tempstr,tempstr2,tempstr3: string;
	new: TRow;
	status: string;
	found: boolean = false;
	T1: TTanggal;

begin
	// readCSV('file_history_peminjaman.csv', TPinjam);
	// TWrite(TPinjam);
	// readCSV('Buku.csv', TBuku);
	// TWrite(TBuku);
	Clrscr;
	write('Masukkan id buku yang ingin dipinjam: ');
	readln(ID_dipinjam);
	if searchCellContain(TBuku,_idBuku,ID_dipinjam)=-1 then
	begin
		writeln('ID Buku Tidak dapat ditemukan!');
		readkey;
	end else
	begin
		write('Masukkan tanggal hari ini: ');
		readln(tanggal_dipinjam);
		T1:=readTanggal(tanggal_dipinjam);
		while (not isValidTanggal(T1)) do
		begin
			writeln('Tanggal tidak valid! mohon ulangi:');
			readln(tanggal_dipinjam);
			T1:=readTanggal(tanggal_dipinjam);
		end;
		T1:=tambahTanggal(T1,7);
		str(T1.D,tempstr);
		str(T1.M,tempstr2);
		str(T1.Y,tempstr3);
		if Length(tempstr)=1 then tempstr:='0'+tempstr;
		if Length(tempstr2)=1 then tempstr2:='0'+tempstr2;
		for i:=Length(tempstr3) to 3 do
			tempstr3:='0'+tempstr3;
		tanggal_batas:=tempstr+'/'+tempstr2+'/'+tempstr3;
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
					new.Arr[3] := tanggal_batas;
					new.Arr[4] := status;
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
end;

procedure riwayat(TBuku, TPinjam: TCSVArr);

var
	i: integer;
	user: string;
	idx: integer;

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
			idx:=searchCellContain(TBuku,_idBuku,TPinjam.Arr[i][_idPinjam]);
			write(TBuku.Arr[idx][_judulBuku]); writeln('');
		end;
	end;
	writeln; writeln('Tekan tombol apapun untuk melanjutkan');
  readkey;
end;

end.