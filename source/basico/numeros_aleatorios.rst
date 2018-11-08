.. _d3-random-section:

***********************************
Números aleatorios --- `d3-random`_
***********************************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>


Generadores de números aleatorios
=================================

`d3.randomUniform([min, ][max])`_
---------------------------------

Devuelve una función generadora de números aleatorios con una `distribución continua <https://es.wikipedia.org/wiki/Distribuci%C3%B3n_uniforme_continua>`__. El valor mínimo del número devuelto será ``min`` (``0`` si no se especifica) y el máximo ``max`` (``1`` si no se especifica).

.. code-block:: js

   // Compilamos la función generadora
   var uniform = d3.randomUniform(1, 10);
   // y la ejecutamos.
   uniform();  // 5.2935108488665366

   // Compilamos y ejecutamos la función generadora
   var num = d3.randomUniform(1, 10)();


`d3.randomNormal([mu][, sigma])`_
---------------------------------

Devuelve una función generadora de números aleatorios con una `distribución normal o gaussiana <https://es.wikipedia.org/wiki/Distribuci%C3%B3n_normal>`__. El valor esperado de los números generados es ``mu`` (``0`` si no se especifica), con la desviación estandar dada por el parámetro ``sigma`` (``1`` si no se especifica).

.. code-block:: js

   d3.randomNormal(4, 2)();  // 3.2048540025245473

.. raw:: html

   <script>
     console.log(d3.randomNormal(4, 2)());
   </script>

.. _d3-random: https://github.com/d3/d3-random
.. _d3.randomUniform([min, ][max]): https://github.com/d3/d3-random#randomUniform
.. _d3.randomNormal([mu][, sigma]): https://github.com/d3/d3-random#randomNormal