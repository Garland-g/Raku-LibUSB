use v6;
use Test;
use LibUSB;

ok LibUSB.^can('init'), <Init>;

ok LibUSB.^can('open'), <Open>;

ok LibUSB.^can('close'), <Close>;

ok LibUSB.^can('exit'), <Exit>;

ok LibUSB.^can('control-transfer'), <Control Transfer>;

todo 'Bulk Transfer not implemented';
ok LibUSB.^can('bulk-transfer'), <Bulk Transfer>;

todo 'Interrupt Transfer not implemented';
ok LibUSB.^can('interrupt-transfer'), <Interrupt Transfer>;

done-testing;
