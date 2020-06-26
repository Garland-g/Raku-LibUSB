class X::LibUSB::IO is Exception {
    method message() { "IO error occurred" }
}

class X::LibUSB::Invalid-Param is Exception {
    method message() { "Invalid Parameter" }
}

class X::LibUSB::Access is Exception {
    method message() { "Not authorized to access" }
}

class X::LibUSB::No-Device is Exception {
    method message() { "Device does not exist" }
}

class X::LibUSB::Not-Found is Exception {
    method message() { "No such device (may have been disconnected)" }
}

class X::LibUSB::Busy is Exception {
    method message() { "Device is busy" }
}

class X::LibUSB::Timeout is Exception {
    method message() { "Timeout" }
}

class X::LibUSB::Overflow is Exception {
    method message() { "Overflow" }
}

class X::LibUSB::Pipe is Exception {
    method message() { "Pipe error" }
}

class X::LibUSB::Interrupted is Exception {
    method message() { "System call interrupted" }
}

class X::LibUSB::No-Memory is Exception {
    method message() { "Insufficient memory" }
}

class X::LibUSB::Not-Supported is Exception {
    method message() { "Operation not supported" }
}

class X::LibUSB::Other is Exception {
    method message() { "Other error" }
}

class X::LibUSB::No-Device-Selected is Exception {
    method message() { "No device selected. Please call get-device to select a device." }
}

class X::LibUSB::Not-Open is Exception {
    method message() { "Device is not open. Please call open to open the device." }
}