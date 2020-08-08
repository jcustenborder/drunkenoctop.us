=======
BLTouch
=======

Adding a BLTouch to your Printer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are special builds of *Drunken Octopus* for printers that have
been upgraded with BLTouch. These are in the “custom” folder and are
indicated by “BLTouch” in the name.

BLTouch Mounting Options
^^^^^^^^^^^^^^^^^^^^^^^^

The following are mounting options recommended by *Drunken Octopus* users:

.. csv-table::
    :header: "Printer","Link","Notes"

    "TAZ 4","`Replacement X Carriage for TAZ 4`_",""
    "TAZ 6","`Replacement X Carriage for TAZ 6`_",""
    "TAZ Pro","`Replacement X Carriage for TAZ Pro`_","Requires downgrade of TAZ Pro to single extruder."


.. _Replacement X Carriage for TAZ 4: https://www.thingiverse.com/thing:4558988
.. _Replacement X Carriage for TAZ 6: https://www.thingiverse.com/thing:3512979
.. _Replacement X Carriage for TAZ Pro: https://github.com/SynDaverCO/syndaver-axi/blob/master/Mechanical/Printed_parts/x_carriage


Electrical Modifications
^^^^^^^^^^^^^^^^^^^^^^^^

Please see the following pages for your board:

-  `Archim <Archim-Pinouts>`__
-  `RAMBO <RAMBO-Pinouts>`__

After the Upgrade
^^^^^^^^^^^^^^^^^

Set the BLTouch offset
^^^^^^^^^^^^^^^^^^^^^^

You may need to configure your BLTouch offset using
`M851 <https://marlinfw.org/docs/gcode/M851.html>`__:

::

   ; Run these commands from the console
   M851 X<value> Y<value>     ; Set the offset
   M500                       ; Save to EEPROM

You can also configure these values from the LCD.

Modify your Start GCODE
^^^^^^^^^^^^^^^^^^^^^^^

All BLTouch firmware uses `Unified Bed
Leveling <https://marlinfw.org/docs/features/unified_bed_leveling.html>`__
from Marlin. This modifies the behavior of
`G29 <https://marlinfw.org/docs/gcode/G029-ubl.html>`__ to be a
multi-part process. You will need to modify your start GCODE to pass
addition parameters to
`G29 <https://marlinfw.org/docs/gcode/G029-ubl.html>`__.

*Drunken Octopus* will do a 25 point probe with the BLTouch. This is a
rather lengthy operation. You can choose to do a full probe at the start
of each print; or run it infrequently and store the bed mesh for use at
the start of each print.

Full Probe at the Start of Each Print
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Replace `G29 <https://marlinfw.org/docs/gcode/G029-ubl.html>`__ with:

::

   G29 P1          ; Automatically probe accessible area
   G29 P3          ; Fill un-probed areas with reasonable values - may need to be repeated

Three-Point Probe at the Start of Each Print
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As an alternative, you can run the full probe sequence manually to
determine the *bed mesh* and have your start GCODE run an abbreviated
three-point probe to determine the *bed tilt*. To do a full probe:

::

   ; Run these commands from the console
   G29 P1          ; Automatically probe accessible area
   G29 P3          ; Fill un-probed areas with reasonable values - may need to be repeated
   G29 S1          ; Save to slot 1

To load stored mesh and measure the bed tilt at the start of the print:

::

   G29 L1        ; Load the mesh stored in slot 1 (from G29 S1)
   G29 J         ; No size specified on the J option tells G29 to probe the specified 3 points and tilt the mesh according to what it finds.

What if my probe cannot reach all the points?
---------------------------------------------

If Marlin isn’t probing all the points, you may need to: - Adjust the
BLTouch offset - Reposition your BLTouch - Increase the travel on an
axis.

You may also choose to manually calibrate the missing points as
documented in `Unified Bed
Leveling <https://marlinfw.org/docs/features/unified_bed_leveling.html>`__
and then save your mesh.

More advanced users can recompile the firmware and experiment with
changing the following parameters to fine tune the probing area:

-  ``MIN_PROBE_EDGE``
-  ``MIN_PROBE_EDGE_LEFT``
-  ``MIN_PROBE_EDGE_RIGHT``
-  ``MIN_PROBE_EDGE_FRONT``
-  ``MIN_PROBE_EDGE_BACK``
-  ``GRID_MAX_POINTS_X``
-  ``GRID_MAX_POINTS_Y``

If you find settings that work well, please let me know and I might make
them defaults in *Drunken Octopus*.
