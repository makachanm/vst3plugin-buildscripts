SYNTHS := $(notdir $(patsubst %/,%,$(wildcard synths/*/)))
ENGINE ?= $(shell if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then echo docker; \
                  elif command -v podman >/dev/null 2>&1; then echo podman; fi)
VST3_DIR ?= $(HOME)/.vst3

.PHONY: all clean install $(SYNTHS)

all: $(SYNTHS)

$(SYNTHS):
	@test -n "$(ENGINE)" || { echo "please install docker or podman" >&2; exit 1; }
	$(ENGINE) build -t vst3-builder-$@ synths/$@
	rm -rf out/$@ && mkdir -p out/$@
	id=$$($(ENGINE) create vst3-builder-$@) && \
	  $(ENGINE) cp $$id:/out/. out/$@/; rc=$$?; \
	  $(ENGINE) rm $$id >/dev/null; exit $$rc
	@echo "완료: $(CURDIR)/out/$@"

# REAPER scans ~/.vst3 by default
install:
	@test -d out || { echo "nothing built yet, run make first" >&2; exit 1; }
	mkdir -p $(VST3_DIR)
	for d in out/*/; do cp -r $$d. $(VST3_DIR)/; done

clean:
	rm -rf out
