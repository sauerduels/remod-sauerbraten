CXX = g++
STRIP = strip
PROG = authgen
MV = mv

CXXFLAGS = -s -O2 -DSTANDALONE
INCLUDES = -I../shared -I../engine -I../fpsgame -I../enet/include -I../zlib

OBJS = authgen.o \
	../shared/crypto.o

default: all

all: $(OBJS) link

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $(subst .o,.cpp,$@) 

clean:
	rm -f ../../$(PROG) $(OBJS)

link:
	$(CXX)  $(OBJS) $(LIBS) -o $(PROG)
	$(STRIP) $(PROG)
	$(MV) $(PROG) ../../$(PROG)
