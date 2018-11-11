.. _d3-timer-section:

*********************
Timer --- `d3-timer`_
*********************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>
   <script>console.log("D3JS v" + d3.version)</script>

Funciones útiles
================

`d3.now()`_
-----------

Devuelve el tiempo actual en unix timestamps. Esta función asegura consistenca temporal durante el manejo de eventos.

Temporizadores
==============

`d3.timer()`_
-------------

Ejecuta un temporizador, invocando un callback específico repetidamente hasta que el temporizador es apagado. Se puede pasa un numero al parámetro opcional ``delay`` en milisegundos para invocar al callback después de este tiempo.

.. rubric:: Input

.. code-block:: js

   t = d3.timer(function(elapsed) {
       console.log(elapsed);
       if (elapsed > 300) { t.stop() };
   }, 250)


.. rubric:: Output

::

   12
   72
   94
   168
   236
   252
   272
   308

`timer.stop()`_
---------------

Detiene un temporizador, previniendo la invocación de callbacks subsecuentes. No tiene efecto si el temporizador ya ha sido detenido.


`timer.restart()`_
------------------

Reinicia un temporizador con un ``callback`` especificado y con parametros opcionales ``delay`` y ``time``. Esta función es equivalente a para el temporizador y crear uno nuevo con los argumentos provistos, sin embargo este temporizador retiene la prioridad de la invocación anterior.

.. rubric:: Input

.. code-block:: js

   var restarted = false;
   var callback = function(elapsed){
       console.log(elapsed);
       if (elapsed > 100) {
           if (restarted == false) {
               restarted = true;
               console.log("");
               t.restart(callback, 200);
           } else {
               t.stop();
           };
       };
   };

   var t = d3.timer(callback, 200);

::

   36
   84
   94
   118

   52
   58
   172


`d3.timeout()`_
---------------
Como la función `d3.timer()`_, con la diferencia de que este temporizador se detiene en el primer callback.

.. rubric:: Input

.. code-block:: js

   var callback_2 = function(elapsed){
       console.log("¡Callback ejecutado!")
   }
   var t = d3.timeout(callback_2, 200);

.. rubric:: Output

::

  ¡Callback ejecutado!


`d3.interval()`_
----------------

Igual que la función `d3.timer()`_ excepto en que el callback es inovocado cada ``x`` milisegundos definidos en el parámetro ``delay``.

.. rubric:: Input

.. code-block:: js

   var callback = function(elapsed){
       console.log(elapsed);
       if (elapsed > 2000) {
           t.stop();
       }
   }

   var t = d3.interval(callback, 500)

.. rubric:: Output

::

   562
   1000
   1502
   2000
   2500


.. _d3-timer: https://github.com/d3/d3-timer

.. _d3.now(): https://github.com/d3/d3-timer/blob/master/README.md#now
.. _d3.timer(): https://github.com/d3/d3-timer/blob/master/README.md#timer
.. _timer.stop(): https://github.com/d3/d3-timer/blob/master/README.md#timer_stop
.. _timer.restart(): https://github.com/d3/d3-timer/blob/master/README.md#timer_restart

.. _d3.timeout(): https://github.com/d3/d3-timer/blob/master/README.md#timeout

