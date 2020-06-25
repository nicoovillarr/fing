const
  MAX = 10;

type
  Natural = 0..MAXINT; 

  Secuencia = RECORD
    valores : ARRAY [1..MAX] OF Natural;
    tope : 0..MAX;
  END;


  Coleccion = ^Celda;
  Celda = RECORD
    sec : Secuencia;
    sig : Coleccion;
  END;

  TipoResultado = (Fallo, Creado, Agregado);
  Resultado = RECORD
    CASE quePaso : TipoResultado OF
    Fallo: ();
    Creado: ();
    Agregado: (posicion: Natural);
  END;

