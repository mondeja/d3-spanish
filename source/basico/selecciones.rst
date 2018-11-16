.. _d3-selection-section:

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

.. note::

   Con el siguiente código, hemos aumentado el tamaño del título de este capítulo y lo hemos centrado:

   .. code-block:: javascript

      d3.select("h1")
        .style("font-size", "2em")
        .style("text-align", "center");


.. raw:: html

   <script>
      d3.select("h1")
        .style("font-size", "2em")
        .style("text-align", "center");
   </script>


.. _d3-data-section:

Trabajando con datos
====================

`D3JS`_ es una biblioteca enfocada a representar datos de forma gráfica. Para ello, cuenta con funciones que están especializadas en enlazar datos y elementos, para ir actualizándolos sincronizados.

Enlazando datos y elementos - `selection.data`_
-----------------------------------------------

Jugando con las selecciones podemos hacer lo siguiente:

.. code-block:: html

   <div id="contenedor-vacio"></div>
   <script>
       var spans = d3.select("contenedor-vacio")
           .selectAll("span");

       console.log(spans);
       /**
        * Rt {_groups: Array(0), _parents: Array(0)}
        *   _groups: []
        *   _parents: []
        *   __proto__: Object
        **/
   </script>

.. raw:: html

   <div id="contenedor-vacio"></div>
   <script>
       var spans = d3.select("contenedor-vacio")
           .selectAll("span");
   </script>

Como puedes ver, devuelve una selección vacía. Esto no parece tener mucho sentido, ¿por qué obtener los elementos ``span`` de un ``div`` vacío? Pues en `D3JS`_ esto es muy común.


.. seealso::

   `Thinking with joins - Mike Bostock <https://bost.ocks.org/mike/join/>`__

Supongamos que tenemos los siguientes datos que representan los días de la semana:

.. code-block:: javascript

   var data = [
       {day: "Monday", days_until_next_weekend: 5},
       {day: "Tuesday", days_until_next_weekend: 4},
       {day: "Wednesday", days_until_next_weekend: 3},
       {day: "Thursday", days_until_next_weekend: 2},
       {day: "Friday", days_until_next_weekend: 1},
       {day: "Saturday", days_until_next_weekend: 7},
       {day: "Sunday", days_until_next_weekend: 6},
   ]

.. raw:: html

   <script>
       var data = [
           {day: "Monday", days_until_next_weekend: 5},
           {day: "Tuesday", days_until_next_weekend: 4},
           {day: "Wednesday", days_until_next_weekend: 3},
           {day: "Thursday", days_until_next_weekend: 2},
           {day: "Friday", days_until_next_weekend: 1},
           {day: "Saturday", days_until_next_weekend: 7},
           {day: "Sunday", days_until_next_weekend: 6},
       ]
   </script>

Podríamos representar esos datos como elementos SVG haciendo lo siguiente:

.. code-block:: javascript

   for (var i=0; i<data.length; i++) {
       var g = svg.append("g");
       g.attr("transform", "translate(" + (90*i+30) + "," + height/2 + ")");

       var circle = g.append("circle");
       circle.attr("r", 10);
       circle.attr("fill", "red");
       circle.attr("fill-opacity", 0.2);

       var text = g.append("text");
       text.text(data[i].day);
   }

.. raw:: html

   <svg id="data1" width="650" height="50"></svg>
   <script>
       var svg = d3.select("#data1"),
           height = +svg.attr("height"),
           width = +svg.attr("width");

       for (var i=0; i<data.length; i++) {
           var g = svg.append("g");
           g.attr("transform", "translate(" + (90*i+30) + "," + height/2 + ")");

           var circle = g.append("circle");
           circle.attr("r", 10);
           circle.attr("fill", "red");
           circle.attr("fill-opacity", 0.2);

           var text = g.append("text");
           text.text(data[i].day);
       }

   </script>

Pero, ¿qué pasaría si queremos actualizar esos datos en tiempo real? Tendríamos que atravesar el DOM buscando el dato que queremos y eliminar sus elementos correspondientes. Además, fíjate en la sintaxis. ¿No es demencial? 

Ahora, veamos el mismo ejemplo usando D3:

.. code-block:: javascript

   var g = svg.selectAll("g")
     .data(data)
     .enter().append("g")
       .attr("transform",function(d, i){
           return "translate(" + (90*i+30) + "," + height/2 + ")";
       })

   g.append("circle")
     .attr("r", 10)
     .attr("fill", "red")
     .attr("fill-opacity", 0.2)

   g.append("text")
     .text(function(d) { return d.day; });

.. raw:: html

   <svg id="data2" width="650" height="50"></svg>
   <script>
       var svg = d3.select("#data2"),
           height = +svg.attr("height"),
           width = +svg.attr("width");

       var g = svg.selectAll("g")
          .data(data)
          .enter().append("g")
            .attr("transform",function(d, i){
                return "translate(" + (90*i+30) + "," + height/2 + ")";
            })

       g.append("circle")
            .attr("r", 10)
            .attr("fill", "red")
            .attr("fill-opacity", 0.2)

        g.append("text")
            .text(function(d) { return d.day; });
   </script>
   

Presta atención a la primera línea: ``svg.selectAll("g")``. ¡Estamos seleccionando elementos que no existen! Así creamos una selección vacía y en la siguiente línea le pasamos nuestros datos a esa selección con la función `selection.data`_.

Para comprobar lo que hace esta extraña función podemos hacer:

.. code-block:: javascript
   
   var g = svg.selectAll("g").data(data);
   console.log(g);
   
   /**
    * Rt {_groups: Array(1), _parents: Array(1), _enter: Array(1), _exit: Array(1)}
    *   _enter: [Array(7)]
    *   _exit: [Array(0)]
    *   _groups: [Array(7)]
    *   _parents: [svg#data2]
    **/

Mira que interesante. Tenemos un objeto muy parecido a una selección. Las propiedades ``_groups`` y ``_parents`` siguen siendo los grupos de objetos y los padres (en este caso el elemento SVG raíz), que los vimos al principio de este capítulo. Pero ahora han aparecido dos propiedades más: ``_enter`` y ``_exit``:

- ``_enter``: Es la propiedad donde se almacena la selección de los datos que han entrado a la selección. Para obtener los elementos de esta selección usamos la función `selection.enter`_.
- ``_exit``: Es la propiedad donde se almacena la selección de los datos que existen en los elementos del DOM seleccionados pero ya no existen entre los datos que han entrado a la selección, es decir, correponde a los datos que salen. Para obtener los elementos de esta selección usamos la función `selection.exit`_.


Patrón de actualización
-----------------------

Como dijimos al principio, `D3JS`_ no sólo es capaz de enlazar datos a elementos y representarlos, si no que es capaz de actualizarlos en tiempo real. Para ello, es fundamental conocer el patrón de actualización y como implementarlo en `D3JS`_.

.. seealso::

   - `General Update Pattern, I <https://bl.ocks.org/mbostock/3808218>`__
   - `General Update Pattern, III <https://bl.ocks.org/mbostock/3808234>`__

Este sigue los siguientes pasos:

1. Antes de la ejecución del código, no existen elementos en el DOM.
2. Cuando se ejecuta por primera vez una selección vacía con `selectAll`_ y le enlazamos datos con `selection.data`_, la selección sigue estando vacía, pero se añaden las propiedades ``_enter`` y ``_exit`` y estas esperan a que entren o salgan datos.
3. Cuando se ejecuta la función `selection.enter`_, seleccionamos todos los datos que entraron con `selection.data`_ preparados para ser manipulados. En este paso es muy común añadir los elementos correspondientes a los datos al DOM con `selection.append`_  o `selection.insert`_.
4. Como estamos en un patrón de actualización, tenemos que ejecutar un timer (ver :ref:`d3-timer-section`), es decir, tenemos que hacer que se establezca algún tipo de bucle para que se pueda actualizar el contenido de la presentación.
5. A partir de la segunda vez que aplicamos la función `selection.data`_ sobre un elemento ocurre lo siguiente:

   - La selección ``exit`` almacenará los elementos cuyos datos definimos la primera vez pero ahora no se encuentran entre los nuevos datos. Es muy común aplicar sobre ellos la función `selection.remove`_ para eliminarlos.
   - La selección ``enter`` alamacenará los elementos cuyos datos han entrado nuevos, los cuales no existían antes en el DOM.

.. _d3-selection: https://github.com/d3/d3-selection
.. _selectAll: https://github.com/d3/d3-selection#selectAll
.. _selection.data: https://github.com/d3/d3-selection/blob/master/README.md#selection_data
.. _selection.enter: https://github.com/d3/d3-selection#selection_enter
.. _selection.exit: https://github.com/d3/d3-selection#selection_exit
.. _selection.append: https://github.com/d3/d3-selection#selection_append
.. _selection.insert: https://github.com/d3/d3-selection#selection_insert
.. _selection.remove: https://github.com/d3/d3-selection#selection_remove