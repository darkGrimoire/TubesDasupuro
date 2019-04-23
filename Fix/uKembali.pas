unit uKembali;

interface
uses pandas,crt,uTanggal;

{ Modul Utama }
Procedure kembalikan_buku(var TKembali: TCSVArr; var TPinjam: TCSVArr; var TBuku: TCSVArr);

implementation

Procedure kembalikan_buku(var TKembali: TCSVArr; var TPinjam: TCSVArr; var TBuku: TCSVArr);
var
	// i: integer;
	ID_Kembali, user: string;
	Tanggal_Batas, tanggaltoday: string;
	TAmbil,TBatas: TTanggal;
	i,idxB,idxP,tempint,denda: integer;
	found: boolean = false;
	tempstr: string;
	new: TRow;

begin
	// readCSV('file_history_pengembalian.csv', TKembali);
	// TWrite(TKembali);
	
	// readCSV('file_history_peminjaman.csv', TPinjam);
	// TWrite(TPinjam);
	Clrscr;
	write('Masukkan id buku yang dikembalikan: ');
	readln(ID_kembali);
	writeln('Data peminjaman:');
	write('Username: ');
	readln(user);
	i:=0;
	while (i<TPinjam.Row) and (not found) do
	begin
		if (TPinjam.Arr[i][_idPinjam]=ID_kembali) and (TPinjam.Arr[i][_status]='belum') and (TPinjam.Arr[i][_user]=user) then
		begin
			idxP:=i;
			found:=true;
		end else
		begin
			inc(i);
		end;
	end;
	if (not found) then
	begin
		writeln('ID/username peminjaman tak dapat ditemukan!');
		readkey;
	end else
	begin
		idxB:=searchCellContain(TBuku,_idBuku,ID_kembali);
		writeln('Judul buku: ',TBuku.Arr[idxB][_judulBuku]);
		writeln('Tanggal peminjaman: ', TPinjam.Arr[idxP][_tanggalPinjam]);
		writeln('Tanggal batas peminjaman: ', TPinjam.Arr[idxP][_tanggalBatas]);
		Tanggal_Batas:=TPinjam.Arr[idxP][_tanggalBatas];
		writeln(' ');
		write('Masukkan tanggal hari ini: ');
		readln(tanggaltoday);
		TAmbil:=readTanggal(tanggaltoday);
		while (not isValidTanggal(TAmbil)) do
		begin
			writeln('Tanggal tidak valid! mohon ulangi:');
			readln(tanggaltoday);
			TAmbil:=readTanggal(tanggaltoday);
		end;

		{ CONV TANGGAL }
		TBatas:=readTanggal(Tanggal_Batas);
		
		{ MASUKIN KE FILE }
		SetLength(new.Arr,3);
		new.Arr[0] := user;
		new.Arr[1] := ID_Kembali;
		new.Arr[2] := tanggaltoday;
		addRow(TKembali,new);
		// writeCSV('file_history_pengembalian.csv', TKembali);

		{ PERBAIKI STATUS }
		TPinjam.Arr[idxP][_status]:='sudah';

		{ TAMBAHKAN BUKU YANG SUDAH DIKEMBALIKAN }
		val(TBuku.Arr[idxB][_sumBuku],tempint);
		inc(tempint);
		str(tempint,tempstr);
		TBuku.Arr[idxB][_sumBuku]:=tempstr;
		{ CEK TANGGAL }
		if isTelat(TAmbil,TBatas) then
		begin
			denda:=2000*selisihTanggal(TBatas,TAmbil);
			writeln('Anda terlambat mengembalikan buku.');
			writeln('Anda terkena denda Rp',denda);
		end else
		begin
			writeln('Terima kasih sudah meminjam.');
		end;
		writeln; writeln('Tekan tombol apapun untuk melanjutkan');
	  readkey;
		// TDestroy(TKembali);
		
	end;
end;

end.
