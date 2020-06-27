NAME
====

LibUSB - OO binding to libusb

SYNOPSIS
========

```raku
constant VID = <vid>
constant PID = <pid>

use LibUSB;
my LibUSB $dev .= new;
$dev.init;
$dev.get-device(VID, PID);
$dev.open()   # May require root privileges

# Do things with the device

$dev.close();
$dev.exit()
```

DESCRIPTION
===========

LibUSB is an OO Raku binding to the libusb library, allowing for access to USB devices from Raku.

This interface is experimental and incomplete.

Methods
-------

### init

Initialize the libusb library for this device object.

### get-device (multi)

Find the first device that matches the parameters and select it.

#### Params

##### $vid

The VID of the device

##### $pid

The PID of the device

### get-device (multi)

Find the first device with a user-defined check.

#### Params

##### &check($desc)

Find the first device for which &check returns true. $desc is a libusb_device_descriptor as found in the libusb documentation

### open()

Open the selected device.

### close()

Close the device.

### exit()

Close down the libusb library for this device object.

### vid()

Returns the VID of the device.

### pid()

Returns the PID of the device.

### bus-number()

Returns the bus number of the device.

### address()

Returns the address of the device.

### speed()

Returns the speed of the device.

### control-transfer($request-type, $request, $value, $index, $data, $length, $timeout)

Perform a control transfer to the device.

AUTHOR
======

Travis Gibson <TGib.Travis@protonmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

