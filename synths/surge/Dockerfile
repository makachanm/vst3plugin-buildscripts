FROM docker.io/library/debian:trixie

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential cmake pkg-config python3 \
      libcairo2-dev libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor-dev libxcb-keysyms1-dev libxcb-util-dev \
      libxrandr-dev libxinerama-dev libxcursor-dev libfreetype-dev libfontconfig-dev libasound2-dev libjack-jackd2-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/surge-synthesizer/surge.git /src

RUN cmake -S /src -B /build -DCMAKE_BUILD_TYPE=Release \
 && cmake --build /build --target surge-xt_VST3 surge-fx_VST3 -j"$(nproc)"

# Surge looks for a "SurgeXTData" folder in the directories above its .so,
# so one copy next to the bundles serves both plugins
RUN mkdir -p /out \
 && find /build -type d -name '*.vst3' -path '*/VST3/*' -prune -exec cp -r {} /out/ \; \
 && cp -r /src/resources/data /out/SurgeXTData
