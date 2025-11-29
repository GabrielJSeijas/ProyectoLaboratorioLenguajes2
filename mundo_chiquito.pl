% mundo_chiquito.pl
% Implementación del problema "Mundo Chiquito" en Prolog.

:- dynamic mostro/4.

% Predicado principal: ternaMundoChiquito/3
% Uso: ternaMundoChiquito (NombreA, NombreB, NombreC)
% Base de hechos: mostro(Nombre, Nivel, Atributo, Poder).
% Datos iniciales.
mostro(mostroUno, 5, luz, 2100).
mostro(mostroDos, 7, luz, 2400).
mostro(mostroTres, 7, viento, 2500).

% Predicado auxiliar: igual/2
% Uso: igual(X, Y).
% Implementa la unificación directa: verdadero si X y Y pueden unificarse.
igual(X, Y) :- X = Y.

% Predicado auxiliar: diferente/2
% Uso: diferente(X, Y).
% Implementa negación por falla: verdadero si X y Y NO unifican.
diferente(X, Y) :- \+ (X = Y).

% comparte_una_caracteristica/6
% Uso: comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB).
% Comprueba que exactamente UNA de las tres propiedades coincida entre dos monstruos.
comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    % Caso: mismo nivel, distinto poder y distinto atributo
    igual(NivelA, NivelB),
    diferente(PoderA, PoderB),
    diferente(AtribA, AtribB).

comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    % Caso: mismo poder, distinto nivel y distinto atributo
    diferente(NivelA, NivelB),
    igual(PoderA, PoderB),
    diferente(AtribA, AtribB).

comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    % Caso: mismo atributo, distinto nivel y distinto poder
    diferente(NivelA, NivelB),
    diferente(PoderA, PoderB),
    igual(AtribA, AtribB).

% ternaMundoChiquito/3
% Uso: ternaMundoChiquito(NombreA, NombreB, NombreC).
% Busca una secuencia A -> B -> C tal que:
% - A y B comparten exactamente una característica,
% - B y C comparten exactamente una característica.
% Cada solución encontrada puede ser retornada por backtracking.
ternaMundoChiquito(NombreA, NombreB, NombreC) :-
    % Recupera los atributos de cada monstruo desde la base de hechos.
    mostro(NombreA, NivelA, AtribA, PoderA),
    mostro(NombreB, NivelB, AtribB, PoderB),
    mostro(NombreC, NivelC, AtribC, PoderC),

    % Validaciones de vínculo: A-B y B-C deben compartir exactamente una característica.
    comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB),
    comparte_una_caracteristica(NivelB, PoderB, AtribB, NivelC, PoderC, AtribC).

% mundoChiquito/0
% Imprime todas las ternas encontradas en la base de conocimiento.
% Uso típico: ejecutar mundoChiquito. El predicado itera con forall/2.
mundoChiquito :-
    writeln('--------- Ternas Mundo Chiquito Encontradaas: ---------'),
    forall(
        ternaMundoChiquito(A, B, C),
        format('~w ~w ~w~n', [A, B, C])
    ),
    writeln('                                      ').

% agregarMostro/0
% Interfaz simple para añadir un nuevo hecho mostro/4 solicitando los campos paso a paso.
% Recomendación de entrada: cada lectura por read/1 debe terminar en punto.
agregarMostro :-
    writeln(' Agregar Monstruo (Paso a Paso) '),
    write('1. Ingresa el Nombre del monstruo (ej: mostro4): '),
    read(Nombre),
    write('2. Ingresa el Nivel (1-12): '),
    read(Nivel),
    write('3. Ingresa el Atributo (ej: luz): '),
    read(Atributo),
    write('4. Ingresa el Poder (múltiplo de 50): '),
    read(Poder),

    % Construye el termino y valida tipos minimos antes de assertear.
    NewFact = mostro(Nombre, Nivel, Atributo, Poder),
    ( atom(Nombre), number(Nivel), atom(Atributo), number(Poder) ->
        assertz(NewFact),
        format('Monstruo ~w agregado con exito!~n', [Nombre])
    ;
        writeln('Error: Tipo de dato incorrecto en alguna entrada. Nombre/Atributo deben ser atomos; Nivel/Poder numeros.')
    ).

% eliminarMostro/0
% Pide un nombre y elimina todos los hechos con ese nombre usando retractall/1.
% Nota: retractall(mostro(Nombre, _, _, _)) quitará todas las coincidencias, no solo la primera.
eliminarMostro :-
    writeln(' Eliminar Monstruo por Nombre'),
    write('Ingresa el Nombre del monstruo a eliminar (ej: mostro4): '),
    read(Nombre),
    ( atom(Nombre) ->
        retractall(mostro(Nombre, _, _, _)),
        format('Todos los monstruos con el nombre ~w han sido eliminados de la base de conocimiento.~n', [Nombre])
    ;
        writeln('Error: Entrada invalida. El nombre debe ser un atomo.')
    ).


% Predicadod de ayuda/0
% Muestra los comandos disponibles para interactuar con el programa.
ayuda :-
    writeln('Comandos disponibles para la interaccion:'),
    writeln(''),
    writeln('  1. mundoChiquito.      -> Imprime TODAS las ternas A->B->C validas.'),
    writeln('  2. mostro(N, L, A, P). -> Muestra todos los monstruos en la base de datos.'),
    writeln('  3. agregarMostro.      -> Inicia el proceso de agregar un monstruo paso a paso.'),
    writeln('  4. eliminarMostro.     -> Elimina un monstruo especifico por su nombre.'),
    writeln('  5. ayuda.              -> Vuelve a mostrar este menu.'),
    writeln('  6. ternaMundoChiquito(A,B,C). -> Prueba una terna especifica (usa ; para mas soluciones).'),
    writeln(''),
    writeln('Recuerda terminar cada comando y entrada con un punto "."').
    

% Directiva para que el predicado 'ayuda' se ejecute inmediatamente después de la carga.
:- initialization(ayuda).