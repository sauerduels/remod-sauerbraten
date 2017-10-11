########### CONFIGURATION ############

#Use geoip module?  true|false 
USE_GEOIP=true

#Use irc bot? true|false
USE_IRCBOT=false

#Use system libs
USE_SYSTEM_LIBS=false
######################################

### Tools
CXX=gcc
MV=mv
STRIP=strip


PLATFORM=$(shell uname -s)

# Use clang on freebsd
# Comment next lines if server not building or you want to use old GCC
ifneq (,$(findstring FreeBSD,$(PLATFORM)))
CXX=clang
endif

#result file name
PLATFORM_SUFFIX=
ifneq (,$(findstring x86_64,$(shell uname -a)))
PLATFORM_SUFFIX=
endif
ifneq (,$(findstring amd64,$(shell uname -a)))
PLATFORM_SUFFIX=
endif

SERVER_PREFIX=server
SERVER_NAME=$(SERVER_PREFIX)
ifneq (,$(findstring MINGW,$(PLATFORM)))
SERVER_NAME=$(SERVER_NAME)$(PLATFORM_SUFFIX).exe
endif
ifneq (,$(findstring Linux,$(PLATFORM)))
SERVER_NAME=$(SERVER_PREFIX)$(PLATFORM_SUFFIX)
endif
ifneq (,$(findstring FreeBSD,$(PLATFORM)))
SERVER_NAME=$(SERVER_PREFIX)_freebsd$(PLATFORM_SUFFIX)
endif

### Directories, libraries, includes
ifneq (,$(findstring MINGW,$(PLATFORM)))
SERVER_INCLUDES+= -DSTANDALONE $(INCLUDES) -Iinclude
SERVER_LIBS= -Llib -lzdll -lenet -lws2_32 -lwinmm -lstdc++
else
SERVER_INCLUDES+= -DSTANDALONE $(INCLUDES)
SERVER_LIBS= -L/usr/local/lib -lenet -lz -lstdc++ -lm
endif

ifeq ($(PLATFORM),SunOS)
SERVER_LIBS+= -lsocket -lnsl
endif

CXXFLAGS=-fomit-frame-pointer -Wall -fsigned-char -DSTANDALONE

INCLUDES= -Ishared -Iengine -Ifpsgame -Imod -Imod/hashlib2plus/src -Imod/cryptomod/polarssl/include

### System Libs
ifeq ($(USE_SYSTEM_LIBS),true)
else
override INCLUDES += -Ienet/include -Izlib
override SERVER_LIBS += -Lenet -Lzlib
endif

SERVER_OBJS= \
	shared/crypto-standalone.o \
	shared/stream-standalone.o \
	shared/tools-standalone.o \
	engine/worldio-standalone.o \
	engine/command-standalone.o \
	engine/server-standalone.o \
	fpsgame/entities-standalone.o \
	fpsgame/server-standalone.o \
	mod/commandev-standalone.o \
	mod/commandhandler-standalone.o \
	mod/serverctrl-standalone.o \
	mod/remod-standalone.o \
	mod/rconmod-standalone.o \
	mod/rconmod_tcp-standalone.o \
	mod/rconmod_udp-standalone.o \
	mod/varbox-standalone.o \
	mod/cryptomod-standalone.o \
	mod/cryptomod/polarssl/library/md5-standalone.o \
	mod/cryptomod/polarssl/library/sha1-standalone.o \
	mod/cryptomod/polarssl/library/sha2-standalone.o \
	mod/cryptomod/polarssl/library/sha4-standalone.o \
      	mod/banlist-standalone.o \
	mod/jsonbanlist-standalone.o


ENET_OBJS= \
	callbacks.o \
	compress.o \
	host.o \
	list.o \
	packet.o \
	peer.o \
	protocol.o \
	unix.o \
	win32.o


### Options checks



#geoip
ifeq ($(USE_GEOIP),true)
override CXXFLAGS+= -DGEOIP -DGEOIPDATADIR -DPACKAGE_VERSION=\"1.6.11\"
override INCLUDES+= -Imod/libGeoIP/
override SERVER_OBJS+= \
        mod/geoipmod2-standalone.o \
	mod/libGeoIP/GeoIP-standalone.o \
	mod/libGeoIP/GeoIPCity-standalone.o \
        mod/libGeoIP/GeoIP_deprecated-standalone.o
endif
#end of geoip

#irc
ifeq ($(USE_IRCBOT),true)
override CXXFLAGS+= -DIRC
override SERVER_OBJS+= mod/irc-standalone.o
endif
#end of irc



default: release

release: release-flags 
release-flags: override CXXFLAGS+=-O2 -s
release-flags: build


debug: debug-flags 
debug-flags: override CXXFLAGS+=-O0 -g -DDEBUG -DDEBUG_SQL
debug-flags: build

build: revision server

revision:
SVNVERSION= $(shell svnversion -cn . 2>/dev/null | sed -e "s/.*://" -e "s/\([0-9]*\).*/\1/" | grep "[0-9]") 
ifneq "$(SVNVERSION)" " "
override CXXFLAGS+= -DREMOD_VERSION="\"SVN build rev: $(SVNVERSION)\""
endif
	
libenet:
	$(MAKE) -C enet CC='$(CC)' AR='$(AR)'

clean-enet: enet/Makefile
	-$(RM) libenet.a $(ENET_OBJS)

libz:
	cd zlib; ./configure; $(MAKE)

clean-zlib:
	$(MAKE) -C zlib/ distclean

geoip/Makefile:
	cd mod/GeoIP; chmod +x configure; ./configure --enable-shared=no --enable-static=yes

libgeoip: geoip/Makefile
	$(MAKE)	-C mod/GeoIP/libGeoIP/ all

clean-geoip: geoip/Makefile
	$(MAKE) -C mod/GeoIP/libGeoIP/ maintainer-clean

clean: clean-enet clean-zlib
	-$(RM) $(SERVER_OBJS) 

%.h.gch: %.h
	$(CXX) $(CXXFLAGS) -o $@.tmp $(subst .h.gch,.h,$@)
	$(MV) $@.tmp $@

%-standalone.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $(subst -standalone.o,.cpp,$@) 

%-standalone.o: %.c
	$(CXX) $(CXXFLAGS) -c -o $@ $(subst -standalone.o,.c,$@)	


$(SERVER_OBJS): CXXFLAGS += $(SERVER_INCLUDES)

ifneq (,$(findstring MINGW,$(PLATFORM)))
server: $(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(SERVER_NAME) $(SERVER_OBJS) $(SERVER_LIBS)

else
ifeq ($(USE_SYSTEM_LIBS),true)
server:	$(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(SERVER_NAME) $(SERVER_OBJS) $(SERVER_LIBS)  
	$(MV) $(SERVER_NAME) ../$(SERVER_NAME)
else
server:	libenet libz $(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(SERVER_NAME) $(SERVER_OBJS) $(SERVER_LIBS)  
	$(MV) $(SERVER_NAME) ../$(SERVER_NAME)
endif

