.. _d3-selection:

*******************************
Selecciones --- `d3-selection`_
*******************************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js"></script>
   <script>console.log("D3JS v" + d3.version)</script>


El módulo `d3-selection`_ está incluido en la distribución estándar de `D3JS`_ y proporciona funciones para seleccionar elementos del DOM. Usa las cadenas de texto de selecciones estandarizadas por la `W3C <https://www.w3.org/TR/selectors-api/>`__:

.. code-block:: js

   // Selección de un nodo
   var a = d3.select("a");
   console.log(a);

   // Selección de todos
   var lis = d3.selectAll("li");

   // Selección anidada
   var as = d3.selectAll("li")
       .select("a");


.. raw:: html

   <script>
       // Selección de un nodo
       var a = d3.select("a");
       console.log(a);

       // Selección de todos
       var lis = d3.selectAll("li");

       // Selección anidada
       var as = d3.selectAll("li")
         .select("a");
   </script>

.. seealso:: 

   - `How selections Work - Mike Bostock <https://bost.ocks.org/mike/selection/>`_



Si ves la salida de la consola, puedes comprobar como la selección devuelve un objeto con los atributos ``_groups`` y ``_parents``.

- ``_groups``: representa a los grupos de objetos que han sido seleccionados. `D3JS`_ almacena agrupados los objetos para ejecutar operaciones sobre ellos. Es una subclase de ``Array``.
- ``_parents``: representa los padres de los grupos de objetos. Estos dependerán de como se seleccionan. Usando fuciones como ``d3.select`` en lugar de usar sintaxis encadenada con ``.select`` sobre otro objeto, devolverá un array con el objeto raíz del documento HTML.

.. raw:: html

   <script>
      // Aumentamos el tamaño del título y lo centramos. 
      var title = d3.select("h1")
         .style("font-size", "2em")
         .style("text-align", "center");

      // Cogemos todos los links y los reestilamos
      var links = d3.select("body")
        .style("background-color", "PaleGreen")
   </script>

Trabajando con datos
====================



.. d3-selection: https://github.com/d3/d3-selection