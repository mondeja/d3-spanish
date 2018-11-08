******************
Gráficos de barras
******************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>

Diferencias entre un gráfico mediante ``div`` y ``svg``
-------------------------------------------------------

En los siguientes dos ejemplos vamos a realizar el mismo gráfico de dos formas diferentes: la primera añadiendo dinámicamente elementos ``div`` a un contenedor padre y la segunda mediante elementos ``svg``.

El código común a ambos ejemplos es:

.. raw:: html

   <script>
     var margin = {top: 20, right: 20, bottom: 20, left: 20},
         width = 680 - margin.right - margin.left,
         height = 680 - margin.top - margin.bottom;

     var data = [
         {coin: "BTC", value: 10000},
         {coin: "LTC", value: 5000},
         {coin: "ETH", value: 3000},
         {coin: "XMR", value: 1500},
         {coin: "BCH", value: 1000},
         {coin: "BTZ", value: 400}
     ]

     scaleX = d3.scaleLinear()
       .domain([0, d3.max(data, function(d){ return d.value })])
       .range([0, width - margin.right - margin.left])
   </script>

.. code-block:: js

   var margin = {top: 20, right: 20, bottom: 20, left: 20},
       width = 680 - margin.right - margin.left,
       height = 680 - margin.top - margin.bottom;

   var data = [
       {coin: "BTC", value: 10000},
       {coin: "LTC", value: 5000},
       {coin: "ETH", value: 3000},
       {coin: "XMR", value: 1500},
       {coin: "BCH", value: 1000},
       {coin: "BTZ", value: 400}
   ]

   scaleX = d3.scaleLinear()
     .domain([0, d3.max(data, function(d){ return d.value })])
     .range([0, width - margin.right - margin.left])

Mediante elementos ``div``
~~~~~~~~~~~~~~~~~~~~~~~~~~

A continuación puedes observar un ejemplo simple de creación de un gráfico de barras añadiendo contenedores dentro de otro contenedor.

.. rubric:: Input

.. code-block:: html

   <style>
     #chart-1 div {
       font: 10px sans-serif;
       background-color: steelblue;
       text-align: right;
       padding: 3px;
       margin: 1px;
       color: white;
     }
   </style>
   <div id="chart-1" style="margin-bottom:50px;"></div>
   <script>
     d3.select("#chart-1")
       .selectAll("div")
         .data(data)
       .enter().append("div")
         .style("width", 0)
         .text(function(d) { return d.value })
       .transition().duration(3000)
         .style("width", function(d){ return scaleX(d.value) + "px" });

   </script>

.. rubric:: Output

.. raw:: html

   <style>
     #chart-1 div {
       font: 10px sans-serif;
       background-color: steelblue;
       text-align: right;
       padding: 3px;
       margin: 1px;
       color: white;
     }
   </style>
   <div id="chart-1" style="margin-bottom:50px;"></div>
   <script>
     d3.select("#chart-1")
       .selectAll("div")
         .data(data)
       .enter().append("div")
         .style("width", 0)
         .text(function(d) { return d.value })
       .transition().duration(3000)
         .style("width", function(d){ return scaleX(d.value) + "px" });
   </script>


Mediante elementos SVG
~~~~~~~~~~~~~~~~~~~~~~

El movimiento de las barras es más fluido y el gráfico tarda menos en cargar si lo realizamos mediante SVG.

.. rubric:: Input

.. code-block:: html

   <style>
     #chart-2 rect {
       fill: steelblue;
     }

     #chart-2 text {
       fill: white;
       font: 10px sans-serif;
       text-anchor: end;
     }
   </style>

   <svg id="chart-2" style="margin-bottom:30px;"></div>

   <script>
     var barHeight = 20;

     var chart = d3.select("#chart-2")
       .attr("width", width)
       .attr("height", barHeight * data.lenght);

     var bar = chart.selectAll("g")
       .data(data)
       .enter().append("g")
       .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

     bar.append("rect")
         .attr("width", 0)
       .transition().duration(2000)
         .attr("width", function(d){ return scaleX(d.value) + "px"; })
         .attr("height", barHeight-1);

     bar.append("text")
         .attr("x", 0)
       .transition().duration(2000)
         .attr("x", function(d) { return scaleX(d.value) - 3; })
         .attr("y", barHeight / 2)
         .attr("dy", ".35em")
         .text(function(d) { return d.value; });
   </script>


.. rubric:: Output

.. raw:: html

   <style>
     #chart-2 rect {
       fill: steelblue;
     }

     #chart-2 text {
       fill: white;
       font: 10px sans-serif;
       text-anchor: end;
     }
   </style>

   <svg id="chart-2" style="margin-bottom:30px;"></div>

   <script>
     var barHeight = 20;

     var chart = d3.select("#chart-2")
       .attr("width", width)
       .attr("height", barHeight * data.length);

     var bar = chart.selectAll("g")
       .data(data)
       .enter().append("g")
       .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

     bar.append("rect")
         .attr("width", 0)
       .transition().duration(2000)
         .attr("width", function(d){ return scaleX(d.value) + "px"; })
         .attr("height", barHeight-1);

     bar.append("text")
         .attr("x", 0)
       .transition().duration(2000)
         .attr("x", function(d) { return scaleX(d.value) - 3; })
         .attr("y", barHeight / 2)
         .attr("dy", ".35em")
         .text(function(d) { return d.value; });
   </script>



Gráfico de barras con datos reales
==================================


.. rubric:: Input

.. code-block:: html

   <style>
     #chart-3 rect {
       fill: teal;
     }

     #chart-3 text {
       fill: teal;
       font: 10px sans-serif;
       text-anchor: end;
     }
   </style>

   <svg id="chart-3"></svg>

   <script>
     var limit = 20;
     var url = "https://api.coinmarketcap.com/v2/ticker/?limit=" + limit;

     var barHeight = 20;

     d3.json(url, function(error, res) {
       if (error) { throw error }

       var data = [];
       for (var id in res["data"]) {
         data.push({
           symbol: res["data"][id]["symbol"],
           value: res["data"][id]["quotes"]["USD"]["price"]
         })
       }

       scaleX = d3.scaleLinear()
         .domain([0, d3.max(data, function(d){ return d.value + 2000; })])
         .range([0, width])

       var chart = d3.select("#chart-3")
         .attr("width", width)
         .attr("height", barHeight * data.length);

       var bar = chart.selectAll("g")
           .data(data)
         .enter().append("g")
           .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

       bar.append("rect")
           .attr("width", function(d){ return scaleX(d.value) + "px"; })
           .attr("height", barHeight-1);

       bar.append("text")
         .attr("x", function(d) { return (scaleX(d.value) + 105) + "px"; })
         .attr("y", barHeight / 2)
         .attr("dy", ".35em")
         .text(function(d) { return  d.symbol + " --- " + d.value + " $"; });

     });
   </script>


.. rubric:: Output

.. raw:: html

   <style>
     #chart-3 rect {
       fill: teal;
       position: absolute:
       right: 200px;
     }

     #chart-3 text {
       fill: teal;
       font: 10px sans-serif;
       text-anchor: end;
     }
   </style>

   <svg id="chart-3"></svg>

   <script>
     var limit = 20;
     var url = "https://api.coinmarketcap.com/v2/ticker/?limit=" + limit;

     var barHeight = 20;

     d3.json(url, function(error, res) {
       if (error) { throw error }

       var data = [];
       for (var id in res["data"]) {
         data.push({
           symbol: res["data"][id]["symbol"],
           value: res["data"][id]["quotes"]["USD"]["price"]
         })
       }

       scaleX = d3.scaleLinear()
         .domain([0, d3.max(data, function(d){ return d.value + 2000; })])
         .range([0, width])

       var chart = d3.select("#chart-3")
         .attr("width", width)
         .attr("height", barHeight * data.length);

       var bar = chart.selectAll("g")
           .data(data)
         .enter().append("g")
           .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

       bar.append("rect")
           .attr("width", function(d){ return scaleX(d.value) + "px"; })
           .attr("height", barHeight-1);

       bar.append("text")
         .attr("x", function(d) { return (scaleX(d.value) + 105) + "px"; })
         .attr("y", barHeight / 2)
         .attr("dy", ".35em")
         .text(function(d) { return  d.symbol + " --- " + d.value + " $"; });

     });
   </script>
