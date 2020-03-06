BUILD_DIR := $(shell if [ ! -d "./build" ]; \
				   then `mkdir -p ./build`; fi; \
				   echo "./build")

BOOT_DIR := $(BUILD_DIR)/boot
BOOTSECT_OBJ := $(BOOT_DIR)/bootsect.o
BOOTLOADER	 := $(BOOT_DIR)/bootloader

TOOLS_DIR := $(BUILD_DIR)/tools
BOOTSIGN := $(TOOLS_DIR)/bootsign.o

DISK_IMG=disk.img

RM := rm -f
COPY := cp

all: bootdisk

.PHONY: bootdisk boot tools clean

boot: tools
	make -C boot
	ld -T ./tools/boot.ld -o $(BOOTLOADER).elf $(BOOTSECT_OBJ)
	objcopy -S -O binary $(BOOTLOADER).elf $(BOOTLOADER).o
	$(BOOTSIGN) $(BOOTLOADER).o $(BOOTLOADER)


tools:
	make -C tools

bootdisk: boot
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0 conv=notrunc
	@echo "Success!"

qemu:
	qemu-system-i386 -fda $(DISK_IMG)

bochs:
	bochs -f bochsrc.txt

clean:
	make -C boot clean
	make -C tools clean
	$(RM) $(DISK_IMG)
