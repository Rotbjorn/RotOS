.PHONY: all

OBJECT=kernel.o

CUR_BUILD_DIR:=$(addprefix $(BUILD_DIR), /kernel)

SRCS:=$(wildcard *.c)
OBJS:=$(SRCS:c=o)
OBJS:=$(patsubst %.o, $(CUR_BUILD_DIR)/%.o, $(OBJS))

#echoes:
#	echo SRCS: $(SRCS)
#	echo OBJS: $(OBJS)

all: $(CUR_BUILD_DIR) $(OBJS) $(BUILD_DIR)/$(OBJECT)

$(CUR_BUILD_DIR):
	mkdir $(CUR_BUILD_DIR)


$(OBJS): $(CUR_BUILD_DIR)/%.o : %.c
	$(TARGET_CC) $(TARGET_CFLAGS) $(INCLUDE_DIRS) -c -o $@ $< 

$(BUILD_DIR)/$(OBJECT):
	$(TARGET_LD) -relocatable -o $@ $(OBJS)
