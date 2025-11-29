# Proyecto II: Mundo Chiquito (Laboratorio de Lenguajes de Programación CI-3661)

Este proyecto implementa en **SWI-Prolog** un algoritmo para resolver las complejas condiciones de la carta de Conjuro "Mundo Chiquito", determinando todas las posibles secuencias de tres Monstruos (ternas) que satisfacen sus reglas.

CI-3661 Laboratorio de Lenguajes de Programación
Universidad Simón Bolívar

## Integrantes
Angel Valero 18-10436
Gabriel Seijas 19-00036

## Explicación de la Implementación
El núcleo del problema reside en identificar qué Monstruos comparten exactamente una característica entre su Nivel, Poder o Atributo. Para esto, se creó el predicado auxiliar comparte_una_caracteristica/6, que toma los tres atributos de dos monstruos y verifica que se cumpla solo una de las tres posibles condiciones de igualdad. La exclusividad se garantiza utilizando la negación por falla (\+) junto con la unificación (=) en las cláusulas que definen los casos: solo Nivel igual, solo Poder igual, o solo Atributo igual.

### 1. Predicado de Búsqueda: `ternaMundoChiquito/3`
Este predicado es verdadero para cualquier terna de Monstruos (A, B, C) que sigue la secuencia de la carta. Se requiere que el Monstruo A (mano) y el Monstruo B (puente) compartan exactamente una característica. Luego, el Monstruo B (puente) y el Monstruo C (buscada) deben cumplir la misma condición. El predicado busca en la base de conocimiento (mostro/4) y encadena las dos condiciones de comparte_una_caracteristica de forma consecutiva. Se permite la repetición de cartas, ya que un jugador puede incluir múltiples copias en su mazo.

### 2. Predicado de Salida: `mundoChiquito/0`
Este predicado de aridad 0 se encarga de imprimir todas las soluciones encontradas. Utiliza el predicado forall/2 para iterar sobre todas las soluciones generadas por ternaMundoChiquito(A, B, C). Por cada solución, el predicado format/2 imprime los nombres de los monstruos separados por espacios, con un salto de línea para cada terna.

### 3. Predicado de Visualización: `mostrarMostros/0`
Este predicado de aridad 0 se encarga de mostrar todos los hechos mostro/4 que se encuentran cargados en la base de conocimiento en el momento de la ejecución. Es una herramienta esencial para la gestión y verificación de las cartas disponibles. Utiliza el predicado forall/2 para iterar sobre todos los hechos mostro(N, L, A, P) que encuentre. Por cada monstruo, el predicado format/2 imprime sus cuatro atributos (Nombre, Nivel, Atributo y Poder) de una manera clara y estructurada.

### 3. Predicados de Modificación Dinámica y Gestión
Para permitir la gestión dinámica de la base de conocimiento por parte del usuario, se utiliza la directiva :- dynamic mostro/4..

### 4. Función Agregar Monstruo: `agregarMostro/0`
Este predicado permite al usuario ingresar dinámicamente una nueva carta mostro/4. Para evitar problemas de sintaxis con paréntesis en la consola, el predicado solicita los datos paso a paso (Nombre, Nivel, Atributo, Poder). Utiliza el predicado read/1 para capturar cada valor y, finalmente, assertz/1 para agregar el nuevo hecho al final de la base de conocimiento dinámica. Incluye validación de tipos de datos.

##  5. Función Eliminar Monstruo: `eliminarMostro/0`
Este predicado permite eliminar uno o más monstruos de la base de conocimiento utilizando únicamente el nombre del monstruo como criterio de búsqueda. Se solicita el nombre al usuario y se utiliza el predicado retractall/1 con un patrón (mostro(Nombre, _, _, _)) para eliminar todas las instancias de ese monstruo, sin importar el valor de sus otros atributos.

## Instrucciones para la Ejecución del programa 
- Abre la consola de SWI-Prolog y carga el archivo: "consult('mundo_chiquito.pl')." 
- Para encontrar e imprimir todas las ternas válidas: "mundoChiquito." 
- Para ver todos los monstruos actuales: "mostro(N, L, A, P)." (presiona punto y coma, para que te muestre todos).
- "agregarMostro." : Para agregar un nuevo monstruo, sigue las instrucciones paso a paso que aparecerán en la consola, terminando cada entrada con un punto.  
- "eliminarMostro." Para eliminar un monstruo, introduce solo el nombre y un punto.  
- Para probar una terna específica, puedes usar: ternaMundoChiquito(A, B, C). (presiona punto y coma para ver más soluciones).
- ayuda. para ver los comandos disponibles.



