PROGRAM Ejercicio;
const N = 19;
type TipoFrase = array [1..N] of char;
var
   frase : TipoFrase;

function espacios (cant: Integer; fra: TipoFrase) : boolean;
var i,j : Integer;
begin
  j := 0;
  for i := 1 to N do
    if (fra[i] = ' ') then j := j + 1;

  if j >= cant 
  then espacios := true
  else espacios := false;
end;

begin
   frase := ('hay una hora de sol');
   writeln(espacios(-3, frase));
end. 