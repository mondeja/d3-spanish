.. _mapas-section:

*******************
Mapas --- `d3-geo`_
*******************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>

Para generar mapas en D3 seguimos los siguientes pasos:

Generamos un objeto ``path`` con la función `d3.geoPath()`_ añadiéndole una `proyección de las tantas existentes <https://github.com/d3/d3-geo#path_projection>`__  en `d3-geo`_. Un ejemplo sería:

.. code-block:: js

   var path = d3.geoPath().projection(geoAzimuthalEquidistant());

O también:

.. code-block:: js

  var projection = geoAzimuthalEquidistant(),
      path = d3.geoPath(projection);


Podemos optar por renderizar el mapa con ``svg`` o con ``canvas``, vamos a explorar ambas opciones.

SVG
===

Obtenemos el elemento ``svg`` donde queremos representar el mapa. A este le añadimos los datos con `data()`_ o `datum()`_ y mediante el atributo ``"d"`` insertamos el ``path`` que hemos creado anteriormente:

..  code-block:: html

   <svg width="100%" height="500" id="example_map"></svg>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>
   <script src="https://unpkg.com/topojson-client@3"></script>

   <script>
     var url = "https://unpkg.com/world-atlas@1.1.4/world/110m.json";
     d3.json(url, function(error, world){
         if (error) throw error;

         var svg = d3.select("#example_map")
           .datum(topojson.feature(world, world.objects.land))
           .attr("d", path);
     })
   </script>

.. note::

   Lee `este artículo <https://gist.github.com/hugolpz/824446bb2f9bc8cce607>`__ para entender la diferencia entre `data()`_ o `datum()`_.


.. rubric:: Input

.. code-block:: html

   <style>
   #map-1 {
     background-color: skyblue;
   }
   .province {
     fill: royalblue;
     stroke: #FFF;
     stroke-width: .5px;
     stroke-dasharray: 3 3;
   }

   .province:hover {
     fill: crimson;
     stroke: orange;
     stroke-width: 2px;
     stroke-dasharray: none;

   }

   .graticule {
     fill: none;
     stroke: #FFF;
     stroke-width: .6px;
     stroke-opacity: 0.5;
   }
   </style>

   <svg id="map-1" width="748" height="500"></svg>

   <script>
     var svg = d3.select("#map-1"),
         width = +svg.attr("width"),
         height = +svg.attr("height");

     // Creamos la proyección  (ver Proyecciones abajo)
     var projection = d3.geoMercator()
       .scale(2200)
       .center([0, 40])
       .translate([width / 1.7, height / 2]);
       //.translate([350, 200]);         // Otros atributos
       //.rotate([122.4194, -37.7749])
       //.clipAngle(180 - 1e-3)
       //.precision(0.1);

     // Creamos el path añadiendo la proyección
     var path = d3.geoPath(projection),

     // Creamos una rejilla que se repita cada 2 grados tanto
     //   en direcciones norte-sur como este-oeste
     var graticule = d3.geoGraticule().step([2, 2]);

     // Añadimos la rejilla
     svg.append("path")
         .datum(graticule)
         .attr("class", "graticule")
         .attr("d", path);

     // Obtenemos las provincias de España en formato geojson
     var url = "https://raw.githubusercontent.com/codeforamerica/click_that_hood/master/public/data/spain-provinces.geojson";
     d3.json(url, function(error, spain){
         if (error) throw error;  // Manejamos cualquier posible error

         var group = svg.selectAll("g")  // Creamos un grupo para cada provincia
             .data(spain.features)
             .enter()
             .append("g");

         // Para cada grupo añadimos el path correspondiente
         var areas = group.append("path")
             .attr("d", path)
             .attr("class", "province");

     });
   </script>

.. rubric:: Output

.. raw:: html

   <style>
   #map-1 {
     background-color: skyblue;
   }
   .province {
     fill: royalblue;
     stroke: #FFF;
     stroke-width: .5px;
     stroke-dasharray: 3 3;
   }

   .province:hover {
     fill: crimson;
     stroke: orange;
     stroke-width: 2px;
     stroke-dasharray: none;

   }

   .graticule {
     fill: none;
     stroke: #FFF;
     stroke-width: .6px;
     stroke-opacity: 0.5;
   }
   </style>

   <svg id="map-1" width="748" height="500"></svg>
   <br>

   <script>
     var svg = d3.select("#map-1"),
         width = +svg.attr("width"),
         height = +svg.attr("height");

     console.log(width);
     var projection = d3.geoMercator()
       .scale(2200)
       .center([0, 40])
       .translate([width / 1.7, height / 2]);

     var path = d3.geoPath(projection),
         graticule = d3.geoGraticule().step([2, 2]);

     svg.append("path")
         .datum(graticule)
         .attr("class", "graticule")
         .attr("d", path);

     var url = "https://raw.githubusercontent.com/codeforamerica/click_that_hood/master/public/data/spain-provinces.geojson";
     d3.json(url, function(error, spain){
          var group = svg.selectAll("g")
             .data(spain.features)
             .enter()
             .append("g");

         var areas = group.append("path")
             .attr("d", path)
             .attr("class", "province");

     });
   </script>

Como puedes observar en este ejemplo, básicamente son 6 pasos.

#. Crear una proyección (ver :ref:`proyecciones`).
#. Crear un ``path`` con la función `d3.geoPath()`_ y añadirle la proyección.
#. [Opcional] Crear una rejilla con la función `d3.geoGraticule()`_. Añadir un elemento ``path`` al svg, enlazar los datos de la cuadrícula con la función `datum()`_ y añadir el ``path`` del paso anterior al atributo ``d``.
#. Obtener los datos geográficos del mapa.
#. Enlazar los datos al contenedor ``svg`` por medio de grupos.
#. Añadir a cada grupo un elemento ``path``, cuyo atributo ``d`` será el path que hemos creado en el paso 2.


Canvas
======

Para crear un mapa usando elementos ``canvas`` habría que escribir algo como esto:

.. rubric:: Input

.. code-block:: html

   <canvas width="680" width="480"></canvas>

   <script src="https://unpkg.com/topojson-client@3"></script>
   <script>

     var context = d3.select("canvas").node().getContext("2d");

     var projection = d3.geoMercator()
       .scale(2200)
       .center([0, 40])
       .translate([width / 1.7, height / 2]);

     var path = d3.geoPath(projection).context(context);

     var url = "https://raw.githubusercontent.com/codeforamerica/click_that_hood/master/public/data/spain-provinces.geojson";
     d3.json(url, function(error, spain) {
         if (error) throw error;

         // Comenzamos a dibujar en el lienzo
         context.beginPath();

         // Añadimos el path con los datos del archivo .json
         path(topojson.mesh(spain));

         // Dibujamos el contenido
         context.stroke();
     });

   </script>


.. rubric:: Output

.. raw:: html

   <canvas id="map-2" width="680" height="480"></canvas>

   <script src="https://unpkg.com/topojson-client@3"></script>
   <script>

     var context = d3.select("#map-2").node().getContext("2d");

     var projection = d3.geoMercator()
       .scale(2200)
       .center([0, 40])
       .translate([width / 1.7, height / 2]);

     var path = d3.geoPath(projection).context(context);

     var url = "https://raw.githubusercontent.com/deldersveld/topojson/master/countries/spain/spain-comunidad.json";

     d3.json(url, function(error, spain) {
         if (error) throw error;

         context.beginPath();
         path(topojson.mesh(spain));
         context.stroke();
     });

   </script>

En este ejemplo, mucho más simple, hemos usado `topojson`_ para cargar los datos del archivo en json e insetarlos en el canvas.

.. seealso::

   - `context.beginPath() <https://www.w3schools.com/tags/canvas_beginpath.asp>`__
   - `context.stroke() <https://www.w3schools.com/tags/canvas_stroke.asp>`__
   - `topojson.mesh(topology [, object[, filter]]) <https://github.com/topojson/topojson-client/blob/master/README.md#mesh>`__


.. _proyecciones:

Proyecciones
============

D3 provee muchas proyecciones dentro de los módulos `d3-geo`_ y `d3-geo-projection`_. Cada proyección puede ser controlada mediante métodos.

Métodos
~~~~~~~

- `projection.scale([scale])`_: El factor de escalado corresponde linealmente a la distancia entre los puntos projectados; sin embargo, mismos factores de escalado no son equivalentes entre diferentes proyecciones.
- `projection.center([center])`_: Array de dos elementos con las coordenadas longitud y latitud en grados (por defecto ``[0, 0]``).
- `projection.translate([translate])`_: si se especifica el parámetro ``translate``, el la proyección será trasladada en los ejes ``[x, y]`` según los valores introducidos (por defecto ``[480, 250]``).
- `projection.rotate([angles])`_: Si él parámetro ``angles`` es introducido, establece la rotación esférica sobre los tres ejes a los ángulos especificado, el cual debe ser un array de dos ó tres números ``[lambda, phi, gamma]`` , especificando los ángulos de rotación en grados sobre cada eje esférico (por defecto ``[0, 0, 0]``.


Rejillas
========

`d3.geoGraticule()`_
--------------------

Con esta función creamos una rejilla. Para añadir una rejilla simplemente hemos de insertarla en el contenedor ``svg`` con la función `datum()`_:

.. code-block:: js

   var graticule = d3.geoGraticule().step([2, 2]);

   svg.append("path")
       .datum(graticule)
       .attr("d", path);

Métodos
~~~~~~~

- `graticule.step([step])`_: Acepta un array de dos números que indican los grados de distancia entre cada filamento de la rejilla. El primero indica diferencia entre longitudes y el segundo latitudes.

.. _d3-geo: https://github.com/d3/d3-geo
.. _d3.geoPath(): https://github.com/d3/d3-geo#geoPath
.. _data(): https://github.com/d3/d3-selection/blob/master/README.md#selection_data
.. _datum(): https://github.com/d3/d3-selection/blob/master/README.md#selection_datum
.. _topojson: https://github.com/topojson/topojson
.. _d3-geo-projection: https://github.com/d3/d3-geo-projection
.. _d3.geoGraticule(): https://github.com/d3/d3-geo#geoGraticule
.. _projection.scale([scale]): https://github.com/d3/d3-geo#projection_scale
.. _projection.center([center]): https://github.com/d3/d3-geo#projection_center
.. _projection.translate([translate]): https://github.com/d3/d3-geo#projection_translate
.. _projection.rotate([angles]): https://github.com/d3/d3-geo#projection_rotate
.. _graticule.step([step]): https://github.com/d3/d3-geo#graticule_step