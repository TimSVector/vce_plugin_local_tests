TARGET = c_executable
LIBS = -lm
CC = gcc
CFLAGS = -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %_cfile.o, $(wildcard *.c))

ENV_COVER/c_cover_io.o: ENV_COVER/c_cover_io.c ENV_COVER/vcast_c_options.h
	$(CC) $(CFLAGS) -IENV_COVER -c $< -o $@

%_cfile.o: %.c ENV_COVER/c_cover_io.o
	$(CC) $(CFLAGS) -I. -IENV_COVER -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) ENV_COVER/c_cover_io.o -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f ENV_COVER/*.o
	-rm -f $(TARGET)
