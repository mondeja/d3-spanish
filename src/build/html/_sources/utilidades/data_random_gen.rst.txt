****************************
Generador de datos aleatorio
****************************

`Faker.js`_
===========

Esta biblioteca nos permite generar datos aleatorios de diferentes tipos. Puede ser usada mediante su descarga, mediante CDN o a través de un microservicio con llamadas HTTP.

Uso básico
----------

Esta biblioteca tiene muchos tipos de generadores, los cuales podemos consultar en la documentación. Cada tipo de generador (en este ejemplo ``name``) sirve para generar un tipo de datos distinto.

.. code-block:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/Faker/3.1.0/faker.min.js"></script>

   <script>
     window.onload = function(){
         faker.locale = "es";
         var nombreAleatorio = faker.name.findName();
         console.log(nombreAleatorio);
     }
   </script>

La lista de locales soportadas se encuentra `aquí <https://github.com/Marak/faker.js/tree/master/locale>`_.


.. _Fakers.js: https://github.com/marak/Faker.js/