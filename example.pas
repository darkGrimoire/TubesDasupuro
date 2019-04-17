Program Example42;

uses pandas, crt;
var
  line: string;
  key: char;
  specialChar: boolean = false;

begin
line:='';
ClrScr();
key:=readkey;
while ord(key)<>13 do
begin
  if ord(key)=8 then
  begin
    write(key);
    write(' ');
    write(key);
    delete(line,Length(line),1);
  end else
  if ord(key)=0 then
  begin
    specialChar:=true;
  end else
  if (ord(key)>31) and (ord(key)<126) then
  begin
    if not specialChar then
    begin
      write('*');
      line:= line + key
    end else
    begin
      specialChar:=false;
    end;
  end;
  key:=readkey;
end;
writeln;
writeln(line);
end.

// var
//   TCSV: TCSVArr;
//   i: integer;
//   str: string;
//   aRow: TRow;
// begin
//   readCSV('Buku.csv',TCSV);
//   sortCSV(TCSV,1);
//   TWrite(TCSV);
//   while true do
//   begin
//     // writeln(compareString(TCSV.Arr[TCSV.Row-1][1],TCSV.Arr[TCSV.Row-2][1]));
//     writeln('Delete Row:');
//     readln(i);
//     if i>0 then
//     begin
//       removeRow(TCSV,i);
//     end else
//     begin
//       writeln('Append Mode with row: ',TCSV.Row,' and col: ',TCSV.Col);
//       readln(str);
//       aRow:=(CSVParser(str));
//       addRow(TCSV,aRow);
//     end;
//     TWrite(TCSV);
//   end;
  
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