include toolchain/config.mk
include Project.mk

# Project directories
export SRC_DIR=$(realpath src)
export BUILD_DIR:=$(addprefix $(realpath .)/, build)
export OUTPUT_DIR:=$(addprefix $(realpath .)/, output)
export INCLUDE_DIRS:=$(addprefix -I, $(realpath src/kernel src/drivers))


.PHONY: all clean run rebuild debug deps 

# all directive
all: deps


#
# cleans build directory
#
clean:
	rm -r $(BUILD_DIR)
	rm -r $(OUTPUT_DIR)


#
# runs bootloader with qemu
#
run:
	$(QEMU) -drive format=raw,file=$(OUTPUT_DIR)/$(OS_IMAGE)


#
# rebuilds the project
#
rebuild: clean all


debug: deps
	$(QEMU) -s -S -drive format=raw,file=$(OUTPUT_DIR)/$(OS_IMAGE) &
	$(TARGET_GDB) -ex "target remote localhost:1234" -ex "symbol-file $(BUILD_DIR)/kernel_and_drivers.elf"

#
# Builds all dependencies for bootloader
#
deps: $(BUILD_DIR) $(OUTPUT_DIR)
	$(MAKE) -C src -f OS.mk


#
# mkdirs the build directory
#
$(BUILD_DIR):
	mkdir $@

#
# mkdirs the output directory
#
$(OUTPUT_DIR):
	mkdir $@


