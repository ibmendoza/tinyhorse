PONYCFLAGS =
GAMECORESRC = gamecore/constants.pony gamecore/events.pony gamecore/sform.pony gamecore/utils.pony
SDLSRC = sdl/sdl.pony
CLIENTSRC = client/client.pony
SERVERSRC = server/server.pony
MKDIR_P = mkdir -p

.PHONY: test all clean debug directories

all: directories build/client build/server

debug: PONYCFLAGS += --debug
debug: directories build/clientd build/serverd

build/client: $(CLIENTSRC) $(GAMECORESRC) $(SDLSRC)
	ponyc client -o build $(PONYCFLAGS)

build/server: $(SERVERSRC) $(GAMECORESRC)
	ponyc server -o build $(PONYCFLAGS)

build/clientd: $(CLIENTSRC) $(GAMECORESRC) $(SDLSRC)
	ponyc client -o build -b clientd $(PONYCFLAGS)

build/serverd: $(SERVERSRC) $(GAMECORESRC)
	ponyc server -o build -b serverd $(PONYCFLAGS)

build/sdl: $(SDLSRC) sdl/_test.pony
	ponyc sdl -o build --debug

build/gamecore: $(GAMECORESRC) gamecore/_test.pony
	ponyc gamecore -o build --debug

directories: build

build:
	${MKDIR_P} build

test: build/sdl build/gamecore
	build/sdl
	build/gamecore

clean:
	rm -rf build
