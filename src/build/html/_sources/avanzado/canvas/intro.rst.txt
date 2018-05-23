Introducción a ``canvas``
=========================


Insertando un dibujo ``canvas``
-------------------------------

.. code-block:: html

   <canvas id="micanvas" width="200" height="100">
     Este texto se muestra para los navegadores no compatibles con canvas.
     <br>
     Por favor, utiliza Firefox, Chrome, Safari u Opera.
   </canvas>

Inicialmente el canvas está en blanco y cuando queremos pintar sobre él tenemos que acceder al contexto de renderizado del canvas, sobre el que podremos invocar distintos métodos para acceder a las funciones de dibujo. El proceso simplificado sería el siguiente:

.. code-block:: js

   var canvas = document.getElementById('micanvas');

   // Accedo al contexto de '2d' de este canvas, necesario para dibujar
   var contexto = canvas.getContext('2d');

   if (contexto) {
       // Dibujo en el contexto del canvas
       contexto.fillRect(50, 0, 10, 150);
   } else {
       console.log("Tu navegador no soporta la etiqueta 'canvas'.")
   }

Ahora sólo falta una última cosa, que es ejecutar estas acciones sólo cuando la página esté cargada por completo y lista para recibirlas. Esto lo conseguimos con la el evento onload del body de la página:

.. code-block:: html

   <body onload="funcionDeDibujo()">
     ...
   </body>


Ejemplo básico en canvas
------------------------

.. rubric:: Input

.. code-block:: html

   <canvas id="lienzo" width="100%" height="200">
     Tu navegador no soporta canvas.
   </canvas>

   <script>
     // Al cargar el documento
     window.onload = function(){

         // Obtenemos el contexto del canvas
         var elem = document.getElementById("lienzo");
         if (elem && elem.getContext) {
             var context = elem.getContext("2d");
             if (!context) {
                 throw new Error("Tu navegador no soporta canvas.");
             } else {

                 // Cambiamos el color a azul
                 context.fillStyle = "navy";
                 // Dibujamos un rectángulo
                 context.fillRect(10, 10, 50, 50);

                 // Cambiamos el color a amarillo con transparencia
                 context.fillStyle = "rgba(255,255,0,0.7)";
                 // Dibujamos un rectángulo amarillo semitransparente
                 context.fillRect(60, 60, 120, 100);
             }
         }
     };
   </script>


.. rubric:: Output

.. raw:: html

   <canvas id="lienzo" width="100%" height="200">
     Tu navegador no soporta canvas.
   </canvas>

   <script>
     // Al cargar el documento
     window.onload = function(){

         // Obtenemos el contexto del canvas
         var elem = document.getElementById("lienzo");
         if (elem && elem.getContext) {
             var context = elem.getContext("2d");
             if (!context) {
                 throw new Error("Tu navegador no soporta canvas.");
             } else {

                 // Cambiamos el color a azul
                 context.fillStyle = "navy";
                 // Dibujamos un rectángulo
                 context.fillRect(10, 10, 50, 50);

                 // Cambiamos el color a amarillo con transparencia
                 context.fillStyle = "rgba(255,255,0,0.7)";
                 // Dibujamos un rectángulo amarillo semitransparente
                 context.fillRect(60, 60, 120, 100);
             }
         }
     };
   </script>

