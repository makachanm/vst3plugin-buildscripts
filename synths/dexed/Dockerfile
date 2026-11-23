FROM docker.io/library/debian:trixie

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential cmake pkg-config \
      libasound2-dev libjack-jackd2-dev libcurl4-openssl-dev libfreetype-dev libglu1-mesa-dev \
      libx11-dev libxext-dev libxinerama-dev libxrandr-dev libxcursor-dev libgtk-3-dev libwebkit2gtk-4.1-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/asb2m10/dexed.git /src

RUN cmake -S /src -B /build -DCMAKE_BUILD_TYPE=Release \
 && cmake --build /build --target Dexed_VST3 -j"$(nproc)"

RUN mkdir -p /out && find /build -type d -name '*.vst3' -path '*/VST3/*' -prune -exec cp -r {} /out/ \;
