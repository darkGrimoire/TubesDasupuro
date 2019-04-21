Program test;

uses uUser;
var a: string;

begin
while true do
begin
  readln(a);
  writeln(Crypt(a));
  writeln(Decrypt(a));
end;
end.