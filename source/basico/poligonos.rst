***************************
Polígonos --- `d3-polygon`_
***************************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>
   <script>console.log("D3JS v" + d3.version)</script>

El módulo `d3-polygon`_ ofrece algunas operaciones que se pueden efectuar sobre polígonos de dos dimensiones. Cada polígono está representado por un array de arrays de dos elementos y pueden ser cerrados (si el primer y el último punto son el mismo) o abiertos. Típicamente, el orden de los puntos están dados en dirección a las agujas del reloj donde el origen ``(0, 0)`` se sitúa en la esquina izquierda-arriba de la pantalla.

.. code-block:: html

   .. raw:: html

   <script>
     var puntos = [
         [10, 10],
         [30, 10],
         [50, 40],
         [45, 60],
         [15, 35],
         [10, 10]
     ];

     // Definimos un polígono a partir de sus puntos ("hull" == cáscara)
     var poligono = d3.polygonHull(puntos);
     console.log(poligono);   // [Array(2), Array(2), Array(2), Array(2), Array(2)]

     // Obtenemos el área del polígono
     var area = d3.polygonArea(poligono);
     console.log(area);       // 1087.5

     // Obtenemos el perímetro del polígono
     var perimetro = d3.polygonLength(poligono);
     console.log(perimetro);  // 141.2173868302254

     // Obtenemos el centro del polígono
     var centro = d3.polygonCentroid(poligono);
     console.log(centro);     // [30.268199233716476, 31.590038314176244]

     // Comprobamos si un punto está dentro del polígono
     var contiene = d3.polygonContains(poligono, (35, 10));
     console.log(contiene);   // false
   </script>


.. raw:: html

   <script>
     var puntos = [
         [10, 10],
         [30, 10],
         [50, 40],
         [45, 60],
         [15, 35],
         [10, 10]
     ];

     // Definimos un polígono a partir de sus puntos ("hull" == cáscara)
     var poligono = d3.polygonHull(puntos);
     console.log(poligono);   // [Array(2), Array(2), Array(2), Array(2), Array(2)]

     // Obtenemos el área del polígono
     var area = d3.polygonArea(poligono);
     console.log(area);       // 1087.5

     // Obtenemos el perímetro del polígono
     var perimetro = d3.polygonLength(poligono);
     console.log(perimetro);  // 141.2173868302254

     // Obtenemos el centro del polígono
     var centro = d3.polygonCentroid(poligono);
     console.log(centro);     // [30.268199233716476, 31.590038314176244]

     // Comprobamos si un punto está dentro del polígono
     var contiene = d3.polygonContains(poligono, (35, 10));
     console.log(contiene);   // false
   </script>


.. _d3-polygon: https://github.com/d3/d3-polygon/blob/master/README.md

