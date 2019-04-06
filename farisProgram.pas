Program mainFaris;

uses Sysutils;

Type  
  TRow = record
          Arr : array of string;
          Col : integer;
          end;
  TCSVArr = record
          Arr : array of array of string;
          Row, Col : integer;
          end;

var
  TArr : TCSVArr; //format 2Dnya: [row,col]
  TArrRow: TRow;
  txt: string;
  i: integer;

function Crypt(aText: string): string;
const
  PWD = 'hM!7JG$YeP9W~Smr*NK3&L2@cdy?Vx+M';
var
  i,j,len: integer;
begin
  len := Length(aText);
  SetLength(Crypt, len);
  j:=1;
  for i := 1 to len do
  begin
    Crypt[i] := Chr(Ord(aText[i]) + Ord(PWD[j]));
    Inc(j);
    if j>Length(PWD) then j:=1;
  end;
end;

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

// abc
// abc,def
// abc,def,ghi,
// ,abc,,,
// awal: ""(quotation)char(cellbuf),(whitespace)
// tengah: ""(quotation)char(cellbuf),(endcol/whitespace)
// akhir: ""(quotation)/char(cellbuf/eol),(whitespace)

//Parse String menjadi bentuk TRow
function CSVParser(aText: string): TRow;
//Deklarasi delimiter dan quote char
const
  Delim = ',';
  Quote = '"';
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
    if i=1 then //cek karakter pertama di string aText
    begin
      if aText[i]=Delim then //Kalau langsung ketemu delimiter artinya kolom pertamanya baris kosong
      begin
        CSVParser.Arr[col]:=CellBuffer; //CellBuffer still ''
        Inc(col); Inc(i); //Setiap pemasukan ke result CSVParser.Arr, tambahkan kolom yang ingin diproses
      end else
      if aText[i]=Quote then //Kalau langsung ketemu quote, switch flag quotation
      begin
        Quotation:=true;
        Inc(i);
      end else
      begin
        CellBuffer:=CellBuffer+aText[i]; //Kalau langsung ketemu karakter biasa
        Inc(i);
      end;
    end else
    begin
      while Quotation do //Prosedur quotation, hanya berhenti ketika menemui quote berikutnya dan mengabaikan tanda delimiter
      begin
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
begin
  Inc(TCSV.Row); //Tambahkan Rownya TCSV
  if TCSV.Col=0 then TCSV.Col:=aRow.Col; //Kalau TCSV belum punya Col, assign Col sesuai dgn Col aRow
  SetLength(TCSV.Arr,TCSV.Row,TCSV.Col); //SetLength Array sesuai dgn yg sudah ditentukan Row dan Colnya tadi
  for i:=0 to TCSV.Col-1 do
    TCSV.Arr[TCSV.Row-1][i]:=aRow.Arr[i]; //Isi Row terbawah TCSV dgn aRow
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
const
  Delim = ',';
  Quote = '"';
var
  col: integer;
  cell: string;
begin
  CSVBuilder:='';
  for col:=0 to aRow.Col-2 do
  begin
    // writeln(aRow.Arr[row][col]);
    if Pos(Delim,aRow.Arr[row][col])<>0 then
    begin
    // writeln(Pos(Delim,aRow.Arr[row][col]));
      CSVBuilder:= CSVBuilder + Quote + aRow.Arr[row][col] + Quote + Delim;
    end else
    begin
      CSVBuilder:= CSVBuilder + aRow.Arr[row][col] + Delim;
    end;
  end;
  CSVBuilder:= CSVBuilder + aRow.Arr[row][aRow.Col-1];
end;

procedure writeCSV(const Filename: string; TCSV: TCSVArr);
var
  i,j: integer;
  aRow: TRow;
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

begin
  readCSV('Buku.csv',TArr);
  TWrite(TArr);
  while true do
  begin
    readln(i);
    writeln(CSVBuilder(TArr,i));
  end;
  // //input
  // readln(txt);
  // while txt<>-999 do
  // begin
  //   //parse
  //   TArrRow:=CSVParser(txt);
  //   //append row
  //   addRow(TArr,TArrRow);
  //   //print table
  //   TWrite(TArr);
  //   //Tuliskan Col dan Row TCSV yang baru
  //   writeln('Col: ',TArr.Col,' and Row: ',TArr.Row);
  //   //input
  //   readln(txt);
  // end;

  // TArr[0][0]:=TArrRow[0];
  // TArr[0][1]:=TArrRow[1];
  // TArr[0][2]:=TArrRow[2];
  // TWrite(TArr);
End.