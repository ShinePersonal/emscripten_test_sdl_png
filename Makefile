# For Linux environment
LOGGFLAGS=-Ilibogg-1.3.2/include
LOGGLIBS=-Llibogg-1.3.2/src/.libs -logg
LVORBISFLAGS=-Ilibvorbis-1.3.4/include
LVORBISLIBS=-Llibvorbis-1.3.4/lib/.libs -lvorbisfile -lvorbis
# For Windows environment
WOGGFLAGS=-Ilibogg-1.3.2/include
WOGGLIBS=-Llibogg-1.3.2/src -logg
WVORBISFLAGS=-Ilibvorbis-1.3.4/include
WVORBISLIBS=-Llibvorbis-1.3.4/lib -lvorbisfile -lvorbis

CHEWINGFLAGS=-I../libchewing-0.3.5/include
CHEWINGLIBS=-L../libchewing-0.3.5/src/.libs -lchewing

CC=emcc
CFLAGS=-O0 -g3 -Ilibpng-1.6.16 -Izlib-1.2.8 -Ijsoncpp-0.7.1/include $(WOGGFLAGS) $(WVORBISFLAGS) $(CHEWINGFLAGS)

CXX=em++
CXXFLAGS=$(CFLAGS)

EMFLAGS=-s EXPORTED_FUNCTIONS="['_main', '_initFsDone']"
LDFLAGS=-Llibpng-1.6.16/.libs -lpng16 -Lzlib-1.2.8 -lz -Ljsoncpp-0.7.1 -ljsoncpp \
	$(WVORBISLIBS) \
	$(WOGGLIBS) \
	$(CHEWINGLIBS)

OBJS=test.o data.o testogg.o interact.o

PROGRAM=program.js
PROGHTM=program.html

.PHONY: all clean html

all: $(PROGRAM)

html: $(PROGHTM)


$(PROGRAM) $(PROGHTM): $(OBJS)
	$(CXX) $(EMFLAGS) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS) --post-js post.js --emrun


clean:
	rm -f $(PROGRAM)
	rm -f $(PROGHTM)
	rm -f $(OBJS)
