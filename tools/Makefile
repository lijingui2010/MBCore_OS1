BUILD_DIR := $(shell if [ ! -d "../build/tools" ]; \
				   then `mkdir -p ../build/tools`; fi; \
				   echo "../build/tools")

TOOLS_SRCS := $(wildcard *.c)
TOOLS_OBJS := $(patsubst %.c, $(BUILD_DIR)/%.o, $(TOOLS_SRCS))

RM := rm -f

all: $(TOOLS_OBJS)

$(BUILD_DIR)/%.o: %.c
	gcc -O2 $< -o $@

clean:
	$(RM) $(BUILD_DIR)/*
