obj-m += module.o
KDIR ?= /
KVER ?= $(shell uname -r)

-include version.mk

all: dwarf 

dwarf: module.c
	$(MAKE) -C /lib/modules/$(KVER)/build CONFIG_DEBUG_INFO=y M="$(PWD)" modules
	cp module.ko ../Details/
	$(MAKE) -C /lib/modules/$(KVER)/build M="$(PWD)" clean

clean:
	$(MAKE) -C /lib/modules/$(KVER)/build M="$(PWD)" clean
	rm -f module.dwarf
