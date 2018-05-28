.. _d3-scale-section:

***********************
Escalas --- `d3-scale`_
***********************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>

Las escalas son abstracciones que nos permiten representar una dimensión de datos abstractos en una representación visual. Pueden representar cualquier codificación visual, tales como divergencia de colores, anchos de trazo o tamaños de símbolos. Dependendiendo del tipo de datos que queramos representar debemos elegir un tipo de escala adecuado.

Las escalas se componen de dos elementos principales: **dominios** y **rangos**.

Dominios y rangos
=================

Las escalas mapean un dominio de entrada a un rango de salida. Por lo tanto, las funciones de escala toman un intervalo y lo transforman en otro.


.. code-block:: js

   var x = d3.scaleLinear()
       .domain([10, 130])
       .range([0, 960]);

   // Obtener un valor del rango de su equivalente del dominio
   console.log(x(20));   // 80
   console.log(x(5));    // -40

   // Obtener un valor del dominio de su equivalente del rango
   console.log(x.invert(960));  // 130


Como puedes ver en el ejemplo anterior, el dominio se ha establecido entre ``10`` y ``130`` y el rango entre ``0`` y ``960``. Para obtener el valor del rango que equivale a un cierto valor del dominio llamamos a la escala como función pasándole el valor del dominio del cual queremos consultar su equivalencia en el rango. Para el proceso contrario usamos la función ``invert()``.

.. note::

   Para calcular cuantas unidades de rango equivale cada una de dominio: :math:`(range_y - range_x) / (domain_y - domain_x)`.

Las escalas no sólo representan datos matemáticos, si no cualquier rango de matices, como por ejemplo gamas de colores:

.. code-block:: js

   var color = d3.scaleLinear()
       .domain([0, 100])
       .range(["brown", "steelblue"])
   console.log(color(30));  // rgb(137, 68, 83)


Interpoladores
==============


Otra noción básica de las escalas son los interpoladores. En matemáticas la `interpolación <https://es.wikipedia.org/wiki/Interpolaci%C3%B3n>`__ es la obtención de nuevos puntos partiendo del conocimiento de un conjunto discreto de puntos.

.. note::

   `Aquí puedes ver ejemplos de interpoladores usados en D3JS para mapear escalas de colores y una implementación básica en Python <https://d3-spanish.readthedocs.io/es/latest/basico/escalas_de_colores.html>`__.

- `Interpolar (RAE) <http://dle.rae.es/?id=LwIT8WI>`__: **Calcular el valor aproximado de una magnitud en un intervalo cuando se conocen algunos de los valores que toma a uno y otro lado de dicho intervalo**.


.. _escalas-continuas:

Escalas continuas
=================

Las escalas continuas mapean un dominio cuantitativo de entrada a un rango continuo de salida.

Clamping
--------

El clamping o "represión" (en español) es un atributo que está desactivado por defecto en la mayoría de escalas. Al activarlo, no podremos acceder a los valores fuera de rango y dominio: al intentarlo devolverá los valores del extremo.

.. code-block:: js

   var x = d3.scaleLinear()
       .domain([10, 130])
       .range([0, 960]);

   // Clamping desactivado, acceso a los valores externos al mapeo
   x(-10);          // -160
   x.invert(-160);  // -10

   // Activación del clamping
   x.clamp(true);
   // Ahora no se permite acceder a los valores externos
   x(-10);          // 0
   x.invert(-160);  // 10

Ticks
-----

La función `escala_continua.ticks([count]) <https://github.com/d3/d3-scale#continuous_ticks>`__ devuelve aproximadamente ``count`` valores del dominio de la escala (por defecto ``10`` si el parametro ``count`` no es especificado).

.. code-block:: js

   var x = d3.scaleLinear()
       .domain([0, 100])
       .range([3000, 5000])
   x.ticks(5);     // Array [ 0, 20, 40, 60, 80, 100 ]

Los valores devueltos están uniformemente espaciados, tienen valores legibles por humanos (como múltiplos de potencias de 10) y se garantiza que estarán dentro de la extensión del dominio. Los ticks son usados a menudo para mostrar líneas de referencia o marcas, en cojunción con los datos visualizados.


Escalas lineales - `d3.scaleLinear()`_
--------------------------------------

Esta función contruye una nueva escala con dominio y rango ``[0, 1]``, el interpolador por defecto y el clamping desactivado. Este tipo de escalas son una buena elección para datos cuantitativos continuos porque estos preservan diferencias proporcionales.

.. note::

   Cada valor del rango ``y`` puede ser expresado como una función del valor del dominio ``x``: :math:`y = mx + b`.

Escalas exponenciales - `d3.scalePow()`_
----------------------------------------

Construye una escala continua con dominio y rango ``[0, 1]``, exponente ``1``, el interpolador por defecto y el clamping desactivado. Esta escala será igual que una escala lineal si mantenemos el exponente a 1. Para cambiarlo podemos usar el método ``exponent()``:

.. code-block:: js

   var x = d3.scalePow()
       .domain([0, 10])
       .range([0, 100])
   console.log(x(4)); // 40

   x.exponent(2);
   console.log(x(4)); // 16

.. note::

   Cada valor del rango ``y`` puede ser expresado como una función del valor de dominio ``x``: :math:`y = mx^k + b`, donde ``k`` es el valor del exponente.


Escalas logarítmicas - `d3.scaleLog()`_
---------------------------------------
Las escalas logarítmicas son similares a las escalas lineales, excepto en que aplica una transformación logarítmica es aplicada a los valores dominio de entrada antes de que el los valores del rango de salida sean calculados.

.. note::

   El mapeo al valor del rango ``y`` puede ser expresado com una función del valor de dominio ``x``: :math:`y = m log(x) + b.`



Escalas de tiempo - `d3.scaleTime()`_
-------------------------------------

Las escalas de tiempo son una variante de las escalas lineales que tienen un dominio temporal: los valores de dominio son coercidos a fechas en lugar de números y la función ``invert()`` devuelve una fecha asimismo. Estas escalas implementan ticks basados en intervalos de calendarios, eliminando el dolor de generar ejes para dominios temporales.


.. code-block:: js

   var x = d3.scaleTime()     // Year, month, day
       .domain([new Date(2010, 8, 12), new Date(2011, 8, 12)])
       .range([0, 100]);

   x(new Date(2010, 11, 12));  // 24.942922374429223
   x(new Date(2011, 2, 2));    // 46.86073059360731
   x.invert(200);       // Date 2012-09-10T22:00:00.000Z
   x.invert(640);       // 2017-02-02T22:00:00.000Z


.. code-block:: js

   var x = d3.scaleTime()
       .domain([new Date(1900, 1, 1), new Date(2000, 1, 1)])
       .range([0, 36500]);
   x.ticks(3);  /* Array [ Date 1949-12-31T23:00:00.000Z,
                           Date 1999-12-31T23:00:00.000Z ] */


Escalas secuenciales
====================

Este tipo de escalas son similares a las escalas :ref:`escalas-continuas` en que mapean un dominio de entrada numérico a un rango de salida. Sin embargo, a diferencia de las continuas, el rango de salida de una escala secuencial es fijado por su interpolador y no es configurable.

.. code-block:: js


.. raw:: html

   <script>
     var secuencial = d3.scaleSequential( function(t) { return t; })
         .domain([1, 100]);
     console.log(secuencial(2));
     //console.log(secuencial(2));
     //console.log(secuencial.ticks(5));
   </script>


.. _d3-scale: https://github.com/d3/d3-scale
.. _d3-interpolate: https://github.com/d3/d3-interpolate

.. _d3.scaleLinear(): https://github.com/d3/d3-scale#scaleLinear
.. _d3.scalePow(): https://github.com/d3/d3-scale#scalePow
.. _d3.scaleLog(): https://github.com/d3/d3-scale#scaleLog
.. _d3.scaleTime(): https://github.com/d3/d3-scale#scaleTime
