***********
Animaciones
***********

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>


Transiciones -- `d3-transition`_
================================

Para crear transiciones usamos la función `selection.transition()`_ sobre una selección. 

.. rubric:: Input

.. code-block:: html

   <style>
     #contenedor1 {
       height: 100px;
       width: 600px;
       margin: 12px auto;
       background-color: gold;
     }
   </style>

   <div id="contenedor1"></div>

   <script>
     d3.select("#contenedor1")
       .transition()     // Creamos una transición
       .duration(3000)   // - Tiempo que tardará
       .delay(2000)      // - Tiempo en espera antes de activar la transición
         .style("background-color", "navy");
   </script>

.. rubric:: Output

.. raw:: html

   <style>
     #contenedor1 {
       height: 100px;
       width: 600px;
       margin: 12px auto;
       background-color: gold;
     }
   </style>

   <div id="contenedor1"></div>

   <script>
     d3.select("#contenedor1")
       .transition()
       .duration(3000)
       .delay(2000)
         .style("background-color", "navy");
   </script>
   <br><br>


Desenvoltura de transiciones -- `d3-ease`_
====================================================

Podemos definir como se comportan las transiciones mediante diferentes funciones que flexibilizan el movimiento de transición. Simplemente la aplicamos mediante la función `transition.ease()`_ a una transición (por defecto `easeCubicInOut()`_).

.. raw:: html

   <center><h5><a style="color:firebrick;" href="https://bl.ocks.org/d3noob/1ea51d03775b9650e8dfd03474e202fe">Comparación entre diferentes funciones de transición</a></h5></center>
   <center><h5><a style="color:green;" href="https://bl.ocks.org/mbostock/248bac3b8e354a9103c4">Explorador de funciones de transición</a></h5></center>

Los nombres de las diferentes funciones se pueden observar en el explorador de funciones, además de en la documentación  de `d3-ease`_.

.. rubric:: Input

.. code-block:: html

   <style>
     #contenedor2 {
       height: 100px;
       width: 600px;
       margin: 12px auto;
       background-color: dodgerblue;
     }
   </style>
   <div id="contenedor2"></div>

   <script>
     d3.select("#contenedor2")
        .transition()
        .duration(4000)
        .delay(4000)
        .ease(d3.easeElasticOut)   // Indicamos la función de transición flexible
          .style("width", "200px");
   </script>

.. rubric:: Output

.. raw:: html

   <style>
     #contenedor2 {
       height: 100px;
       width: 600px;
       margin: 12px auto;
       background-color: dodgerblue;
     }
   </style>
   <div id="contenedor2"></div>

   <script>
     d3.select("#contenedor2")
        .transition()
        .duration(4000)
        .delay(4000)
        .ease(d3.easeElasticOut)
          .style("width", "200px");
   </script>
   <br><br>

.. _d3-transition: https://github.com/d3/d3-transition
.. _selection.transition(): https://github.com/d3/d3-transition#selection_transition
.. _d3-ease: https://github.com/d3/d3-ease
.. _transition.ease(): https://github.com/d3/d3-ease#_ease
.. _easeCubicInOut(): https://github.com/d3/d3-ease#easeCubicInOut