TARGET = c_executable.exe
LIBS = -lm
CC = gcc
CFLAGS = -g

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = c_cover_io.o driver.o source_a.o source_b.o

c_cover_io.o: ENV_COVER_wd/ENV_COVER/c_cover_io.c ENV_COVER_wd/ENV_COVER/vcast_c_options.h
	$(CC) $(CFLAGS) -IENV_COVER -c $< -o $@

driver.o: driver.c
	$(CC) $(CFLAGS) -IENV_COVER -c $< -o $@

source_a.o: source_a.c
	$(CC) $(CFLAGS) -IENV_COVER -c $< -o $@

source_b.o: source_b.c
	$(CC) $(CFLAGS) -IENV_COVER -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-del *.o
	-del $(TARGET)
