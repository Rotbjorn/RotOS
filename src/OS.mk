

all: $(OUTPUT_DIR)/$(OS_IMAGE)


$(OUTPUT_DIR)/$(OS_IMAGE): $(BUILD_DIR)/bootsect.bin $(BUILD_DIR)/kernel.bin
	cat $^ > $@


$(BUILD_DIR)/bootsect.bin:
	$(MAKE) -C boot -f Bootloader.mk


$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/kernel_and_drivers.elf
	$(TARGET_LD) -o $@ -Ttext 0x1000 $^ --oformat binary


#
#	Links kernel_entry + kernel + drivers into one object file
#
$(BUILD_DIR)/kernel_and_drivers.elf: $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o $(BUILD_DIR)/drivers.o
	$(TARGET_LD) -Ttext 0x1000 -o $@ $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o $(BUILD_DIR)/drivers.o

$(BUILD_DIR)/kernel_entry.o:
	$(MAKE) -C boot -f Bootloader.mk

$(BUILD_DIR)/kernel.o:
	$(MAKE) -C kernel -f Kernel.mk

$(BUILD_DIR)/drivers.o:
	$(MAKE) -C drivers -f Drivers.mk
