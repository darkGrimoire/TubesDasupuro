Program Example38;

{ This program demonstrates the FileExists function }

Uses sysutils, csvdocument;

var d: TCSVdocument; COL, ROW: integer;

Begin
	d := TCSVdocument.Create();
  d.LoadFromFile('User.csv');
  
End.