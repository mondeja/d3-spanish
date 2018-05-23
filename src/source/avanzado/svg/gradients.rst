**************
Gradientes SVG
**************

Lineal
======

Para crear un gradiente lineal definimos el filtro ``linearGradient``.

.. rubric:: Input

.. code-block:: html

    <svg width="100%" height="400">
      <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="10%">
          <stop offset="10%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
          <stop offset="30%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
          <stop offset="70%" style="stop-color:rgb(0, 50, 255);stop-opacity:1" />
        </linearGradient>
      </defs>

       <rect x="0" y="0" width="300" height="100" fill="url(#grad1)" />
    </svg>

.. rubric:: Output

.. raw:: html

    <svg width="100%" height="130">
      <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="10%">
          <stop offset="10%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
          <stop offset="30%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
          <stop offset="70%" style="stop-color:rgb(0, 50, 255);stop-opacity:1" />
        </linearGradient>
      </defs>

       <rect x="0" y="0" width="300" height="100" fill="url(#grad1)" />
    </svg>


