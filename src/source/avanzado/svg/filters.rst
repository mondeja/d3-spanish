***********
Filtros SVG
***********



Básico
======

Para crear un filtro con SVG debemos crear un elemento ``defs`` donde definimos todos los filtros que más tarde podemos aplicar a los elementos referenciándolos. Dentro de estas etiquetas, creamos filtros con la etiqueta ``filter`` a la cual es importante otorgar un identificador para luego poder referenciarlos.

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>


El siguiente código es común a todos los ejemplos:

.. code-block:: js

   var margin = {top: 30, right: 20, bottom: 20, left: 20},
       width = 680 - margin.left - margin.right,
       height = 400 - margin.top - margin.bottom;

   function createSVG(id){
       return d3.select(id)
         .attr("height", height + margin.left + margin.right)
         .attr("width", width + margin.bottom + margin.top);
   }

   function appendCircleToSVG(svg, cx, cy, r, fill){
       return svg.append("circle")
         .attr("cx", cx)
         .attr("cy", cy)
         .attr("r", r)
         .attr("fill", fill);
   }


.. raw:: html

   <script>
     var margin = {top: 30, right: 20, bottom: 20, left: 20},
       width = 680 - margin.left - margin.right,
       height = 400 - margin.top - margin.bottom;

     function sizeSVG(id){
         return d3.select(id)
           .attr("height", height + margin.left + margin.right)
           .attr("width", width + margin.bottom + margin.top);
     }

     function appendCircleToSVG(svg, cx, cy, r, fill){
         return svg.append("circle")
           .attr("cx", cx)
           .attr("cy", cy)
           .attr("r", r)
           .attr("fill", fill);
     }
   </script>

Filtros de movimiento
=====================

`feOffset`_ - Desplazar elementos
---------------------------------

El efecto `feOffset`_ nos permite desplazar el elemento a través de la imagen, lo que lo hace perfecto, combinado con un filtro de distorsión como el gaussiano, para crear sombras.


Ejemplo básico
~~~~~~~~~~~~~~

En el siguiente ejemplo ambos círculos se encuentran originalmente en la misma posición pero el azul ha sido movido ``200px`` hacia la derecha por un filtro `feOffset`_. Observa que el filtro sólo actuará en la zona de incluencia definida por sus atributos ``width`` and ``height``.

.. rubric:: Input

.. code-block:: html

   <svg width="100%" height="200">
     <defs>
       <filter id="uno" width="300%" height="120%">
         <feOffset dx="100" dy="0">
       </filter>
     </defs>

     <circle cx="100" cy="100" r="75" fill="navy" filter="url(#uno)"></circle>
     <circle cx="100" cy="100" r="75" fill="teal"></circle>
   </svg>

.. rubric:: Output

.. raw:: html

   <svg width="100%" height="200">
     <defs>
       <filter id="offset-filter-1" width="300%" height="120%">
         <feOffset dx="200" dy="0">
       </filter>
     </defs>

     <circle cx="100" cy="100" r="75" fill="navy" filter="url(#offset-filter-1)"></circle>
     <circle cx="100" cy="100" r="75" fill="teal"></circle>
   </svg>

.. rubric:: Input- Versión D3

.. code-block:: html

   <div id="container-offset-1"></div>
   <script>
     var svg = d3.select("#container-offset-1")
         .append("svg")
       .attr("width", "100%")
       .attr("height", 200);

     var defs = svg.append("defs");

     var filter_id = "offset-filter-2"
     var filter = defs.append("filter")
       .attr("width", "300%")
       .attr("height", "120%")
       .attr("id", filter_id)
         .append("feOffset")
       .attr("dx", 200)
       .attr("dy", 0)
       .attr("in", "SourceGraphic")

    var circleNavy = svg.append("circle")
      .attr("cx", 100)
      .attr("cy", 100)
      .attr("r", 75)
      .attr("fill", "navy")
      .attr("filter", "url(#" + filter_id + ")");

    var circleTeal = svg.append("circle")
      .attr("cx", 100)
      .attr("cy", 100)
      .attr("r", 75)
      .attr("fill", "teal");
   </script>

.. note::

   No tiene mucho sentido usar este filtro en solitario ya que podríamos conseguir el mismo efecto cambiando la posición, más adelante hay otros ejemplos en conjunción con otros filtros.


Filtros de distorsión
=====================

`feGaussianBlur`_ - Desenfoque gaussiano
----------------------------------------

Este filtro desenfoca el elemento al que se aplica dependiendo del valor especificado en el atributo ``stdDeviation``.

.. rubric:: Input

.. code-block:: html

   <svg width="100%" height="200">
     <defs>
       <filter id="gaussian-blur-filter-1" width="200%" height="120%">
         <feGaussianBlur stdDeviation="5">
       </filter>
     </defs>

     <rect x="200" y="50" width="100" height="100" fill="indianred" filter="url(#gaussian-blur-filter-1)"></rect>
     <rect x="50" y="50" width="100" height="100" fill="indianred"></rect>
   </svg>

.. rubric:: Output

.. raw:: html

   <svg width="100%" height="200">
     <defs>
       <filter id="gaussian-blur-filter-1" width="200%" height="120%">
         <feGaussianBlur stdDeviation="5">
       </filter>
     </defs>

     <rect x="200" y="50" width="100" height="100" fill="indianred" filter="url(#gaussian-blur-filter-1)"></rect>
     <rect x="50" y="50" width="100" height="100" fill="indianred"></rect>
   </svg>

.. rubric:: Input - Version D3

.. code-block:: html

   <div id="container-gaussian-blur-1"></div>
   <script>
     var svg = d3.select("#container-gaussian-blur-1")
         .append("svg")
       .attr("width", "100%")
       .attr("height", 200);

     var defs = svg.append("defs");

     var filter_id = "gaussian-blur-filter-1";
     var filter = svg.append("filter")
       .attr("id", filter_id)
       .attr("width", "200%")
       .attr("height", "120%");

     var rectBlurred = svg.append("rect")
       .attr("x", 200)
       .attr("y", 50)
       .attr("width", 100)
       .attr("height", 100)
       .attr("fill", "indianred")
       .attr("filter", "url(#" + filter_id + ")");

     var rectNotBlurred = svg.append("rect")
       .attr("x", 50)
       .attr("y", 50)
       .attr("width", 100)
       .attr("height", 100)
       .attr("fill", "indianred");
   </script>


Filtros de transformación
=========================


Dilatación y adelgazamiento
---------------------------


.. code-block:: html

   <style>
     #erode-dilate-container-1 p {
       margin: 0;
       font-family: Arial, Helvetica, sans-serif;
       font-size: 3em;
       height: 60px;
     }

     #thin {
       filter: url(#erode);
     }

     #thick {
       filter: url(#dilate);
     }
   </style>

   <svg xmlns="http://www.w3.org/2000/svg" width="0" height="0">
     <filter id="erode">
       <feMorphology operator="erode" radius="1"/>
     </filter>
     <filter id="dilate">
       <feMorphology operator="dilate" radius="2"/>
     </filter>
   </svg>

   <div id="erode-dilate-container-1">
     <p>Texto normal</p>
     <p id="thin">Texto adelgazado</p>
     <p id="thick">Texto engordado</p>
   </div>


.. raw:: html

   <style>
     #erode-dilate-container-1 p {
       margin: 0;
       font-family: Arial, Helvetica, sans-serif;
       font-size: 3em;
       height: 60px;
     }

     #thin {
       filter: url(#erode);
     }

     #thick {
       filter: url(#dilate);
     }
   </style>

   <svg xmlns="http://www.w3.org/2000/svg" width="0" height="0">
     <filter id="erode">
       <feMorphology operator="erode" radius="1"/>
     </filter>
     <filter id="dilate">
       <feMorphology operator="dilate" radius="2"/>
     </filter>
   </svg>

   <div id="erode-dilate-container-1">
     <p>Texto normal</p>
     <p id="thin">Texto adelgazado</p>
     <p id="thick">Texto engordado</p>
   </div>
   <br>


Clip paths
==========

"Clip" significa recortar por lo que son los elementos ``clipPath`` de SVG podemos recortar elementos. La estructura básica para añadir este elemento es la siguiente:

.. code-block:: html

   <svg>
     <defs>
       <clipPath id="myClippingPath">
         <!-- ... -->
       </clipPath>
     </defs>

    <!-- El elemento al que quieras aplicarlo, puede ser cualquiera -->
     <g id="my-graphic" clip-path="url(#myClippingPath)">
        <!-- ... -->
     </g>
   </svg>

Ejemplo con D3
--------------

.. rubric:: Input

.. code-block:: html

   <div id="container-clippath-1"></div>
   <script>

     var width = 680,
         height = 200;

     var svg = d3.select("#container-clippath-1").append("svg")
         .attr("width", width)
         .attr("height", height);

     var circle_clip = svg.append("clipPath")
         .attr("id", "ellipse-clip")
       .append("circle")
         .attr("cx", width/2)
         .attr("cy", height/2)
         .attr("r", 100);

     var rect = svg.append("rect")
         .attr("x", width/3)
         .attr("y", height/2.9)
       .attr("clip-path", "url(#ellipse-clip)")
         .attr("fill","crimson")
         .attr("height",100)
         .attr("width",200)
         .style("stroke", "royalblue")
         .style("stroke-width", "3.5px");
   </script>

.. rubric:: Output

.. raw:: html

   <div id="container-clippath-1"></div>
   <script>

     var width = 680,
         height = 200;

     var svg = d3.select("#container-clippath-1").append("svg")
         .attr("width", width)
         .attr("height", height);

     var circle_clip = svg.append("clipPath")
         .attr("id", "ellipse-clip")
       .append("circle")
         .attr("cx", width/2)
         .attr("cy", height/2)
         .attr("r", 100);

     var rect = svg.append("rect")
         .attr("x", width/3)
         .attr("y", height/2.9)
       .attr("clip-path", "url(#ellipse-clip)")
         .attr("fill","crimson")
         .attr("height",100)
         .attr("width",200)
         .style("stroke", "royalblue")
         .style("stroke-width", "3.5px");
   </script>

.. rubric:: Paso a paso


#. Creamos un path mediante figuras, generadores de paths, rutas escritas manualmente... lo que sea, añadiendo un elemento ``clipPath`` a un ``svg``. Le establecemos un identificador.
#. Añadimos a otro elemento que queremos recortar el atributo ``clip-path`` apuntando al identificador del ``clipPath`` (en D3 ``.attr("clip-path", "url(#identificador-del-clip)"))``).





.. _feOffset: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feOffset
.. _feGaussianBlur: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feGaussianBlur
.. _feMorphology: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feMorphology
