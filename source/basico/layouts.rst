.. _layouts-section:

*******
Layouts
*******

.. raw:: html

   <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.13.0/d3.min.js"></script>



De jerarquía - `d3-hierarchy`_
==============================

Arbol
-----

Los conjuntos de datos en árbol (anidados unos datos dentro de otros) son perfecto para el tipo de layout de la función `d3.tree()`_.

.. rubric:: Input

.. code-block:: html

   <svg width="600" height="600"></svg>

    <script>
      var data = {
        "name": "Max",
        "children": [
          {
            "name": "Carlos",
            "children": [
              {"name": "Carla"},
              {"name": "Eusebio"},
              {"name": "Alicia"}
           ]
          },
          {
            "name": "Joana",
            "children": [
              {"name": "Cristina"},
              {"name": "Julián"},
              {"name": "Recaredo"}
            ]
          }
        ]
      };

      var svg = d3.select("svg"),
          width = +svg.attr("width"),    // La anotación con + extrae
          height = +svg.attr("height"),  // el valor del atributo
          g = svg.append("g").attr("transform", "translate(0,40)");

      // Parseamos los diccionarios anidados y extraemos el nodo padre
      var root = d3.hierarchy(data)

      // Creamos un layout de árbol
      var tree = d3.tree().size([width-30, height-160]);
      tree(root);    // Insertamos la jerarquía en el árbol

      // Creamos los enlaces entre los elementos
      var link = g.selectAll(".link")
          .data(root.links())      // Pasamos como dato los enlaces pade-hijo
          .enter().append("line")  // Para cada enlace una linea...
              .attr("class", "link")
              .attr("stroke-width", "2px")
              .attr("stroke", "#ddd")
              .attr("x1", function(d) { return d.source.x; })
              .attr("y1", function(d) { return d.source.y; })
              .attr("x2", function(d) { return d.target.x; })
              .attr("y2", function(d) { return d.target.y; });

      // Creamos nodos para los elementos del árbol
      var node = g.selectAll(".node")
          .data(root.descendants())  // Accedemos a los descendientes del árbol
          .enter()
            .append("g")     // Para cada nodo creamos un grupo
              .attr("transform", function(d) {
                  return "translate(" + d.x + "," + d.y + ")";
              })

      // En cada nodo añadimos lo que queramos
      node.append("circle")
        .attr("r", 2.5);

      node.append("text")
       .text(function(d) { return d.data.name });
    </script>

.. rubric:: Output

.. raw:: html

   <svg width="600" height="600"></svg>

   <script>
     var data = {
       "name": "Max",
       "children": [
         {
           "name": "Carlos",
           "children": [
             {"name": "Carla"},
             {"name": "Eusebio"},
             {"name": "Alicia"}
          ]
         },
         {
           "name": "Joana",
           "children": [
             {"name": "Cristina"},
             {"name": "Julián"},
             {"name": "Recaredo"}
           ]
         }
       ]
     };

     var svg = d3.select("svg"),
         width = +svg.attr("width"),
         height = +svg.attr("height"),
         g = svg.append("g").attr("transform", "translate(0,40)");

     var root = d3.hierarchy(data)
     var tree = d3.tree()
         .size([width-30, height-160]);
     tree(root); // Renderizamos el nodo padre

     var link = g.selectAll(".link")
         .data(root.links())
         .enter().append("line")
             .attr("class", "link")
             .attr("stroke-width", "2px")
             .attr("stroke", "#ddd")
             .attr("x1", function(d) { return d.source.x; })
             .attr("y1", function(d) { return d.source.y; })
             .attr("x2", function(d) { return d.target.x; })
             .attr("y2", function(d) { return d.target.y; });

     var node = g.selectAll(".node")
         .data(root.descendants())
         .enter()
           .append("g")
             .attr("transform", function(d) {
                 return "translate(" + d.x + "," + d.y + ")";
             })

     node.append("circle")
       .attr("r", 2.5);

     node.append("text")
       .text(function(d) { return d.data.name });
   </script>

La función `d3.hierarchy(data[, children])`_ extrae el nodo padre de un conjunto de datos anidados.

.. _d3-hierarchy: https://github.com/d3/d3-hierarchy
.. _d3.tree(): https://github.com/d3/d3-hierarchy/blob/master/README.md#tree
.. _d3.hierarchy(data[, children]): https://github.com/d3/d3-hierarchy/blob/master/README.md#hierarchy