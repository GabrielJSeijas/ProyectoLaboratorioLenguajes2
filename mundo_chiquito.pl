:- dynamic mostro/4.

% mostro(nombre, nivel, atributo, poder).
mostro(mostroUno, 5, luz, 2100).
mostro(mostroDos, 7, luz, 2400).
mostro(mostroTres, 7, viento, 2500).

% --- PREDICADOS AUXILIARES ---

% Predicado para verificar si dos valores son iguales (unificación).
igual(X, Y) :- X = Y.

% Predicado para verificar si dos valores son diferentes (negación por falla).
diferente(X, Y) :- \+ (X = Y).

% comparte_una_caracteristica/6
% Verifica que exactamente una de las tres características sea la misma.
% A: NivelA, PoderA, AtribA
% B: NivelB, PoderB, AtribB

% Caso 1: Solo Nivel es igual
comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    igual(NivelA, NivelB),
    diferente(PoderA, PoderB),
    diferente(AtribA, AtribB).

% Caso 2: Solo Poder es igual
comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    diferente(NivelA, NivelB),
    igual(PoderA, PoderB),
    diferente(AtribA, AtribB).

% Caso 3: Solo Atributo es igual
comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB) :-
    diferente(NivelA, NivelB),
    diferente(PoderA, PoderB),
    igual(AtribA, AtribB).

% --- PREDICADOS PRINCIPALES DEL PROYECTO ---

% ternaMundoChiquito(NombreA, NombreB, NombreC)
% Encuentra una secuencia A -> B -> C que satisface las condiciones. 
% A y B comparten exactamente una característica. 
% B y C comparten exactamente una característica. 
ternaMundoChiquito(NombreA, NombreB, NombreC) :-
    % Monstruo A (Mano)
    mostro(NombreA, NivelA, AtribA, PoderA),
    
    % Monstruo B (Mazo 1 - 'Puente')
    mostro(NombreB, NivelB, AtribB, PoderB),
    
    % Monstruo C (Mazo 2 - Carta Buscada)
    mostro(NombreC, NivelC, AtribC, PoderC),
    
    % Condición 1: A y B comparten UNA característica.
    comparte_una_caracteristica(NivelA, PoderA, AtribA, NivelB, PoderB, AtribB),
    
    % Condición 2: B y C comparten UNA característica.
    comparte_una_caracteristica(NivelB, PoderB, AtribB, NivelC, PoderC, AtribC).


% mundoChiquito/0
% Imprime todas las ternas por la salida estándar.
mundoChiquito :-
    writeln('--- Ternas Mundo Chiquito Encontradas ---'),
    % forall/2 itera sobre todas las soluciones de la condición y ejecuta la acción
    forall(
        ternaMundoChiquito(A, B, C),
        format('~w ~w ~w~n', [A, B, C]) % ~w imprime el término, ~n es salto de línea
    ),
    writeln('----------------------------------------').


% agregarMostro/0
% Lee los datos de un nuevo monstruo y lo agrega dinámicamente. 
agregarMostro :-
    writeln('--- Agregar Monstruo ---'),
    writeln('Instruccion: Ingresa los datos como una tupla: (Nombre, Nivel, Atributo, Poder).'),
    writeln('Ejemplo: miMostro, 8, fuego, 3000.'),
    write('Ingresa la informacion del monstruo (termina con un punto): '),
    
    % Leer el término ingresado por el usuario
    read(Term),
    
    % Intentar descomponer la tupla (Nombre, Nivel, Atributo, Poder)
    ( Term = (Nombre, Nivel, Atributo, Poder) ->
        % Crear el hecho completo
        NewFact = mostro(Nombre, Nivel, Atributo, Poder),
        
        % Agregar dinámicamente a la base de conocimiento (requiere :- dynamic mostro/4.)
        assertz(NewFact),
        format('Monstruo ~w agregado con exito!~n', [Nombre])
    ;
        writeln('Error: Formato de entrada incorrecto. Asegurate de usar: (Nombre, Nivel, Atributo, Poder).')
    ).