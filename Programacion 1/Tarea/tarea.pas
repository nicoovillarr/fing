PROCEDURE ImprimirSecuenciaTest(sec: Secuencia);
var
  i: 0..MAX;
begin
  write('tope: ', sec.tope:1, '; Valores: ');
  for i := 1 to sec.tope do 
    write(sec.valores[i]:1, ' ');
  writeln(); 
end;

PROCEDURE ImprimirColeccionTest(col: Coleccion);
var p : Coleccion;
    sec : Secuencia;
    i : integer;
begin
    p := col;
    i := 1;
    while (p <> nil) do
    begin
        sec := p^.sec;
        writeln('Secuencia: ', i);
        ImprimirSecuenciaTest(sec);
        i := i + 1;

        p := p^.sig;
    end;
end;

PROCEDURE CrearSecuencia (VAR sec : Secuencia);
var secVacia : Secuencia;
begin
    secVacia.tope := 0;
    sec := secVacia;
end;

PROCEDURE AgregarValor (VAR sec : Secuencia; valor : Natural; VAR res: Resultado);
var i, n : integer;
begin
    if sec.tope < MAX then 
    begin
        i := 1;
        while (i <= sec.tope) and (sec.valores[i] < valor) do i := i + 1;

        if (sec.valores[i] = valor) then
        begin
            res.quePaso := Fallo;
        end
        else
        begin
            sec.tope := sec.tope + 1;

            for n := sec.tope downto i do 
                if (n - 1 > 0) then sec.valores[n] := sec.valores[n - 1];

            sec.valores[i] := valor;

            res.quePaso := Agregado;
            res.posicion := i;
        end;
    end
    else
    begin
        res.quePaso := Fallo;
    end;
end;

FUNCTION SecuenciasIguales (sec1, sec2 : Secuencia) : boolean;
var i : integer;
    diff : boolean;
begin
    diff := false;

    if (sec1.tope <> sec2.tope) then diff := true;
    
    i:=1;
    while (i <= sec1.tope) and (diff = false) do
    begin
        if(sec1.valores[i] = sec2.valores[i]) then i := i + 1 else diff := true;
    end;

    SecuenciasIguales := not diff;
end;

PROCEDURE FusionarSecuencias (sec1, sec2 : Secuencia; VAR sec3 : Secuencia; VAR res: resultado);
var i : integer;
    resInterno: Resultado;
begin
    sec3 := sec1;

    resInterno.quePaso := Creado;
    i := 1;
    while (i <= sec2.tope) and (resInterno.quePaso <> Fallo) do
    begin
        AgregarValor(sec3, sec2.valores[i], resInterno);
        i := i + 1;
    end;

    if (i < sec2.tope) or (resInterno.quePaso = Fallo) then res.quePaso := Fallo else res.quePaso := Creado;
end;

PROCEDURE CrearColeccion (VAR col : Coleccion);
begin
    new(col);
end;

PROCEDURE AgregarSecuencia (VAR col : Coleccion; sec : Secuencia; VAR pos : Natural);
var newCol, aux :  Coleccion;
begin
    pos := 1;

    new(newCol);
    newCol^.sec := sec;
    newCol^.sig := nil;

    if col^.sec.tope = 0 then
    begin
        col := newCol;
    end
    else
    begin
        aux := col;
        if (aux^.sig <> nil) then
        begin
            while aux^.sig <> nil do
            begin
                pos := pos + 1;
                aux:= aux^.sig;
            end;

            pos := pos + 1;
            aux^.sig := newCol;
        end
        else
        begin
            pos := pos + 1;
            aux^.sig := newCol;
        end;
    end;
end;

FUNCTION todasIguales (col : Coleccion) : boolean;
var p : Coleccion;
    elem : Secuencia;
begin
    p := col;
    elem := col^.sec;
    while (p <> nil) and (SecuenciasIguales(p^.sec, elem)) do
        p:= p^.sig;
    
    todasIguales := (p = nil);
end;

FUNCTION BuscarSecuencia (col : Coleccion; pos : Natural) : Secuencia;
var i : Natural;
    found : boolean;
    vacia : Secuencia;
begin
    i := 1;
    found := false;

    while (col <> nil) and (found = false) do
    begin
        if (i = pos) then
        begin
            found := true;
        end
        else
        begin
            col := col^.sig;
            i := i + 1;
        end;
    end;

    CrearSecuencia(vacia);

    if (found) then BuscarSecuencia := col^.sec else BuscarSecuencia := vacia;
end;

PROCEDURE FusionarEnColeccion (VAR col : Coleccion; pos1, pos2 : Natural; VAR res : Resultado);
var first, second, final : Secuencia;
    pos : Natural;
begin
    first := BuscarSecuencia(col, pos1);
    second := BuscarSecuencia(col, pos2);
    
    res.quePaso := Fallo;
    if (first.tope > 0) and (second.tope > 0) then
    begin
        res.quePaso := Creado;
        FusionarSecuencias(first, second, final, res);
        if (res.quePaso = Creado) then
        begin
            pos := 0;
            AgregarSecuencia(col, final, pos);

            res.quePaso := Agregado;
            res.posicion := pos;
        end;
    end;
end;