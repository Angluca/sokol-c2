CC = gcc
AR = ar
CFLAGS = -Wall -Wextra -std=c99 -O2
CFLAGS+=-DSOKOL_GLCORE -DSOKOL_NO_ENTRY
LDFLAGS = 
#---------------------------------\
https://github.com/floooh/sokol
LIB_SOURCE = ~/SDK/Sokols/sokol
#C2_LIBDIR = ./
#---------------------------------
LIB_DIR = lib
OBJS = $(LIB_DIR)/sokol_impl.o
SOKOLIB = $(LIB_DIR)/libsokol.a
CGEN = ./test/output/test/cgen
CFLAGS += -I $(LIB_SOURCE)
LDFLAGS += -L$(LIB_DIR) -lsokol
ifeq ($(shell uname),Darwin)
#-------------------------------------
CFLAGS += -x objective-c # -arch x86_64
FRAMEWORKS = -framework Cocoa \
             -framework QuartzCore \
             -framework OpenGL \
			 -framework AudioToolbox \
			 -framework AVFoundation \
			 #-framework Metal \
			 -framework MetalKit \
			 -framework IOKit \
			 #-framework Foundation \
#------------------------------------
LDFLAGS += $(FRAMEWORKS)
endif
all: $(SOKOLIB)
	make test
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
 
$(SOKOLIB): $(OBJS)
	$(AR) rcs $@ $^
	ranlib $@
	c2c -d ./test
 
test: $(SOKOLIB)
ifneq ($(wildcard ./test/test),)
	@rm -f ./test/test
endif
	$(CC) $(CFLAGS) -o $(CGEN)/build.o -c $(CGEN)/build.c
	$(CC) $(LDFLAGS) -o ./test/test $(CGEN)/build.o

cc: $(SOKOLIB) # c2 to c
	c2c -d ./test

run: $(SOKOLIB)
ifeq ($(wildcard ./test/test),)
	@make test
endif
	./test/test

clean:
	rm -f $(OBJS) $(SOKOLIB) 
	rm -rf ./test/test ./test/output
 
.PHONY: all test clean cc run
