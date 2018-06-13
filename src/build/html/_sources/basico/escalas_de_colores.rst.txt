******************
Escalas de colores
******************

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>

.. raw:: html

   <p>En los siguientes ejemplos vamos a coger una escala que empieza y termina en los colores mostrados abajo (<span id="color1-span"></span>, <span id="color2-span"></span>). Vamos a mapearla como una escala en D3 y aplicaremos diferentes interpolaciones.</p>

.. raw:: html

   <svg width="100%" height="100">
     <rect id="color1" x="0" y="0" width="50%" height="100%"></rect>
     <rect id="color2" x="50%" y="0" width="50%" height="100%"></rect>
   </svg>
   <br><br>
   <script>
     var color1 = "#007AFF",
         color2 = "#FFF500";

     d3.select("#color1").attr("fill", color1);
     d3.select("#color2").attr("fill", color2);

     d3.select("#color1-span").text(color1).style("color", color1);
     d3.select("#color2-span").text(color2).style("color", color2);
   </script>

El código común a todas las escalas es el siguiente:

.. code-block:: js

   var width = 700,
       height = 500,
       lenght = 20;  // Cantidad de colores en cada barra
   var unit = width/lenght;  // Ancho de cada color

   var renderColorsBar = function(svg_id, interpolator) {
       // svg_id --> Identificador del elemento svg donde
       //              será renderizada la barra de colores.
       // interpolator --> Interpolador d3 usado en la escala.

       var colorScale = d3.scaleLinear()
           .domain([1, lenght])
           .interpolate(interpolator)
           .range([d3.rgb(color1), d3.rgb(color2)]);

       for (var i = 0; i < lenght; i++) {
          d3.select(svg_id)
             .attr("height", height)
             .attr("width", width)
           .append("rect")
             .attr("x",  i*unit )
             .attr("y", 0)
             .attr("width", unit)
             .attr("height", 200)
             .style("fill", colorScale(i));
       }
   }

.. raw:: html

   <script>
     var width = 700,
         height = 175,
         lenght = 20;
     var unit = width/lenght;

     var renderColorsBar = function(svg_id, interpolator) {
         var colorScale = d3.scaleLinear()
             .domain([1, lenght])
             .interpolate(interpolator)
             .range([d3.rgb(color1), d3.rgb(color2)]);

         for (var i = 0; i < lenght; i++) {
            d3.select(svg_id)
               .attr("height", height)
               .attr("width", width)
             .append("rect")
               .attr("x",  i*unit )
               .attr("y", 0)
               .attr("width", unit)
               .attr("height", height - 35)
               .style("fill", colorScale(i));
         }
     }
   </script>

Interpoladores desde `d3-interpolate`_
======================================

`d3.interpolateRgb(a, b)`_
--------------------------

Devuelve un interpolador en el espacio de color RGB entre los colores ``a`` y ``b`` con un parámetro ``gamma`` configurable (``1`` si no es especificado).

.. raw:: html

   <svg id="colors-interpolatergb"></div>

   <script>
     renderColorsBar("#colors-interpolatergb", d3.interpolateRgb);
   </script>

Podemos cambiar el parámetro ``gamma`` de un interpolador con la función `interpolator.gamma(x)`_.

.. rubric:: Input


.. code-block:: html

   <svg id="colors-interpolate-rgb-gamma"></div>

   <script>
     var interpolator = d3.interpolateRgb.gamma(2);
     renderColorsBar("#colors-interpolate-rgb-gamma", interpolator);
   </script>

.. rubric:: Output

.. raw:: html

   <svg id="colors-interpolate-rgb-gamma"></div>

   <script>
     var interpolator = d3.interpolateRgb.gamma(2);
     renderColorsBar("#colors-interpolate-rgb-gamma", interpolator);
   </script>


`d3.interpolateHsl(a, b)`_
--------------------------
Devuelve un interpolador en el espacio de color HSL entre los colores ``a`` y ``b``.

.. raw:: html

   <svg id="colors-interpolate-hsl"></div>

   <script>
     renderColorsBar("#colors-interpolate-hsl", d3.interpolateHsl);
   </script>


`d3.interpolateLab(a, b)`_
--------------------------
Devuelve un interpolador en el espacio de color Lab entre los colores ``a`` y ``b``.

.. raw:: html

   <svg id="colors-interpolate-lab"></div>

   <script>
     renderColorsBar("#colors-interpolate-lab", d3.interpolateLab);
   </script>

`d3.interpolateHcl(a, b)`_
--------------------------
Devuelve un interpolador en el espacio de color HCL entre los colores ``a`` y ``b``.

.. raw:: html

   <svg id="colors-interpolate-hcl"></svg>

   <script>
     renderColorsBar("#colors-interpolate-hcl", d3.interpolateHcl);
   </script>


`d3.interpolateCubehelix(a, b)`_
--------------------------------
Devuelve un interpolador en el espacio de color Cubehelix entre los colores ``a`` y ``b``.

.. raw:: html

   <svg id="colors-interpolate-cubehelix"></svg>

   <script>
     renderColorsBar("#colors-interpolate-cubehelix", d3.interpolateCubehelix);
   </script>


Un interpolador de color RGB básico en Python
=============================================

Para entender claramente lo que hacen los interpoladores, pongamos este sencillo interpolador RGB de ejemplo con Python (`el código fuente está sacado de aquí <https://gist.github.com/lambdamusic/4734406>`__):

.. code-block:: python

   import string

   def make_color_tuple(color):
       """Convierte algo como "#000000" en "0,0,0"
       ó "#FFFFFF" en "255,255,255".
       """
       R = color[1:3]
       G = color[3:5]
       B = color[5:7]

       R = int(R, 16)
       G = int(G, 16)
       B = int(B, 16)

       return R,G,B

   def interpolate_tuple( startcolor, goalcolor, steps ):
       """Toma dos colores RGB o los mezcla en
       un número específico de pasos. Devuelve
       la lista de todos los colores generados.
       """
       R = startcolor[0]
       G = startcolor[1]
       B = startcolor[2]

       targetR = goalcolor[0]
       targetG = goalcolor[1]
       targetB = goalcolor[2]

       DiffR = targetR - R
       DiffG = targetG - G
       DiffB = targetB - B

       buffer = []

       for i in range(0, steps +1):
           iR = R + (DiffR * i / steps)
           iG = G + (DiffG * i / steps)
           iB = B + (DiffB * i / steps)

           hR = string.replace(hex(iR), "0x", "")
           hG = string.replace(hex(iG), "0x", "")
           hB = string.replace(hex(iB), "0x", "")

           if len(hR) == 1:
               hR = "0" + hR
           if len(hB) == 1:
               hB = "0" + hB

           if len(hG) == 1:
               hG = "0" + hG

           color = string.upper("#"+hR+hG+hB)
           buffer.append(color)

       return buffer

   def interpolate(startcolor, goalcolor, steps):
       """Envoltura para la función ``interpolate_tuple``
       que acepta colores como "#CCCCCC".
       """
       start_tuple = make_color_tuple(startcolor)
       goal_tuple = make_color_tuple(goalcolor)

       return interpolate_tuple(start_tuple, goal_tuple, steps)


   def printchart(startcolor, endcolor, steps):
       colors = interpolate(startcolor, endcolor, steps)

       for color in colors:
           print(color)


   # Muestra 16 valores de gradiente entre esos dos colores
   printchart("#999933", "#6666FF", 16)


.. _d3-interpolate: https://github.com/d3/d3-interpolate

.. _d3.interpolateRgb(a, b): https://github.com/d3/d3-interpolate#interpolateRgb
.. _interpolator.gamma(x): https://github.com/d3/d3-interpolate#interpolate_gamma
.. _d3.interpolateHsl(a, b): https://github.com/d3/d3-interpolate#interpolateHsl
.. _d3.interpolateLab(a, b): https://github.com/d3/d3-interpolate#interpolateLab
.. _d3.interpolateHcl(a, b): https://github.com/d3/d3-interpolate#interpolateHcl
.. _d3.interpolateCubehelix(a, b): https://github.com/d3/d3-interpolate#interpolateCubehelix
