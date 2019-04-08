Program Example42;

uses pandas;
var
  i: integer;
  TCSV: TCSVArr;
begin
  readCSV('Buku.csv',TCSV);
  TWrite(TCSV);
  while true do
  begin
    readln(i);
    removeRow(TCSV,i);
    TWrite(TCSV);
  end;
  // //input
  // readln(txt);
  // while txt<>-999 do
  // begin
  //   //parse
  //   TCSVRow:=CSVParser(txt);
  //   //append row
  //   addRow(TCSV,TCSVRow);
  //   //print table
  //   TWrite(TCSV);
  //   //Tuliskan Col dan Row TCSV yang baru
  //   writeln('Col: ',TCSV.Col,' and Row: ',TCSV.Row);
  //   //input
  //   readln(txt);
  // end;

  // TCSV[0][0]:=TCSVRow[0];
  // TCSV[0][1]:=TCSVRow[1];
  // TCSV[0][2]:=TCSVRow[2];
  // TWrite(TCSV);
End.