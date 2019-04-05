Program Example38;

{ This program demonstrates the FileExists function }
var
  txt: string;
  tfOut: TextFile;

function Crypt(aText: string): string;
const
  PWD = '2u3r9upvjwq892kduw3ytnbjlxdhbaq3';
var
  i, len: integer;
begin
  len := Length(aText);
  if len > Length(PWD) then
    len := Length(PWD);
  SetLength(Crypt, len);
  for i := 1 to len do
    Crypt[i] := Chr(Ord(aText[i]) xor Ord(PWD[i]));
end;

begin
  d := tcsvdocument.create();
  d.loadfromfile('user.csv');
  for y:=0 to d.rowcount-1 do begin
    for x:=0 to d.maxcolcount-1 do begin
      d.cells[x,y]:=Crypt(d.cells[x,y]);
    end;
  end;
  d.savetofile('userDecrypted.csv')
End.