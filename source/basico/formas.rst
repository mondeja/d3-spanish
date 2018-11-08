.. _d3-shape-section:

**********************
Formas --- `d3-shape`_
**********************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>



`Arcos`_
========

`d3.arc()`_
-----------
El generador de arcos produce una sección circular o en anillo, como en un gráfico *pie* o *donut*. Si la diferencia entre el ángulo de comienzo y el de final es mayor a 360 grados, el generador de arco producirá un círculo o anillo completo, si no, los arcos pueden tener las esquinas redondeadas y espaciado entre seccionares (padding angular).

Los arcos siempre están centrados en la posición `(0,0)`, por lo que hay que usar el attributo ``transform translate(x,y)`` para moverlos a una posición diferente.

Los diferentes generadores producen formas que pueden ser pasadas al atributo ``d`` de un elemento ``path`` en ``svg``. Por ejemplo:

.. code-block:: html

   <div id="arc-1"></div>
   <script>
     var arco_d = d3.arc()
         .innerRadius(0)
         .outerRadius(100)
         .startAngle(0)
         .endAngle(Math.PI);

     arco_d();  // M6.123233995736766e-15,-100A100,100,0,1,1,6.123233995736766e-15,100L0,0Z

     d3.select("#arc-1")
         .append("svg")
           .attr('width', 250)
           .attr('height', 250)
         .append("g")
           .attr("transform", "translate(125,125)")
         .append("path")
           .attr("d", arco_d)
           .attr("fill", "red");
   </script>

.. raw:: html

   <div id="arc-1"></div>
   <script>
     var arco_d = d3.arc()
         .innerRadius(0)
         .outerRadius(100)
         .startAngle(0)
         .endAngle(Math.PI);

     arco_d();  // M6.123233995736766e-15,-100A100,100,0,1,1,6.123233995736766e-15,100L0,0Z

     d3.select("#arc-1")
         .append("svg")
           .attr('width', 250)
           .attr('height', 250)
         .append("g")
           .attr("transform", "translate(125,125)")
         .append("path")
           .attr("d", arco_d)
           .attr("fill", "red");
   </script>

`Areas`_
========

Para generar un area en un chart hemos de escribir algo como:

.. rubric:: Input

.. code-block:: html

   <div id="area-1"></div>
   <script>
     var margin = {top: 25, bottom: 25}
         width = 680,
         height = 340 - margin.top - margin.bottom;

     var svg = d3.select("#area-1").append("svg")
         .attr("width", width)
         .attr("height", height + margin.top + margin.bottom);

     var data = [1, 3, 2, 3, 5, 8, 4, 9];

     yScale = d3.scaleLinear()
         .domain(d3.extent(data))
         .range([0, height]);

     var area = d3.area()
         .x(function(d, i){ return (width/data.length)*i; })
         .y0(height)
         .y1(function(d){ return height-yScale(d); })
         .curve(d3.curveMonotoneX);

     var path = svg.append("path")
         .attr("d", area(data))
         .style("fill", "lightsteelblue");
   </script>

.. rubric:: Output

.. raw:: html

   <div id="area-1"></div>
   <script>
     var margin = {top: 25, bottom: 25}
         width = 680,
         height = 340 - margin.top - margin.bottom;

     var svg = d3.select("#area-1").append("svg")
         .attr("width", width)
         .attr("height", height + margin.top + margin.bottom);

     var data = [1, 3, 2, 3, 5, 8, 4, 9];

     yScale = d3.scaleLinear()
         .domain(d3.extent(data))
         .range([0, height]);

     var area = d3.area()
         .x(function(d, i){ return (width/data.length)*i; })
         .y0(height)
         .y1(function(d){ return height-yScale(d); })
         .curve(d3.curveMonotoneX);

     var path = svg.append("path")
         .attr("d", area(data))
         .style("fill", "lightsteelblue");
   </script>

La función `d3.area()`_ crea un generador de areas. La línea de arriba se define por los métodos `area.x1([x])`_ y `area.y1([y])`_, y es renderizada primero. La línea de abajo se define por los métodos `area.x0([x])`_ y `area.y0([y])`_. Las funciones `area.x([x])`_ y `area.y([y])`_ establecen los parámetros ``0`` y ``1`` de cada coodenada a un mismo valor, es decir:

.. code-block:: js

   // Esto es lo mismo...
   .x(function(d, i){ return (width/data.length)*i; })

   // ...que esto
   .x0(function(d, i){ return (width/data.length)*i; })
   .x1(function(d, i){ return (width/data.length)*i; })


`Links`_
========

La forma de **link** genera una curva Bézier cúbica suave desde un punto hasta otro.

Para incluir un link con un punto inicial y destino indicados manualmente, primero inicializamos un generador ``link`` que puede ser vertical, horizontal o radial y luego pasamos a la función un objeto con los atributos ``source`` y ``target`` donde especificamos las coordenadas de comienzo y final de la línea por medio de arrays numéricos de dos elementos:

.. code-block:: js

   var link = d3.linkVertical();
   var path = svg.append("path")
       .attr("d", link({
           source: [50, 50],
           target: [150, 150]
       }));


`d3.linkVertical()`_
--------------------

Genera una curva Bézier cúbica suave con tangentes verticales.

.. rubric:: Input

.. code-block:: html

   <div id="link-vertical-1"></div>
   <script>
   var width = 300,
       height = 200;

   var svg = d3.select("#link-vertical-1").append("svg")
       .attr("width", width)
       .attr("height", height);

   var link = d3.linkVertical();
   var path = svg.append("path")
       .attr("d", link({
           source: [50, 50],
           target: [150, 150]
       }))
       .style("stroke", "navy")
       .style("stroke-width", "3px")
       .style("fill", "none");
   </script>

.. rubric:: Output

.. raw:: html

   <div id="link-vertical-1"></div>
   <script>
   var width = 300,
       height = 200;

   var svg = d3.select("#link-vertical-1").append("svg")
       .attr("width", width)
       .attr("height", height);

   var link = d3.linkVertical();
   var path = svg.append("path")
       .attr("d", link({
           source: [50, 50],
           target: [150, 150]
       }))
       .style("stroke", "navy")
       .style("stroke-width", "3px")
       .style("fill", "none");
   </script>


`d3.linkHorizontal()`_
----------------------

Genera una curva Bézier cúbica suave con tangentes horizontales.

.. rubric:: Input

.. code-block:: html

   <div id="link-horizontal-1"></div>
   <script>
     var width = 300,
         height = 200;

     var svg = d3.select("#link-horizontal-1").append("svg")
         .attr("width", width)
         .attr("height", height);

     var link = d3.linkHorizontal();
     var path = svg.append("path")
         .attr("d", link({
             source: [50, 50],
             target: [150, 150]
         }))
         .style("stroke", "royalblue")
         .style("stroke-width", "3px")
         .style("fill", "none");
   </script>

.. rubric:: Output

.. raw:: html

   <div id="link-horizontal-1"></div>
   <script>
     var width = 300,
         height = 200;

     var svg = d3.select("#link-horizontal-1").append("svg")
         .attr("width", width)
         .attr("height", height);

     var link = d3.linkHorizontal();
     var path = svg.append("path")
         .attr("d", link({
             source: [50, 50],
             target: [150, 150]
         }))
         .style("stroke", "royalblue")
         .style("stroke-width", "3px")
         .style("fill", "none");
   </script>


.. _Arcos: https://github.com/d3/d3-shape/blob/master/README.md#arcs
.. _d3-shape: https://github.com/d3/d3-shape
.. _d3.arc(): https://github.com/d3/d3-shape#arc

.. _Areas: https://github.com/d3/d3-shape/blob/master/README.md#areas
.. _d3.area(): https://github.com/d3/d3-shape/blob/master/README.md#area
.. _area.x([x]): https://github.com/d3/d3-shape/blob/master/README.md#area_x
.. _area.x0([x]): https://github.com/d3/d3-shape/blob/master/README.md#area_x0
.. _area.x1([x]): https://github.com/d3/d3-shape/blob/master/README.md#area_x1
.. _area.y([y]): https://github.com/d3/d3-shape/blob/master/README.md#area_y
.. _area.y0([y]): https://github.com/d3/d3-shape/blob/master/README.md#area_y0
.. _area.y1([y]): https://github.com/d3/d3-shape/blob/master/README.md#area_y1

.. _Links: https://github.com/d3/d3-shape/blob/master/README.md#links
.. _d3.linkVertical(): https://github.com/d3/d3-shape/blob/master/README.md#linkVertical
.. _d3.linkHorizontal(): https://github.com/d3/d3-shape/blob/master/README.md#linkHorizontal
