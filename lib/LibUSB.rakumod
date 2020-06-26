use LibUSB::Raw;
use X::LibUSB;

use NativeCall;

constant MAX-BUFFER-SIZE = 256;

unit class LibUSB:ver<0.0.1>:auth<cpan:GARLANDG>;

has libusb_context $!ctx .= new;
has libusb_device_handle $!handle;
has libusb_device $!dev;

method init() {
  libusb_init($!ctx);
}

method exit {
  libusb_exit($!ctx);
}

method close {
  libusb_close($!handle);
  $!dev = Nil;
}

multi submethod BUILD() {}

multi submethod BUILD(:$!dev!) {}

method !get-error(Int $err --> Exception) {
  given libusb_error($err) {
    when LIBUSB_ERROR_IO { X::LibUSB::IO.new }
    when LIBUSB_ERROR_INVALID_PARAM { X::LibUSB::Invalid-Param.new }
    when LIBUSB_ERROR_ACCESS { X::LibUSB::Access.new }
    when LIBUSB_ERROR_NO_DEVICE { X::LibUSB::No-Device.new }
    when LIBUSB_ERROR_NOT_FOUND { X::LibUSB::Not-Found.new }
    when LIBUSB_ERROR_BUSY { X::LibUSB::Busy.new }
    when LIBUSB_ERROR_TIMEOUT { X::LibUSB::Timeout.new }
    when LIBUSB_ERROR_OVERFLOW { X::LibUSB::Overflow.new }
    when LIBUSB_ERROR_PIPE { X::LibUSB::Pipe.new }
    when LIBUSB_ERROR_INTERRUPTED { X::LibUSB::Interrupted.new }
    when LIBUSB_ERROR_NO_MEM { X::LibUSB::No-Memory.new }
    when LIBUSB_ERROR_NOT_SUPPORTED { X::LibUSB::Not-Supported.new }
    when LIBUSB_ERROR_OTHER { X::LibUSB::Other.new }
    default { X::AdHoc.new("Unknown error") }
  }
}

multi method get-device(Int $target-vid, Int $target-pid) {
  self.get-device(-> $vid, $pid { $vid == $target-vid && $pid == $target-pid});
}

multi method get-device(&check:($vid, $pid)) {
  my int64 $listptr .= new;
  my $size = libusb_get_device_list($!ctx, $listptr);
  my $array = nativecast(CArray[libusb_device], Pointer[libusb_device].new($listptr));

  my $i = 0;
  repeat {
    my libusb_device $dev = $array[$i];
    my libusb_device_descriptor $desc .= new;
    my $err = libusb_get_device_descriptor($dev, $desc);
    return self!get-error($err) if $err;
    if &check($desc.idVendor, $desc.idProduct) {
      $!dev = $dev;
      return;
    }
    $i++;
  } while $i < $size;
  LEAVE {
    libusb_free_device_list(nativecast(Pointer[libusb_device], $array), 1) if $size;
  }
}

method get-parent(--> LibUSB) {
  return LibUSB.new(:dev(libusb_get_parent($!dev)))
}

method vid() {
  fail X::LibUSB::No-Device-Selected unless $!dev;
  my libusb_device_descriptor $desc .= new;
  my $err = libusb_get_device_descriptor($!dev, $desc);
  return self!get-error($err) if $err;
  return $desc.idVendor;
}

method pid() {
  fail X::LibUSB::No-Device-Selected unless $!dev;
  my libusb_device_descriptor $desc .= new;
  my $err = libusb_get_device_descriptor($!dev, $desc);
  return self!get-error($err) if $err;
  return $desc.idProduct;
}

method open(--> Nil) {
  fail X::LibUSB::No-Device-Selected unless $!dev;
  $!handle .= new;
  my $err = libusb_open($!dev, $!handle);
  die self!get-error($err) if $err;
}

method bus-number(--> Int) {
  return libusb_get_bus_number($!dev);
}

method address(--> Int) {
  return libusb_get_device_address($!dev);
}

method speed(--> libusb_speed) {
  return libusb_speed(libusb_get_device_speed($!dev));
}

method control-transfer(
                        uint8 :$request-type!,
                        uint8 :$request!,
                        uint16 :$value!,
                        uint16 :$index!,
                        buf8 :$data!,
                        uint16 :$length!,
                        uint32 :$timeout = 0
                        ) {
  fail X::LibUSB::No-Device-Selected unless $!dev;
  fail "Device not open" unless $!handle;
  my $err = libusb_control_transfer($!handle, $request-type, $request, $value, $index, nativecast(Pointer[uint8], $data), $length, $timeout);
  die self!get-error($err) if $err < 0;
  return $err;
}

=begin pod

=head1 NAME

LibUSB - High level binding to libusb

=head1 SYNOPSIS

=begin code :lang<raku>

use LibUSB;

=end code

=head1 DESCRIPTION

LibUSB is a Raku binding to the libusb library, allowing for access to USB devices

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
