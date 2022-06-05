.PHONY: all

all: $(BUILD_DIR)/bootsect.bin $(BUILD_DIR)/kernel_entry.o

#
# compiles boot.bin with nasm
#
$(BUILD_DIR)/bootsect.bin: bootsect.asm
	$(ASM) $< -f bin -o $@

$(BUILD_DIR)/kernel_entry.o: kernel_entry.asm
	$(ASM) $< -f elf32 -o $@