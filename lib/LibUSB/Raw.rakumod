use NativeCall;

unit module LibUSB::Raw;

constant \LIB = 'usb';

subset Read-Request of Int is export where { $_ +& 0b1000000 };

subset Write-Request of Int is export where { $_ +& 0b100000 == 0 };

enum libusb_class_code is export (
  LIBUSB_CLASS_PER_INSTANCE => 0,
  LIBUSB_CLASS_AUDIO => 1,
  LIBUSB_CLASS_COMM => 2,
  LIBUSB_CLASS_HID => 3,
  LIBUSB_CLASS_PHYSICAL => 5,
  LIBUSB_CLASS_PRINTER => 7,
  LIBUSB_CLASS_PTP => 6, # legacy name from libusb-0.1 usb.h
  LIBUSB_CLASS_IMAGE => 6,
  LIBUSB_CLASS_MASS_STORAGE => 8,
  LIBUSB_CLASS_HUB => 9,
  LIBUSB_CLASS_DATA => 10,
  LIBUSB_CLASS_SMART_CARD => 0x0b,
  LIBUSB_CLASS_CONTENT_SECURITY => 0x0d,
  LIBUSB_CLASS_VIDEO => 0x0e,
  LIBUSB_CLASS_PERSONAL_HEALTHCARE => 0x0f,
  LIBUSB_CLASS_DIAGNOSTIC_DEVICE => 0xdc,
  LIBUSB_CLASS_WIRELESS => 0xe0,
  LIBUSB_CLASS_APPLICATION => 0xfe,
  LIBUSB_CLASS_VENDOR_SPEC => 0xff
);

enum libusb_descriptor_type (
  LIBUSB_DT_DEVICE => 0x01,
  LIBUSB_DT_CONFIG => 0x02,
  LIBUSB_DT_STRING => 0x03,
  LIBUSB_DT_INTERFACE => 0x04,
  LIBUSB_DT_ENDPOINT => 0x05,
  LIBUSB_DT_BOS => 0x0f,
  LIBUSB_DT_DEVICE_CAPABILITY => 0x10,
  LIBUSB_DT_HID => 0x21,
  LIBUSB_DT_REPORT => 0x22,
  LIBUSB_DT_PHYSICAL => 0x23,
  LIBUSB_DT_HUB => 0x29,
  LIBUSB_DT_SUPERSPEED_HUB => 0x2a,
  LIBUSB_DT_SS_ENDPOINT_COMPANION => 0x30
);

enum libusb_endpoint_direction (
  LIBUSB_ENDPOINT_IN => 0x80,
  LIBUSB_ENDPOINT_OUT => 0x00,
);

enum libusb_transfer_type (
  LIBUSB_TRANSFER_TYPE_CONTROL => 0,
  LIBUSB_TRANSFER_TYPE_ISOCHRONOUS => 1,
  LIBUSB_TRANSFER_TYPE_BULK => 2,
  LIBUSB_TRANSFER_TYPE_INTERRUPT => 3,
  LIBUSB_TRANSFER_TYPE_BULK_STREAM => 4,
);

enum libusb_standard_request (
  LIBUSB_REQUEST_GET_STATUS => 0x00,
  LIBUSB_REQUEST_CLEAR_FEATURE => 0x01,
  # 0x02 is reserved
  LIBUSB_REQUEST_SET_FEATURE => 0x03,
  # 0x04 is reserved
  LIBUSB_REQUEST_SET_ADDRESS => 0x05,
  LIBUSB_REQUEST_GET_DESCRIPTOR => 0x06,
  LIBUSB_REQUEST_SET_DESCRIPTOR => 0x07,
  LIBUSB_REQUEST_GET_CONFIGURATION => 0x08,
  LIBUSB_REQUEST_SET_CONFIGURATION => 0x09,
  LIBUSB_REQUEST_GET_INTERFACE => 0x0A,
  LIBUSB_REQUEST_SET_INTERFACE => 0x0B,
  LIBUSB_REQUEST_SYNCH_FRAME => 0x0C,
  LIBUSB_REQUEST_SET_SEL => 0x30,
  LIBUSB_SET_ISOCH_DELAY => 0x31,
);

enum libusb_request_type (
  LIBUSB_REQUEST_TYPE_STANDARD => 0x00 +< 5,
  LIBUSB_REQUEST_TYPE_CLASS => 0x01 +< 5,
  LIBUSB_REQUEST_TYPE_VENDOR => 0x02 +< 5,
  LIBUSB_REQUEST_TYPE_RESERVED => 0x03 +< 5,
);

enum libusb_request_recipient (
  LIBUSB_RECIPIENT_DEVICE => 0x00,
  LIBUSB_RECIPIENT_INTERFACE => 0x01,
  LIBUSB_RECIPIENT_ENDPOINT => 0x02,
  LIBUSB_RECIPIENT_OTHER => 0x03,
);

enum libusb_iso_sync_type is export (
   LIBUSB_ISO_SYNC_TYPE_NONE => 0,
   LIBUSB_ISO_SYNC_TYPE_ASYNC => 1,
   LIBUSB_ISO_SYNC_TYPE_ADAPTIVE => 2,
   LIBUSB_ISO_SYNC_TYPE_SYNC => 3
);
enum libusb_iso_usage_type is export (
   LIBUSB_ISO_USAGE_TYPE_DATA => 0,
   LIBUSB_ISO_USAGE_TYPE_FEEDBACK => 1,
   LIBUSB_ISO_USAGE_TYPE_IMPLICIT => 2
);

enum libusb_speed is export (
  LIBUSB_SPEED_UNKNOWN => 0,
  LIBUSB_SPEED_LOW => 1,
  LIBUSB_SPEED_FULL => 2,
  LIBUSB_SPEED_HIGH => 3,
  LIBUSB_SPEED_SUPER => 4,
  LIBUSB_SPEED_SUPER_PLUS => 5,
);

enum libusb_supported_speed is export (
  LIBUSB_LOW_SPEED_OPERATION => 1,
  LIBUSB_FULL_SPEED_OPERATION => 2,
  LIBUSB_HIGH_SPEED_OPERATION => 4,
  LIBUSB_SUPER_SPEED_OPERATION => 8,
);

enum libusb_usb_2_0_extension_attributes is export (
   LIBUSB_BM_LPM_SUPPORT => 2
);

enum libusb_ss_usb_device_capability_attributes is export (
   LIBUSB_BM_LTM_SUPPORT => 2
);

enum libusb_bos_type is export (
   LIBUSB_BT_WIRELESS_USB_DEVICE_CAPABILITY => 1,
   LIBUSB_BT_USB_2_0_EXTENSION => 2,
   LIBUSB_BT_SS_USB_DEVICE_CAPABILITY => 3,
   LIBUSB_BT_CONTAINER_ID => 4
);

enum libusb_error is export (
   LIBUSB_SUCCESS => 0,
   LIBUSB_ERROR_IO => -1,
   LIBUSB_ERROR_INVALID_PARAM => -2,
   LIBUSB_ERROR_ACCESS => -3,
   LIBUSB_ERROR_NO_DEVICE => -4,
   LIBUSB_ERROR_NOT_FOUND => -5,
   LIBUSB_ERROR_BUSY => -6,
   LIBUSB_ERROR_TIMEOUT => -7,
   LIBUSB_ERROR_OVERFLOW => -8,
   LIBUSB_ERROR_PIPE => -9,
   LIBUSB_ERROR_INTERRUPTED => -10,
   LIBUSB_ERROR_NO_MEM => -11,
   LIBUSB_ERROR_NOT_SUPPORTED => -12,
   LIBUSB_ERROR_OTHER => -99
);

enum libusb_transfer_status is export (
   LIBUSB_TRANSFER_COMPLETED => 0,
   LIBUSB_TRANSFER_ERROR => 1,
   LIBUSB_TRANSFER_TIMED_OUT => 2,
   LIBUSB_TRANSFER_CANCELLED => 3,
   LIBUSB_TRANSFER_STALL => 4,
   LIBUSB_TRANSFER_NO_DEVICE => 5,
   LIBUSB_TRANSFER_OVERFLOW => 6
);

enum libusb_transfer_flags is export (
   LIBUSB_TRANSFER_SHORT_NOT_OK => 1,
   LIBUSB_TRANSFER_FREE_BUFFER => 2,
   LIBUSB_TRANSFER_FREE_TRANSFER => 4,
   LIBUSB_TRANSFER_ADD_ZERO_PACKET => 8
);

enum libusb_capability is export (
   LIBUSB_CAP_HAS_CAPABILITY => 0,
   LIBUSB_CAP_HAS_HOTPLUG => 1,
   LIBUSB_CAP_HAS_HID_ACCESS => 256,
   LIBUSB_CAP_SUPPORTS_DETACH_KERNEL_DRIVER => 257
);

enum libusb_log_level is export (
   LIBUSB_LOG_LEVEL_NONE => 0,
   LIBUSB_LOG_LEVEL_ERROR => 1,
   LIBUSB_LOG_LEVEL_WARNING => 2,
   LIBUSB_LOG_LEVEL_INFO => 3,
   LIBUSB_LOG_LEVEL_DEBUG => 4
);

enum libusb_log_cb_mode is export (
   LIBUSB_LOG_CB_GLOBAL => 1,
   LIBUSB_LOG_CB_CONTEXT => 2
);

enum libusb_hotplug_flag is export (
   LIBUSB_HOTPLUG_NO_FLAGS => 0,
   LIBUSB_HOTPLUG_ENUMERATE => 1
);

enum libusb_hotplug_event is export (
   LIBUSB_HOTPLUG_EVENT_DEVICE_ARRIVED => 1,
   LIBUSB_HOTPLUG_EVENT_DEVICE_LEFT => 2
);

enum libusb_option is export (
   LIBUSB_OPTION_LOG_LEVEL => 0,
   LIBUSB_OPTION_USE_USBDK => 1
);

class libusb_context is repr('CPointer') is export {}

class libusb_handle is repr('CPointer') is export {}

class libusb_device is repr('CPointer') is export {}

class libusb_device_handle is repr('CPointer') is export {}

class libusb_device_descriptor is repr('CStruct') is export {
  has uint8 $.bLength;
  has uint8 $.bDescriptorType;
  has uint16 $.bcdUSB;
  has uint8 $.bDeviceClass;
  has uint8 $.bDeviceSubClass;
  has uint8 $.bDeviceProtocol;
  has uint8 $.bMaxPacketSize0;
  has uint16 $.idVendor;
  has uint16 $.idProduct;
  has uint16 $.bcdDevice;
  has uint8 $.iManufacturer;
  has uint8 $.iProduct;
  has uint8 $.iSerialNumber;
  has uint8 $.bNumConfigurations;
}

class libusb_endpoint_descriptor is repr('CStruct') is export {
  has uint8 $.bLength;
  has uint8 $.bDescriptorType;
  has uint8 $.bEndpointAddress;
  has uint8 $.bmAttributes;
  has uint16 $.wMaxPacketSize;
  has uint8 $.bRefresh;
  has uint8 $.bSynchAddress;
  has Pointer[uint8] $.extra;
  has int32 $.extra_length;
}

class libusb_interface_descriptor is repr('CStruct') is export {
  has uint8 $.bLength;
  has uint8 $.bDescriptorType;
  has uint8 $.bInterfaceNumber;
  has uint8 $.bAlternateSetting;
  has uint8 $.bNumEndpoints;
  has uint8 $.bInterfaceClass;
  has uint8 $.bInterfaceSubClass;
  has uint8 $.bInterfaceProtocol;
  has libusb_endpoint_descriptor $.endpoint; #Array. How to access?
  has Pointer[uint8] $.extra;
  has int32 $.extra_length;
}

class libusb_interface is repr('CStruct') is export {
  has libusb_interface_descriptor $.altsetting; #Array. How to access?
  has int32 $.num_altsetting;
}

class libusb_config_descriptor is repr('CStruct') is export {
  has uint8 $.bLength;
  has uint8 $.bDescriptorType;
  has uint16 $.wTotalLength;
  has uint16 $.bNumInterfaces;
  has uint8 $.bConfigurationValue;
  has uint8 $.iConfiguration;
  has uint8 $.bmAttributes;
  has uint8 $.MaxPower;
  has libusb_interface $.interface; #Array. How to access?
  has Pointer[uint8] $.extra;
  has int32 $.extra_length;
}

sub libusb_bulk_transfer(libusb_device_handle, uint8 $endpoint, Pointer[uint8] $data, int32 $length, int32 $transferred is rw, uint32 $timeout) returns int32 is native(LIB) is export { ... }

sub libusb_close(libusb_device_handle) is native(LIB) is export { ... }

sub libusb_control_transfer(libusb_device_handle, uint8 $bmRequestType, uint8 $bRequest, uint16 $wValue, uint16 $wIndex, Pointer[uint8] $data, uint16 $wLength, uint32 $timeout) returns int32 is native(LIB) is export { ... }

sub libusb_exit(libusb_context) returns int32 is native(LIB) is export { ... }

sub libusb_free_device_list(Pointer[libusb_device], int32 $unref_devices) is native(LIB) is export { ... }

sub libusb_get_bus_number(libusb_device) returns uint8 is native(LIB) is export { ... }

sub libusb_get_configuration(libusb_device_handle, int32 $config is rw) returns int32 is native(LIB) is export { ... }

sub libusb_get_device(libusb_device_handle) returns libusb_device is native(LIB) is export { ... }

sub libusb_get_device_address(libusb_device) returns uint8 is native(LIB) is export { ... }

sub libusb_get_device_descriptor(libusb_device, libusb_device_descriptor is rw) returns int32 is native(LIB) is export { ... }

sub libusb_get_device_list(libusb_context, int64 is rw) returns ssize_t is native(LIB) is export { ... }

sub libusb_get_device_speed(libusb_device) returns int32 is native(LIB) is export { ... }

sub libusb_get_max_packet_size(libusb_device, uint8 $endpoint) returns int32 is native(LIB) is export { ... }

sub libusb_get_max_iso_packet_size(libusb_device, uint8 $endpoint) returns int32 is native(LIB) is export { ... }

sub libusb_get_parent(libusb_device) returns libusb_device is native(LIB) is export { ... }

sub libusb_get_port_number(libusb_device) returns uint8 is native(LIB) is export { ... }

sub libusb_get_port_numbers(libusb_device, CArray[uint8] $port_numbers, int32 $port_numbers_len) returns int32 is native(LIB) is export { ... }

sub libusb_init(libusb_context is rw) returns int32 is native(LIB) is export { ... }

sub libusb_interrupt_transfer(libusb_device_handle, uint8 $endpoint, Pointer[uint8] $data, int32 $length, int32 $transferred is rw, uint32 $timeout) returns int32 is native(LIB) is export { ... }

sub libusb_open(libusb_device, libusb_device_handle is rw) returns int32 is native(LIB) is export { ... }

sub libusb_open_device_with_vid_pid(libusb_context, uint16 $vendor_id, uint16 $product_id) returns libusb_device_handle is native(LIB) is export { ... }

sub libusb_ref_device(libusb_device) returns libusb_device is native(LIB) is export { ... }

sub libusb_set_auto_detach_kernel_driver(libusb_device_handle, int32 $enable) returns int32 is native(LIB) is export { ... }

sub libusb_set_configuration(libusb_device_handle, int32 $config) returns int32 is native(LIB) is export { ... }

sub libusb_unref_device(libusb_device) is native(LIB) is export { ... }

sub libusb_wrap_sys_device(libusb_context, Pointer[int32] $sys_dev, libusb_device_handle $dev_handle is rw) returns int32 is native(LIB) is export { ... }
