Installing ``YT``
=================

``YT`` requires Julia version 0.3 or later, and may be installed just like any other Julia package:

.. code-block:: jlcon

    julia> Pkg.add("YT")

This will also install the following dependencies, if you don't have them installed already:

* `PyCall <http://github.com/stevengj/PyCall.jl>`_
* `PyPlot <http://github.com/stevengj/PyPlot.jl>`_
* `SymPy <http://github.com/jverzani/SymPy.jl>`_

However, for ``YT`` to work, ``yt`` itself must be installed. ``YT`` requires ``yt`` version 3.0
or higher. The best ways to install ``yt`` are via the
`install script <http://yt-project.org/#getyt>`_ or via the
`Anaconda Python Distribution <https://store.continuum.io/cshop/anaconda/>`_.

Once ``YT`` is installed, either

.. code-block:: jlcon

    julia> import YT

to use it as a library, or

.. code-block:: jlcon

    julia> using YT

to use it as an application, loading its methods into the current session's namespace.