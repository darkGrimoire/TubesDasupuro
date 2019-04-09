Program Example42;

uses pandas;
var
  i: integer;
  str: string;
  TCSV: TCSVArr;
  aRow: TRow;
begin
  readCSV('Laporan_Buku_Hilang.csv',TCSV);
  TWrite(TCSV);
  while true do
  begin
    writeln('Delete Row:');
    readln(i);
    if i>0 then
    begin
      removeRow(TCSV,i);
    end else
    begin
    writeln('Append Mode with row: ',TCSV.Row,' and col: ',TCSV.Col);
    readln(str);
    aRow:=(CSVParser(str));
    addRow(TCSV,aRow);
    end;
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