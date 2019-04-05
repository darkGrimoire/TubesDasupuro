Program Example38;

Type  
  TCSVArr = array of array of string;
  TRow = array of string;

var
  TArr : TCSVArr;
  TArrRow: TRow;
  txt: string;

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

procedure TWrite(Arr: TCSVArr);
var
  i, j: Integer;
begin
  for i:=Low(Arr) to High(Arr) do
  begin
    Write('Arr[', i, ']:  ');
    for j:=Low(Arr[i]) to High(Arr[i]) do
      Write(Arr[i][j], '..');
    WriteLn('|');
  end;
end;
// "abc,d",ef,"g,hi",jk 1 7
// ,ef,"g,hi",jk
// "g,hi",jk
// ,jk
function CSVParser(aText: string): TRow;
const
  Delimiter = ',';
  Quote = '"';
var
  nD,nQ,nextD,nextQ,i: integer;
begin
  i:=0;
  while (length(aText)>0) do
  begin
    SetLength(CSVParser,i+1);
    nD:=Pos(Quote,aText);
    nQ:=Pos(Delimiter,aText);
    // WriteLn('i: ',i,'nD: ',nD,'nQ: ',nQ);
    if (nQ=0) and (nD=0) then
    begin
      CSVParser[i]:=aText;
      aText:='';
    end else
    if (nQ<>0) and (nQ<nD) then
    begin
      nextQ:=Pos(Quote,copy(aText,nQ+1,Length(aText)))+1;
      CSVParser[i]:=copy(aText,nQ+1,nextQ-1);
      aText:=copy(aText,nextQ+1,Length(aText));
      Inc(i);
    end else
    begin
      nextD:=Pos(Delimiter,copy(aText,nD+1,Length(aText)))+1;
      if nextD=nD then
      begin
        CSVParser[i]:=copy(aText,nD+1,Length(aText));
        aText:='';
      end else
      begin
        CSVParser[i]:=copy(aText,nD+1,nextD-1);
        aText:=copy(aText,nextD+1,Length(aText));
        Inc(i);
      end;
    end;
  end;
end;

begin
  readln(txt);
  TArrRow:=CSVParser(txt);
  SetLength(TArr,1,3);
  TArr[0][0]:=TArrRow[0];
  TArr[0][1]:=TArrRow[1];
  TArr[0][2]:=TArrRow[2];
  TWrite(TArr);
End.