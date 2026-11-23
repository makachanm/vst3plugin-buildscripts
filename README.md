# vst3plugin-buildscripts

Build Linux VST3 plugins with Docker/Podman.

`make` and `docker` or `podman` is required.

- `dexed` — [asb2m10/dexed](https://github.com/asb2m10/dexed)
- `chowmatrix` — [Chowdhury-DSP/ChowMatrix](https://github.com/Chowdhury-DSP/ChowMatrix)
- `chowmultitool` — [Chowdhury-DSP/ChowMultiTool](https://github.com/Chowdhury-DSP/ChowMultiTool)

```sh
make all          # build everything

make dexed         # build dexed
make chowmatrix    # build chowmatrix
make chowmultitool # build chowmultitool

make install      # copy built plugins to ~/.vst3
make clean        # clear out/
```

Output goes to `out/<synth>/`.
