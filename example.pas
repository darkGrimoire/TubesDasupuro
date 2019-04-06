Program Example38;

uses sysutils, strutils;

Type  
  TCSVArr = record
          Arr : array of array of string;
          Row, Col : integer;
          end;
  TRow = record
          Arr : array of string;
          Col : integer;
          end;

var
  TArr : TCSVArr;
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

procedure TWrite(TArr: TCSVArr);
var
  i, j: Integer;
begin
  for i:=Low(TArr.Arr) to High(Tarr.Arr) do
  begin
    Write('Arr[', i, ']:  ');
    for j:=Low(TArr.Arr[i]) to High(TArr.Arr[i]) do
      Write(TArr.Arr[i][j], '..');
    WriteLn('|');
  end;
end;

// abc
// abc,def
// abc,def,ghi,
// ,abc,,,
// awal: ""(quotation)char(cellbuf),(whitespace)
// tengah: ""(quotation)char(cellbuf),(endcol/whitespace)
// akhir: ""(quotation)/char(cellbuf/eol),(whitespace)

function CSVParser(aText: string): TRow;
const
  Delim = ',';
  Quote = '"';
var
  i,len,col: integer;
  Quotation: boolean = false;
  CellBuffer: string;
begin
  i:=1;
  col:=0;
  CellBuffer:='';
  len:=length(aText);
  while i<=len do
  begin
    SetLength(CSVParser.Arr,col+1);
    if i=1 then
    begin
      if aText[i]=Delim then
      begin
        CSVParser.Arr[col]:=CellBuffer; //CellBuffer still whitespace
        Inc(col); Inc(i);
      end else
      if aText[i]=Quote then
      begin
        Quotation:=true;
        Inc(i);
      end else
      begin
        CellBuffer:=CellBuffer+aText[i];
        Inc(i);
      end;
    end else
    begin
      while Quotation do
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
      if aText[i]=Delim then
      begin
        CSVParser.Arr[col]:=CellBuffer;
        CellBuffer:='';
        Inc(i); Inc(Col);
      end else
      if aText[i]=Quote then
      begin
        Quotation:=true;
        Inc(i);
      end else
      begin
        CellBuffer:=CellBuffer+aText[i];
        Inc(i);
      end;
    end;
  end;
  if aText[len]=Delim then
  begin
    CSVParser.Arr[col]:=CellBuffer;
    CSVParser.Col:=col+1;
  end else
  if aText[len]=Quote then
  begin
    CSVParser.Col:=col;
  end else
  begin
    CSVParser.Arr[col]:=CellBuffer;
    CSVParser.Col:=col+1;
  end;
end;

begin
  TArr.Row:=0;
  TArr.Col:=0;
  readln(txt);
  TArrRow:=CSVParser(txt);
  Inc(TArr.Row); TArr.Col:=TArrRow.Col;
  SetLength(TArr.Arr,TArr.Row,TArr.Col);
  for i:=0 to TArrRow.Col-1 do
    TArr.Arr[TArr.Row-1][i]:=TArrRow.Arr[i];
  TWrite(TArr);
  writeln(TArr.Col,TArr.Row);

  readln(txt);
  TArrRow:=CSVParser(txt);
  Inc(TArr.Row); TArr.Col:=TArrRow.Col;
  SetLength(TArr.Arr,TArr.Row,TArr.Col);
  for i:=0 to TArrRow.Col-1 do
    TArr.Arr[TArr.Row-1][i]:=TArrRow.Arr[i];
  TWrite(TArr);
  writeln(TArr.Col,TArr.Row);
  // TArr[0][0]:=TArrRow[0];
  // TArr[0][1]:=TArrRow[1];
  // TArr[0][2]:=TArrRow[2];
  // TWrite(TArr);
End.