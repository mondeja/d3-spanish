******************
Gráficos de lineas
******************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>

Veamos un ejemplo sacado `de aquí <https://gist.github.com/d3noob/402dd382a51a4f6eea487f9a35566de0>`__, en el cual creamos paso a paso un gráfico simple de una línea. Observa como varios componentes de la biblioteca D3js trabajan en conjunto.

Primero creamos un contenedor donde alojar el gráfico y el estilo de la línea.

.. code-block:: html

   <div id="container"></div>

   <style>
     .line {
       fill: none;
       stroke: steelblue;
       stroke-width: 2px;
     }
   </style>
   <script src="path/to/create_line_graph.js">

Siempre, al realizar figuras, es útil establecer los márgenes, ancho y alto al principio.

.. rubric:: ``create_line_graph.js``

.. code-block:: js

   // Establecemos las dimensiones y los márgenes del gráfico
   var margin = {top: 30, right: 20, bottom: 20, left: 20},
       width = 680 - margin.left - margin.right,
       height = 315 - margin.top - margin.bottom;

   // Establecemos las escalas y sus rangos a lo largo de los ejes x y
   var x = d3.scaleTime().range([0, width]);
   var y = d3.scaleLinear().range([height, 0]);

   // Creamos la figura svg
   var svg = d3.select("#container").append("svg")
       .attr("width", width + margin.left + margin.right)
       .attr("height", height + margin.top + margin.bottom)
     .append("g")
       .attr("transform",
             "translate(" + margin.left + "," + margin.top + ")");

   // Creamos una línea que más tarde cargaremos en el path
   var valueline = d3.line()
       .x(function(d) { return x(d.date); })
       .y(function(d) { return y(d.close); });

   // Compilamos un parser para las fechas (por ejemplo: 1-May-12)
   var parseTime = d3.timeParse("%d-%b-%y");

   // Creamos el eje X, formateando las fechas
   var xAxis = d3.axisBottom(x)
       .tickFormat(d3.timeFormat("%Y-%m-%d"));

   // Obtenemos los datos
   var url = "https://gist.githubusercontent.com/d3noob/402dd382a51a4f6eea487f9a35566de0/raw/6369502941b44261f381399a24fb455cb4290be8/data.csv";
   d3.csv(url, function(error, data) {
       if (error) throw error;

       // Los formateamos
       data.forEach(function(d) {
           console.log(d);
           d.date = parseTime(d.date);
           d.close = +d.close;
       });

       // Escalamos el rango de los datos
       x.domain(d3.extent(data, function(d) { return d.date; }));
       y.domain([0, d3.max(data, function(d) { return d.close; })]);

       // Añadimos y estilizamos la línea
       svg.append("path")
           .data([data])
           .attr("class", "line")
           .attr("d", valueline);

       // Añadimos los ejes
       svg.append("g")
           .attr("transform", "translate(0," + height + ")")
           .call(xAxis)
           .selectAll("text")
             .style("text-anchor", "end")
             .attr("dx", "-.8em")
             .attr("dy", ".15em")
             .attr("transform", function(d) {
                 return "rotate(-40)"
                 });

       svg.append("g")
           .call(d3.axisLeft(y));
     });

.. rubric:: Output

.. raw:: html

   <div id="container"></div>
   <style>
     .line {
       fill: none;
       stroke: steelblue;
       stroke-width: 2px;
     }
   </style>

   <script>
     var margin = {top: 30, right: 0, bottom: 80, left: 40},
         width = 680 - margin.left - margin.right,
         height = 450 - margin.top - margin.bottom;

     var parseTime = d3.timeParse("%d-%b-%y");

     var x = d3.scaleTime().range([0, width]);
     var y = d3.scaleLinear().range([height, 0]);

     var valueline = d3.line()
         .x(function(d) { return x(d.date); })
         .y(function(d) { return y(d.close); });

     var svg = d3.select("#container").append("svg")
         .attr("width", width + margin.left + margin.right)
         .attr("height", height + margin.top + margin.bottom)
       .append("g")
         .attr("transform",
               "translate(" + margin.left + "," + margin.top + ")");

     var xAxis = d3.axisBottom(x)
       .tickFormat(d3.timeFormat("%Y-%m-%d"));

     var url = "https://gist.githubusercontent.com/d3noob/402dd382a51a4f6eea487f9a35566de0/raw/6369502941b44261f381399a24fb455cb4290be8/data.csv";
     d3.csv(url, function(error, data) {
       if (error) throw error;

       data.forEach(function(d) {
           d.date = parseTime(d.date);
           d.close = +d.close;
       });

       x.domain(d3.extent(data, function(d) { return d.date; }));
       y.domain([0, d3.max(data, function(d) { return d.close; })]);

       svg.append("path")
           .data([data])
           .attr("class", "line")
           .attr("d", valueline);

       svg.append("g")
           .attr("transform", "translate(0," + height + ")")
           .call(xAxis)
           .selectAll("text")
             .style("text-anchor", "end")
             .attr("dx", "-.8em")
             .attr("dy", ".15em")
             .attr("transform", function(d) {
                 return "rotate(-40)"
                 });

       svg.append("g")
           .call(d3.axisLeft(y));
     });
   </script>

