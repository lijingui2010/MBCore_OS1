BUILD_DIR := $(shell if [ ! -d "../build/boot" ]; \
				   then `mkdir -p ../build/boot`; fi; \
				   echo "../build/boot")

BOOTLOADER_SRCS := $(wildcard *.asm)
BOOTLOADER_OBJS := $(patsubst %.asm, $(BUILD_DIR)/%.o, $(BOOTLOADER_SRCS))

RM := rm -f

all: $(BOOTLOADER_OBJS)

$(BUILD_DIR)/%.o: %.asm
	nasm -f elf $< -o $@

clean:
	$(RM) $(BUILD_DIR)/*
