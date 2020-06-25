{* fpc -Co -Cr -Miso -gl principal.pas *}

{
   InCo- Fing
   Laboratorio 2020 Primer Semestre

   Programa Principal
}

program Principal;

(****************************************)
(* Definicion de tipos dados en la letra *)
(****************************************)
{$INCLUDE estructuras.pas}


(****************************************)
(* Funciones y Procedimientos  *)
(****************************************)

{ aquí­ se incluye el archivo entregado por el estudiante}
{$INCLUDE tarea.pas}



procedure imprimirResultado(res: Resultado);
begin
  case res.quepaso of
    Fallo: writeln('Fallo');
    Creado: writeln('Creado: ');
    Agregado: writeln('Agregado en posición ', res.posicion:1);
  end;
end;

procedure imprimirSecuencia(sec: Secuencia);
var
  i: 0..MAX;
begin
  write('tope: ', sec.tope:1, '; Valores: ');
  for i := 1 to sec.tope do 
    write(sec.valores[i]:1, ' ');
  writeln(); 
end;


const 
  CANTSEC = 3;

type 
  rangoSecs = 1..CANTSEC;


(****************************************)
(* Variables del Programa *)
(****************************************)
var
  opcion : char;
  
  res: Resultado;

  secs : array [rangoSecs] of Secuencia; 

  idSec1, idSec2, idSec: rangoSecs;

  col: Coleccion;

  valor: Natural;

  pos, pos1, pos2: Natural;


(****************************************)
(* Programa Principal *)
(****************************************)

begin

  repeat
    read(opcion);
     
    case opcion of
      's': begin {CrearSecuencia}
             read(idSec);
             CrearSecuencia(secs[idSec]);
             writeln('Se creó la secuencia')
           end;
           
      'v': begin {AgregarValor}
             read(idSec, valor);
             AgregarValor(secs[idSec], valor, res);
             imprimirResultado(res)
           end;
           
      'i': begin {SecuenciasIguales}
             read(idSec1, idSec2);
             if SecuenciasIguales(secs[idSec1], secs[idSec2]) then
               writeln('Son iguales')
             else 
               writeln('NO son iguales')
           end;    
           
      'f': begin {FusionarSecuencias}
             read(idSec1, idSec2, idSec);
             FusionarSecuencias(secs[idSec1], secs[idSec2], secs[idSec], res);
             imprimirResultado(res);
             if (res.quepaso = Creado) then
               imprimirSecuencia(secs[idSec])
           end;

      'c': begin {CrearColeccion}
             CrearColeccion(col);
             writeln('Se creó la colección')  
           end;

      'a': begin {AgregarSecuencia}
             read(idSec);
             AgregarSecuencia(col, secs[idSec], pos);
             writeln('Se agregó la secuencia ', idSec:1, ' en la posición ', pos:1);
           end;

      't': begin {TodasIguales}
             if TodasIguales(col) then
               writeln('Todas son iguales')
             else 
               writeln('NO todas son iguales')
           end;

      'e': begin {FusionarEnColeccion}
             read(pos1, pos2);
             FusionarEnColeccion(col, pos1, pos2, res);
             imprimirResultado(res)
           end;

      'x': begin {ImprimirColeccion}
            ImprimirColeccionTest(col)
           end;

      'y': begin {ImprimirColeccion}
            read(idSec);
            ImprimirSecuenciaTest(secs[idSec])
           end;


    end
      
  until opcion = 'q';	
   
end.
