Program mainFaris;

type
  arrRow = Array of string;
  arrCol = Array of arrRow;
var
  txt: string;
  csvText: StringArray;

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

function csvStringParser(aText: string): StringArray;

begin
  while true do
  begin
    readln(txt);
    writeln(Crypt(txt));
  end;
End.