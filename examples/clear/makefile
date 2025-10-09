CC = gcc
AR = ar
CFLAGS=-Wall -Wextra -Wno-unused -Wno-switch
CFLAGS+= -Wno-unused-parameter -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2
CFLAGS+= -DSOKOL_GLCORE -DSOKOL_NO_ENTRY
LDFLAGS= 
#---------------------------------\
https://github.com/floooh/sokol
# sokol_impl.c in LIB_DIR, build lib when hasn't libsokol.a
LIB_SOURCE= ~/SDK/Sokols/sokol
LIB_DIR= ../../lib
APP_NAME= clear
APP_PATH= 

#=================================
OBJS= $(LIB_DIR)/sokol_impl.o
SOKOLIB= $(LIB_DIR)/libsokol.a
CFLAGS+= -I $(LIB_SOURCE)
LDFLAGS+= -L $(LIB_DIR) -lsokol
#------------------------------------
APP=  $(APP_NAME)
CGEN= output/$(APP_NAME)/cgen
ifneq ($(wildcard $(APP_PATH)),)
APP=  $(APP_PATH)/$(APP_NAME)
CGEN= $(APP_PATH)/output/$(APP_NAME)/cgen
endif #==============================
ifeq ($(shell uname),Darwin)
CFLAGS+= -x objective-c # -arch x86_64
FRAMEWORKS= -framework Cocoa \
             -framework QuartzCore \
             -framework OpenGL \
			 -framework AudioToolbox \
			 -framework AVFoundation \
			 #-framework Metal \
			 -framework MetalKit \
			 #-framework IOKit \
			 #-framework Foundation
#------------------------------------
BUILD= $(CGEN)/build
LDFLAGS+= $(FRAMEWORKS)
endif #==============================

all: cc $(APP)

$(APP): $(BUILD).o getlib
	$(CC) $(LDFLAGS) -o ./$@ ./$<

$(BUILD).o: $(BUILD).c
	$(CC) $(CFLAGS) -o ./$@ -c ./$<

$(SOKOLIB): $(OBJS)
	$(AR) rcs $@ $^
	ranlib $@

getlib:
ifeq ($(wildcard $(SOKOLIB)),)
	@make $(SOKOLIB)
endif #==============================
 
cc:
ifneq ($(wildcard $(APP_PATH)),)
	c2c -d ./$(APP_PATH)
else
	c2c 
endif #==============================

run: 
	@make && ./$(APP)

clean:
	rm -rf ./$(APP) ./$(APP_PATH)/output ./$(OBJS)

cleanall:
	rm -rf ./$(APP) ./$(APP_PATH)/output ./$(OBJS)
	@rm -i ./$(SOKOLIB) 
	$(info "--- if you want del libsokol.a press [y] ---")
 
.PHONY: all clean cleanall cc run
