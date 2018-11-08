**********************
Gráficos de dispersión
**********************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>
   <script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>


Iris dataset
============

En este ejemplo hemos usado la escala de colores `d3.schemeDark2`_, por lo que hemos de cargar el módulo `d3-scale-chromatic`_ con:

.. code-block:: html

   <script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>

.. rubric:: Input

.. code-block:: html

   <div id="scatterplot-graph-1"></div>
   <script>
     var margin = {top: 30, right: 50, bottom: 40, left: 40};
     var width = 680 - margin.left - margin.right;
     var height = 450 - margin.top - margin.bottom;

     var svg = d3.select("#scatterplot-graph-1").append("svg")
         .attr("width", width + margin.left + margin.right)
         .attr("height", height + margin.top + margin.bottom)
       .append("g")
         .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

     var xScale = d3.scaleLinear().range([0, width]);
     var yScale = d3.scaleLinear().range([height, 0]);

     var xAxis = d3.axisBottom().scale(xScale);
     var yAxis = d3.axisLeft().scale(yScale);

     var color = d3.scaleOrdinal(d3.schemeDark2);

     var url = "https://gist.githubusercontent.com/Jverma/076377dd0125b1a508621441752735fc/raw/b3c1e1bdafd135d6cd01f5a4b53f1bd347dacd03/iris.csv";

     d3.csv(url, function(error, data){
         xScale.domain(d3.extent(data, function(d){
             return d.SepalLength;
         })).nice();

         yScale.domain(d3.extent(data, function(d){
             return d.SepalWidth;
         })).nice();

         svg.append("g")
             .attr("transform", "translate(0," + height + ")")
             .call(xAxis);

         svg.append("g")
             .attr("transform", "translate(0,0)")
             .call(yAxis);

         var bubble = svg.selectAll(".bubble")
             .data(data)
             .enter().append("circle")
             .attr("cx", function(d){ return xScale(d.SepalLength); })
             .attr("cy", function(d){ return yScale(d.SepalWidth); })
             .attr("r", "3px")
             .style("fill", function(d){ return color(d.Name); });
     });
   </script>

.. rubric:: Output

.. raw:: html

   <div id="scatterplot-graph-1"></div>
   <script>
     var margin = {top: 30, right: 50, bottom: 40, left: 40};
     var width = 680 - margin.left - margin.right;
     var height = 450 - margin.top - margin.bottom;

     var svg = d3.select("#scatterplot-graph-1").append("svg")
         .attr("width", width + margin.left + margin.right)
         .attr("height", height + margin.top + margin.bottom)
       .append("g")
         .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

     var xScale = d3.scaleLinear().range([0, width]);
     var yScale = d3.scaleLinear().range([height, 0]);

     var xAxis = d3.axisBottom().scale(xScale);
     var yAxis = d3.axisLeft().scale(yScale);

     var color = d3.scaleOrdinal(d3.schemeDark2);

     var url = "https://gist.githubusercontent.com/Jverma/076377dd0125b1a508621441752735fc/raw/b3c1e1bdafd135d6cd01f5a4b53f1bd347dacd03/iris.csv";

     d3.csv(url, function(error, data){
         xScale.domain(d3.extent(data, function(d){
             return d.SepalLength;
         })).nice();

         yScale.domain(d3.extent(data, function(d){
             return d.SepalWidth;
         })).nice();

         svg.append("g")
             .attr("transform", "translate(0," + height + ")")
             .call(xAxis);

         svg.append("g")
             .attr("transform", "translate(0,0)")
             .call(yAxis);

         var bubble = svg.selectAll(".bubble")
             .data(data)
             .enter().append("circle")
             .attr("cx", function(d){ return xScale(d.SepalLength); })
             .attr("cy", function(d){ return yScale(d.SepalWidth); })
             .attr("r", "3px")
             .style("fill", function(d){ return color(d.Name); });
     });
   </script>


.. _d3.schemeDark2: https://github.com/d3/d3-scale-chromatic#schemeDark2
.. _d3-scale-chromatic: https://github.com/d3/d3-scale-chromatic
