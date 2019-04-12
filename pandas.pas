unit pandas;

interface
Type  
  TRow = record
          Arr : array of string;
          Col : integer;
          end;
  TCSVArr = record
          Arr : array of array of string;
          Row, Col : integer;
          end;
const
  Delim =',';
  Quote ='"';

//Write Table of TCSV for debugging
procedure TWrite(TCSV: TCSVArr);
//CompareText buatan sendiri gara2 gabole makek sysutils
function compareString(T1,T2: string): integer;
//Sort TCSV with col as the pivot
procedure sortCSV(var TCSV: TCSVArr; col: integer);
//Parse string in csv format into TRow format
function CSVParser(aText: string): TRow;
//Append a row into the bottom-most TCSV
procedure addRow(var TCSV: TCSVArr; aRow: TRow);
//Remove specified row index
procedure removeRow(var TCSV: TCSVArr; row: integer);
//Escapes '"' in text
function escapeQuote(aText: string): string;
//Read CSV File into TCSV
procedure readCSV(const Filename: string; var TCSV: TCSVArr);
//Convert a row from TCSV into string with csv format
function CSVBuilder(aRow: TCSVArr; row: integer): string;
//Overwrite TCSV to a CSV File
procedure writeCSV(const Filename: string; TCSV: TCSVArr);
procedure TDestroy(var TCSV: TCSVArr);

implementation
// Tulis tabel tipe TCSVArr
procedure TWrite(TCSV: TCSVArr);
var
  i, j: Integer;
begin
  for i:=Low(TCSV.Arr) to High(TCSV.Arr) do //for loop buat rownya
  begin
    Write('Arr[', i, ']:  ');
    for j:=Low(TCSV.Arr[i]) to High(TCSV.Arr[i]) do
      Write(TCSV.Arr[i][j], '..'); //tabel dipisahkan dengan ..
    WriteLn('|'); //batas akhir satu row
  end;
end;

function compareString(T1,T2: string): integer;
var
  i,len: integer;
begin
  i:=1;
  if Length(T2)<=Length(T1) then
    len:= Length(T2)
  else
    len:= Length(T1);
  Lowercase(T1);
  Lowercase(T2);
  while (Ord(T1[i])=Ord(T2[i])) and (i<=len) do
    Inc(i);
  if (i=len) and (i<>1) then
  begin
    if Length(T1)>Length(T2) then
      compareString:=1
    else if Length(T2)>Length(T1) then
      compareString:=-1
    else
      compareString:=0;
  end else
  if (Ord(T1[i])>Ord(T2[i])) then
    compareString:=1
  else
    compareString:=-1;
end;

procedure sortCSV(var TCSV: TCSVArr; col: integer);
var
  i,pass: integer;
  tempRow: TRow;
  unsorted: boolean;
begin
  SetLength(tempRow.Arr,TCSV.Col);
  pass:=1; unsorted:= true;
  while (pass<=TCSV.Row-1) and unsorted do
  begin
    unsorted:=false;
    for i:=TCSV.Row-1 downto pass+1 do
      if compareString(TCSV.Arr[i][col],TCSV.Arr[i-1][col])=-1 then
      begin
        tempRow.Arr := TCSV.Arr[i];
        TCSV.Arr[i] := TCSV.Arr[i-1];
        TCSV.Arr[i-1] := tempRow.Arr;
        unsorted := true;
      end;
    inc(pass);
  end;
end;

//Parse String menjadi bentuk TRow
function CSVParser(aText: string): TRow;
//Deklarasi delimiter dan quote char
var
  i,len,col: integer;
  Quotation: boolean = false;
  CellBuffer: string;
begin
  //Inisialisasi
  i:=1;
  col:=0;
  CellBuffer:='';
  len:=length(aText);
  while i<=len do
  begin
    //Ubah Ukuran Arraynya setiap pengulangan while
    SetLength(CSVParser.Arr,col+1);
    while Quotation do //Prosedur quotation, hanya berhenti ketika menemui quote berikutnya dan mengabaikan tanda delimiter
    begin
      if (aText[i]=Quote) and (aText[i+1]=Quote) then
      begin
        CellBuffer:=CellBuffer+'"';
        Inc(i,2);
      end else
      if aText[i]=Quote then
      begin
        CSVParser.Arr[col]:=CellBuffer;
        CellBuffer:='';
        Quotation:=false;
        Inc(i,2); Inc(Col); //after end quotation always followed by delim
      end else
      begin
        CellBuffer:=CellBuffer+aText[i];
        Inc(i);
      end;
    end;
    if aText[i]=Delim then //Pas di tengah2 ketemu delim. CellBuffer sudah pasti mengandung isi cell satu kolom.
    begin
      CSVParser.Arr[col]:=CellBuffer; //Assign CellBuffer
      CellBuffer:=''; //Reset CellBuffer
      Inc(i); Inc(Col);
    end else
    if aText[i]=Quote then //Pas di tengah2 ketemu quote
    begin
      Quotation:=true;
      Inc(i);
    end else
    begin
      CellBuffer:=CellBuffer+aText[i]; //Pas di tengah2 ketemu karakter biasa, masukkan ke cellBuffer
      Inc(i);
    end;
  end;
  //Cek karakter terakhir aText apa. Trus, assign jumlah kolomnya ke CSVParser.Col
  if aText[len]=Delim then //Kalau delim, brrti setelahnya ada kolom cell kosong.
  begin
    CSVParser.Arr[col]:=CellBuffer;
    CSVParser.Col:=col+1;
  end else
  if aText[len]=Quote then //Kalau quote, brrti sudah pasti diselesaikan sama prosedur quotationnya tinggal assign Col.
  begin
    CSVParser.Col:=col;
  end else
  begin
    CSVParser.Arr[col]:=CellBuffer; //Kalau karakter biasa, pasti masih ada sisa CellBuffer kolom terakhir. Assign kolom cell itu trus assign Col.
    CSVParser.Col:=col+1;
  end;
end;

//Prosedur penambahan Row (AppendRow) pada TCSV (Table CSV)
procedure addRow(var TCSV: TCSVArr; aRow: TRow);
var
  i: integer;
begin
  Inc(TCSV.Row); //Tambahkan Rownya TCSV
  if TCSV.Col=0 then TCSV.Col:=aRow.Col; //Kalau TCSV belum punya Col, assign Col sesuai dgn Col aRow
  SetLength(TCSV.Arr,TCSV.Row,TCSV.Col); //SetLength Array sesuai dgn yg sudah ditentukan Row dan Colnya tadi
  for i:=0 to TCSV.Col-1 do
    TCSV.Arr[TCSV.Row-1][i]:=aRow.Arr[i]; //Isi Row terbawah TCSV dgn aRow
end;

//Prosedur penghapusan row pada index tertentu
procedure removeRow(var TCSV: TCSVArr; row: integer);
var
  i: integer;
begin
  for i:=row+1 to TCSV.Row-1 do
    TCSV.Arr[i-1] := TCSV.Arr[i];
  Dec(TCSV.Row);
  SetLength(TCSV.Arr,TCSV.Row,TCSV.Col);
end;

//Escape karakter '"' menjadi \" jika ketemu di user input
function escapeQuote(aText: string): string;
var
  i,len: integer;
begin
  escapeQuote:='';
  len:=Length(aText);
  for i:=1 to len do
  begin
    if (aText[i]='"') then
    begin
      escapeQuote := escapeQuote + '"' + aText[i];
    end else
    begin
      escapeQuote := escapeQuote + aText[i];
    end;
  end;
end;

procedure readCSV(const Filename: string; var TCSV: TCSVArr);
var
  tfIn: TextFile;
  line: string;
  row: TRow;

begin
  TCSV.Row:=0;
  TCSV.Col:=0;
  Assign(tfIn, Filename);
  reset(tfIn);
  while not eof(tfIn) do
  begin
    readln(tfIn, line);
    row:=CSVParser(line);
    addRow(TCSV,row);
  end;
  Close(tfIn);
end;

function CSVBuilder(aRow: TCSVArr; row: integer): string;
var
  col: integer;
begin
  CSVBuilder:='';
  for col:=0 to aRow.Col-2 do
  begin
    if Pos(Quote,aRow.Arr[row][col])<>0 then //escape quotes
      aRow.Arr[row][col]:= escapeQuote(aRow.Arr[row][col]);
    // writeln(aRow.Arr[row][col]);
    if (Pos(Delim,aRow.Arr[row][col])<>0) or (Pos(Quote,aRow.Arr[row][col])<>0) then
    begin
    // writeln(Pos(Delim,aRow.Arr[row][col]));
      CSVBuilder:= CSVBuilder + Quote + aRow.Arr[row][col] + Quote + Delim;
    end else
    begin
      CSVBuilder:= CSVBuilder + aRow.Arr[row][col] + Delim;
    end;
  end;
  if Pos(Quote,aRow.Arr[row][aRow.Col-1])<>0 then //escape quotes
      aRow.Arr[row][aRow.Col-1]:= escapeQuote(aRow.Arr[row][aRow.Col-1]);
  if Pos(Delim,aRow.Arr[row][aRow.Col-1])<>0 then
  begin
    CSVBuilder:= CSVBuilder + Quote + aRow.Arr[row][aRow.Col-1] + Quote;
  end else
  begin
    CSVBuilder:= CSVBuilder + aRow.Arr[row][aRow.Col-1];
  end;
end;

procedure writeCSV(const Filename: string; TCSV: TCSVArr);
var
  i: integer;
  csv: string;
  tfOut: TextFile;
begin
Assign(tfOut,Filename);
Rewrite(tfOut);
for i:=Low(TCSV.Arr) to High(TCSV.Arr) do //for loop buat rownya
  begin
  csv:=CSVBuilder(TCSV,i);
  writeln(tfOut, csv);
  end;
Close(tfOut);
end;

procedure TDestroy(var TCSV: TCSVArr);
begin
  TCSV.Row:=0;
  TCSV.Col:=0;
  SetLength(TCSV.Arr,0,0);
end;

end.