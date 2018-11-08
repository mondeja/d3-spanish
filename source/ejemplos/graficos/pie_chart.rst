***********************
Gráficos de torta (pie)
***********************

Si quisieramos realizar un gráfico de torta usando la función `d3.arc()`_ deberiamos crear varios arcos con valores de comienzo y final de ángulos diferentes, calculando el porcentaje en grados de cada dato con respecto al total, redefiniendo los lugares de aparición de cada trozo... una aproximación nada práctica.

Por ello `d3-shape`_ ofrece la función `d3.pie()`_ la cual ayuda mucho en este cometido.

`d3.pie()`_
-----------

Esta función no produce una forma directamente, si no que calcula los ángulos necesarios para representar un conjunto de datos tabulado como un gráfico de torta o de donut. Esos ángulos pueden ser pasados a un generador de arco (`d3.arc()`_).


.. rubric:: Input

.. code-block:: js

   var data = [1, 1, 2, 3, 5, 8, 13, 21];
   var arcs = d3.pie()(data);
   console.log(arcs);

.. rubric:: Output

::

   [
     {"data":  1, "value":  1, "index": 6, "startAngle": 6.050474740247008, "endAngle": 6.166830023713296, "padAngle": 0},
     {"data":  1, "value":  1, "index": 7, "startAngle": 6.166830023713296, "endAngle": 6.283185307179584, "padAngle": 0},
     {"data":  2, "value":  2, "index": 5, "startAngle": 5.817764173314431, "endAngle": 6.050474740247008, "padAngle": 0},
     {"data":  3, "value":  3, "index": 4, "startAngle": 5.468698322915565, "endAngle": 5.817764173314431, "padAngle": 0},
     {"data":  5, "value":  5, "index": 3, "startAngle": 4.886921905584122, "endAngle": 5.468698322915565, "padAngle": 0},
     {"data":  8, "value":  8, "index": 2, "startAngle": 3.956079637853813, "endAngle": 4.886921905584122, "padAngle": 0},
     {"data": 13, "value": 13, "index": 1, "startAngle": 2.443460952792061, "endAngle": 3.956079637853813, "padAngle": 0},
     {"data": 21, "value": 21, "index": 0, "startAngle": 0.000000000000000, "endAngle": 2.443460952792061, "padAngle": 0}
   ]


.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>


Ejemplo
~~~~~~~

.. rubric:: Input

.. code-block:: html

   <style>
     .arc text {
       font: 10px sans-serif;
       text-anchor: middle;
     }
     .arc path {
       stroke: teal;
       stroke-width: 3.5px;
     }
   </style>

   <div id="pie-chart-1"></div>

   <script>
     var data = [10, 20, 100];

     var width = 748,
         height = 530,
         radius = Math.min(width, height) / 2;

     var color = d3.scaleOrdinal()
         .range(["#98abc5", "#8a89a6", "#7b6888"]);

     var arc = d3.arc()
         .outerRadius(radius - 10)
         .innerRadius(0);

     var labelArc = d3.arc()
         .outerRadius(radius - 50)
         .innerRadius(radius - 50);

     var pie = d3.pie()
         .sort(null)
         .value(function(d) { return d; });

     var svg = d3.select("#pie-chart-1").append("svg")
         .attr("width", width)
         .attr("height", height)
       .append("g")
         .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

       var g = svg.selectAll(".arc")
           .data(pie(data))
         .enter().append("g")
           .attr("class", "arc");

       g.append("path")
           .attr("d", arc)
           .style("fill", function(d) { return color(d.data); });

       g.append("text")
           .attr("transform", function(d) { return "translate(" + labelArc.centroid(d) + ")";   })
           .attr("dy", ".35em")
           .text(function(d) { return d.data; });
   </script>

.. rubric:: Output

.. raw:: html

   <style>
     .arc text {
       font: 10px sans-serif;
       text-anchor: middle;
     }
     .arc path {
       stroke: teal;
       stroke-width: 3.5px;
     }
   </style>

   <div id="pie-chart-1"></div>
   <br>

   <script>
     var data = [10, 20, 100];

     var width = 748,
         height = 500,
         radius = Math.min(width, height) / 2;

     var color = d3.scaleOrdinal()
         .range(["#98abc5", "#8a89a6", "#7b6888"]);

     var arc = d3.arc()
         .outerRadius(radius - 10)
         .innerRadius(0);

     var labelArc = d3.arc()
         .outerRadius(radius - 50)
         .innerRadius(radius - 50);

     var pie = d3.pie()
         .sort(null)
         .value(function(d) { return d; });

     var svg = d3.select("#pie-chart-1").append("svg")
         .attr("width", width)
         .attr("height", height)
       .append("g")
         .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

       var g = svg.selectAll(".arc")
           .data(pie(data))
         .enter().append("g")
           .attr("class", "arc");

       g.append("path")
           .attr("d", arc)
           .style("fill", function(d) { return color(d.data); });

       g.append("text")
           .attr("transform", function(d) { return "translate(" + labelArc.centroid(d) + ")";   })
           .attr("dy", ".35em")
           .text(function(d) { return d.data; });
   </script>

Para realizar un gráfico de torta en D3 seguimos los siguientes pasos:

#. Realizamos un mapeo de colores a los datos. En el ejemplo anterior puedes ver un mapeo de 1 a 1, ya que hay el mismo número de datos que de colores, pero el mapeo puede ser un dominio numérico, por ejemplo, en una escala de colores más claros a oscuros.
#. Creamos las formas circulares tanto del gráfico en sí como de la posición de las marcas de texto con la función `d3.arc()`_, estableciendo las propiedades `innerRadius`_ y `outerRadius`_.
#. Creamos un generador de gráfico de torta con la función `d3.pie()`_, al cual podemos pasarle un ordenamiento con el método `sort()`_. Además, con `value()`_ establecemos como se distribuirán las cantidades para generar los ángulos correspondientes a cada porción de los datos.
#. Renderizamos las porciones en el contenedor ``svg`` pasando los datos a través del generador ``pie`` con ``.data(pie(data))``. Cada porción la incluimos en un grupo.
#. Para cada grupo insertamos los paths correspondientes a las etiquetas y a la propia porción definidos en el paso 2 mediante ``.attr("d", arc)``.


.. _d3-shape: https://github.com/d3/d3-shape
.. _d3.arc(): https://github.com/d3/d3-shape/blob/master/README.md#arc
.. _innerRadius: https://github.com/d3/d3-shape/blob/master/README.md#arc_innerRadius
.. _outerRadius: https://github.com/d3/d3-shape/blob/master/README.md#arc_outerRadius
.. _d3.pie(): https://github.com/d3/d3-shape/blob/master/README.md#pie
.. _sort(): https://github.com/d3/d3-shape/blob/master/README.md#pie_sort
.. _value(): https://github.com/d3/d3-shape/blob/master/README.md#pie_value
