.. _introduction-section:

**********************
Introducción a `D3JS`_
**********************

`D3JS`_ es una biblioteca Javascript que permite realizar documentos orientados a datos. Su fuerte es proporcionar maneras de interactuar y visualizar datos usando los navegadores web. A simple vista parece estar orientado a científicos que trabajan sobre datos, pero combinado con el poder de SVG o Canvas puede ser increíblemente útil en la construcción de elementos visuales para aplicaciones web.

- NPM: ``npm install d3``


Historia
========

`D3JS`_ ha sido creado por `Mike Bostock`_, un desarrollador estadounidense especializado en el tratado de datos y su visualización. Trabajó para el New York Times mientras desarrollaba la biblioteca y tiene una vasta cantidad de ejemplos de su uso `publicados`_.

_____________________________________


Consideraciones para novatos
============================

A lo largo de las versiones mayores de `D3JS`_ se han introducido diversos cambios no compatibles hacia atrás, los cuales pueden consultarse en el `CHANGELOG`_.

El cambio más drástico ha sido `el paso de la versión 3 a la 4`_.

Estructura del código
---------------------

A partir de la versión 4, `D3JS`_ se ha vuelto una biblioteca modular, es decir, cada módulo se encuentra en un repositorio separado, por lo cual pueden importarse los módulos necesarios para empaquetarlos en un bundle sin depender del resto de códigos no usados.

Por lo tanto si encuentras ejemplos en la web, mira siempre la versión en la que estén diseñados, puesto que si es la versión 3 y estás utilizando la 4, (depende de tu conocimiento de la biblioteca y la complejidad del ejemplo) te puede ser difícil de trascribir y es probable que salten errores.

.. note::
   
   Abriendo la consola en cada página de este libro puedes comprobar la versión en la que están desarrollados sus ejemplos.

`D3JS`_ ofrece un bundle (archivo) que incluye el núcleo de la biblioteca, que es el que importarás si estás simplemente probando en desarrollo o no usas empaquetado (Webpack, Rollup...). Puedes ver los módulos que incluye el bundle nuclear en el `index del repositorio principal`_. Si encuentras algún ejemplo con módulos no incluídos en el bundle estándar, tendrás que instalarlos o linkearlos por separado.

`D3JS`_ es el infierno
----------------------

Es lo que pensarás al principio y es lo que pensaba yo dándome cabezazos contra los conceptos centrales de la biblioteca. ¿Cómo que puedo crear elementos fantasma con datos que no existen pero que van a entrar? ¿Cómo que los datos van a salir? ¿Por qué todas las funciones se encadenan?

Otra barrera de entrada a esta biblioteca es que debes saber SVG o Canvas, cuanto más mejor. Si estás perdido, échale un ojo a la `guía sobre SVG`_ que publiqué hace meses (prometo terminar de incluirla en este libro).

Comprende desde cosas muy básicas como selecciones estilo jQuery a diseños predefinidos donde volcar tus datos los cuales hay que comprender perfectamente antes de ponerse manos a la obra. Lo único que puedo aconsejarte es que estudias bien los ejemplos, luego todo será más sencillo.

.. note::
   
   No debes perder nunca de vista la `referencia`_, que está escrita en Markdown en el ``README.md`` del repositorio de cada módulo.




.. raw:: html

   <div id="sign-name-container">
       <a id="sign-name" href="https://www.github.com/mondeja" target="__blank">Álvaro Mondéjar Rubio</a>
   </div>
   <style>
       #sign-name-container {
         text-align: center;
         margin-top: 5px;
         margin-bottom: 15px;
       }
       #sign-name {
         font-size: 1.55em;
         text-align: center;
         text-decoration: none;
       }
       #sign-name::hover {
         color: steal;
       }
   </style>


.. _instalación: https://github.com/d3/d3#installing
.. _Mike Bostock: https://github.com/mbostock
.. _publicados: https://bost.ocks.org/mike/
.. _changelog: https://github.com/d3/d3/blob/master/CHANGES.md
.. _el paso de la versión 3 a la 4: https://github.com/d3/d3/blob/master/CHANGES.md#changes-in-d3-40
.. _index del repositorio principal: https://github.com/d3/d3/blob/master/index.js
.. _guía sobre svg: https://codepen.io/mondeja/post/dibujo-vectorial-con-svg
.. _referencia: https://github.com/d3/d3/blob/master/API.md
.. _álvaro mondéjar rubio: https://github.com/mondeja
