[![Build Status](https://travis-ci.org/travis/Raku-LibUSB.svg?branch=master)](https://travis-ci.org/travis/Raku-LibUSB)

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
$dev.open()  # Will require elevated privileges

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

##### Int $vid

The VID of the device.

##### Int $pid

The PID of the device.

### get-device (multi)

Find the first device with a user-defined check.

#### Params

##### &check($desc)

Find the first device for which &check returns true. $desc is a libusb_device_descriptor as found in the libusb documentation.

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

### control-transfer

Perform a control transfer to the device. It supports named parameters in any order, or positional parameters in the order below.

#### Params

##### uint8 $request-type

The USB control transfer request type.

##### uint8 $request

The USB control transfer request.

##### uint16 $value

The USB control transfer value.

##### uint16 $index

The USB control transfer index.

##### blob8 $data

A buffer containing data to send, or containing space to receive data.

##### uint16 $elems

The number of elems in $data.

##### uint32 $timeout

How long to wait before timing out. Defaults to 0 (never time out).

### bulk-transfer

Perform a bulk transfer to the device. It supports named parameters in any order, or positional parameters in the order below.

#### Params

##### uint8 $endpoint

The target endpoint

##### blob8 $data

A buffer containing data to send, or containing space to receive data.

##### uint16 $elems

The number of elems in $data.

##### Int $transferred is rw

The amount of data transferred (output)

##### uint32 $timeout

How long to wait before timing out. Defaults to 0 (never time out).

### interrupt-transfer

Perform a interrupt transfer to the device. It supports named parameters in any order, or positional parameters in the order below.

#### Params

##### uint8 $endpoint

The target endpoint

##### blob8 $data

A buffer containing data to send, or containing space to receive data.

##### uint16 $elems

The number of elems in $data.

##### Int $transferred is rw

The amount of data transferred (output)

##### uint32 $timeout

How long to wait before timing out. Defaults to 0 (never time out).

AUTHOR
======

Travis Gibson <TGib.Travis@protonmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

