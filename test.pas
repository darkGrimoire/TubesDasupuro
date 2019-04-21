Program test;

uses pandas, uUser,crt;
var 
  a: string;
  TUser: TCSVArr;

begin

readCSV('Buku.csv',TUser);
TWrite(TUser);
readkey;
sortCSV(TUser,1);
TWrite(TUser);
readkey;
end.