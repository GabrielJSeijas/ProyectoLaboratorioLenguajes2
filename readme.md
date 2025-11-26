# Proyecto II: Mundo Chiquito (Laboratorio de Lenguajes de Programación CI-3661)

Este proyecto implementa en **SWI-Prolog** un algoritmo para resolver las complejas condiciones de la carta de Conjuro "Mundo Chiquito", determinando todas las posibles secuencias de tres Monstruos (ternas) que satisfacen sus reglas.

CI-3661 Laboratorio de Lenguajes de Programación
Universidad Simón Bolívar



## Integrantes

Angel Valero 18-10436
Gabriel Seijas 19-00036



## Explicación de la Implementación

El problema reside en identificar qué Monstruos comparten **exactamente una característica** entre su Nivel, Poder o Atributo.

### 1. Predicado Auxiliar: `comparte_una_caracteristica/6`

Este predicado auxiliar es la base de la lógica y toma los tres atributos de dos monstruos (`M1` y `M2`). Utilizamos la negación por falla (`\+`) y la unificación (`=`) para garantizar que la condición de "exactamente una" se cumpla.

La condición se cumple si se satisface una de las siguientes tres cláusulas:
* Solo el Nivel es igual, y Poder y Atributo son diferentes.
* Solo el Poder es igual, y Nivel y Atributo son diferentes.
* Solo el Atributo es igual, y Nivel y Poder son diferentes.

### 2. Predicado Clave: `ternaMundoChiquito/3`

Este predicado es verdadero para cualquier terna de Monstruos `(A, B, C)` que sigue la secuencia de la carta:
1.  **Monstruo A (Mano)** **Monstruo B (Puente)**: Deben compartir exactamente una característica.
2.  **Monstruo B (Puente)**  **Monstruo C (Buscada)**: Deben compartir exactamente una característica.

Este predicado busca en la base de conocimiento (`mostro/4`) y aplica las dos condiciones de `comparte_una_caracteristica` de forma consecutiva.Se permite que las cartas sean repetidas, ya que un jugador puede incluir múltiples copias en su mazo.

### 3. Predicado de Salida: `mundoChiquito/0`

Este predicado de aridad 0 [cite: 31] se encarga de imprimir todas las soluciones encontradas. Utilizamos el predicado **`forall/2`** para iterar sobre cada `ternaMundoChiquito(A, B, C)` y el predicado **`format/2`** para imprimir los nombres de los monstruos separados por espacios, con un salto de línea para cada terna.

### 4. Predicado de Modificación Dinámica: `agregarMostro/0`

Este predicado permite al usuario ingresar dinámicamente una nueva carta `mostro/4` a la base de conocimiento.
* Utiliza **`writeln/1`** e **`write/1`** para proporcionar instrucciones claras sobre el formato de entrada esperado.
* Utiliza **`read/1`** para capturar la entrada del usuario.
* Utiliza **`assertz/1`** para agregar el nuevo hecho `mostro(Nombre, Nivel, Atributo, Poder)` al final de la base de conocimiento. El uso de la directiva **`:- dynamic mostro/4.`** en el archivo permite esta modificación dinámica.

---

##  Instrucciones para la Ejecución

1.  Abre la consola de SWI-Prolog.
2.  Carga el archivo:
    ```prolog
    consult('mundo_chiquito.pl').
    ```
3.  **Para encontrar e imprimir todas las ternas válidas:**
    ```prolog
    mundoChiquito.
    ```
4.  **Para agregar un nuevo monstruo a la base de conocimiento:**
    ```prolog
    agregarMostro.
    % Sigue las instrucciones que aparecerán en la consola, por ejemplo:
    % (miMostro, 6, tierra, 2000).
    ```
5.  **Para probar una terna específica (opcional):**
    ```prolog
    ternaMundoChiquito(A, B, C).
    % Presiona ';' para ver más soluciones.
    ```