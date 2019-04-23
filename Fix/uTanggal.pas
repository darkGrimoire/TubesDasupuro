unit uTanggal;

interface
type 
	TTanggal = record
								D: integer; //Day
								M: integer; //Month
								Y: integer; //Year
							end;

//cari tahu apa T1<T2
function isTelat(T1, T2: TTanggal) : boolean;
//ngubah string tanggal jadi integer
function nilai(date: char): integer;
//ubah string jadi bentuk tanggal (record)
function readTanggal(aText: string): TTanggal;
//cek tahun kabisat dan outputnya 
function isTahunKabisat(Y: integer): integer;
//nentuin max Hari dalam bulan dan tahun tersebut
function maxH(M,Y: integer): integer;
//nentuin bentukan tanggal valid
function isValidTanggal(Tanggal: TTanggal): boolean;
//nentuin selisih tanggal T2-T1
function selisihTanggal(T1,T2: TTanggal): integer;
//nambahin T1 dengan jumlah Hari yg diminta
function tambahTanggal(T1: TTanggal; Hari: integer): TTanggal;

implementation

function isTelat(T1, T2: TTanggal) : boolean;
{ true jika telat }
{ 1 = dikembalikan, 2 = harusnya balik kapan }
{ ALGORITMA }
begin
	if T1.Y=T2.Y then
	begin
		if T1.M=T2.M then
		begin
			if T1.D<=T2.D then
			begin
				isTelat:= False;
			end else if T1.D>T2.D then
			begin
				isTelat:= True;
			end;
		end else if T1.M<T2.M then
		begin
			isTelat:= False;
		end else if T1.M>T2.M then
		begin
			isTelat:= True;
		end;
	end else if T1.Y<T2.Y then
	begin
		isTelat:= False;
	end else if T1.Y>T2.Y then
	begin
		isTelat:= True;
	end;
end;

function nilai(date: char): integer;
begin
	//ngubah string tanggal jadi integer
	nilai:= ord(date)-48;
end;

function readTanggal(aText: string): TTanggal;
begin
	//Ubah string jadi tanggal dalam bentuk DD/MM/YYYY
	readTanggal.D := 10*nilai(aText[1]) + nilai(aText[2]);
	readTanggal.M := 10*nilai(aText[4]) + nilai(aText[5]);
	readTanggal.Y := 1000*nilai(aText[7]) + 100*nilai(aText[8]) + 10*nilai(aText[9]) + nilai(aText[10]);
end;

function isTahunKabisat(Y: integer): integer;
begin
	if (Y mod 400 = 0) or ((Y mod 4 = 0) and (Y mod 100<>0)) then
		isTahunKabisat:=1
	else
		isTahunKabisat:=0;
end;

function maxH(M,Y: integer): integer;
begin
	//Cek max hari per bulan
	case M of
    1,3,5,7,8,10,12: maxH := 31;
    4,6,9,11       : maxH := 30;
    2              : maxH := 28+isTahunKabisat(Y);
  end;
end;

function isValidTanggal(Tanggal: TTanggal): boolean;
begin
	isValidTanggal := (Tanggal.Y>0) and ((Tanggal.M>0) and (Tanggal.M<=12)) and ((Tanggal.D>0) and (Tanggal.D<=maxH(Tanggal.M,Tanggal.Y)));
end;

function selisihTanggal(T1,T2: TTanggal): integer;
var
	Hari,i: integer;
begin
Hari:=0;
//Hitung total selisih hari antara tahun T1 dengan T2 TAPI HARI T2.D GA MASUK PERHITUNGAN
//Angka ini artinya jumlah hari dari 1 Januari T1.Y hingga 31 Desember T2.Y
for i:=T1.Y to T2.Y do
	Inc(Hari,364+isTahunKabisat(i));
Inc(Hari,T2.Y-T1.Y);
// writeln('1: ',Hari);
//Selisih hari dari 1 Januari T1.Y hingga Tanggal ke T1.D di bulan T1.M
for i:=1 to T1.M-1 do
	Dec(Hari,maxH(i,T1.Y));
Dec(Hari,T1.D-1);
// writeln('2: ',Hari);
//Selisih hari dari Tanggal T2.D di bulan T2.M hingga 31 Desember
for i:=T2.M+1 to 12 do
	Dec(Hari,maxH(i,T2.Y));
Dec(Hari,maxH(T2.M,T2.Y)-T2.D);
// writeln('3: ',Hari);
selisihTanggal:=Hari;
end;

function tambahTanggal(T1: TTanggal; Hari: integer): TTanggal;
var
	T2: TTanggal;
begin
T2:=T1;
//tambahkan hari pada T2.D
Inc(T2.D,Hari);
//Jika harinya kelebihan, kurangi T2.D sesuai dgn max hari pada bulan tersebut dan tambahkan T2.M
while T2.D>maxH(T2.M,T2.Y) do
begin
	Dec(T2.D, maxH(T2.M,T2.Y));
	Inc(T2.M);
	//Jika bulannya kelebihan, kurangi T2.M dan tambahkan T2.Y
	while T2.M>12 do
	begin
		Dec(T2.M, 12);
		Inc(T2.Y);
	end;
end;
tambahTanggal:=T2;
end;

end.