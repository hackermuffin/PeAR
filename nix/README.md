# Nix Build Files

This (along with the flake.*) in the root dir provides all the requirements to build and run PeAR and it's dependencies under [Nix](https://nixos.org/).

You can use this in a few ways, all of which will need a nix installation.

The first time you try to run the nix managed version of PeAR, it will need to build `ddisasm` from source, which can take 20-40+ minutes.

### Just run PeAR

```
nix run github:<owner>/<name> -- <pear-args>
```

e.g. `nix run github:hackermuffin/PeAR -- --input-binary ./binary --output-dir ./build --gen-binary AFL++`

### Run your own version of the PeAR with nix

First, clone the repo locally, make any changes, then in the root :

`nix run <path-to-repo>\#pear -- <pear-args>`

e.g. `nix run .\#pear -- <args>` from the project root.

Also, if you want to run some of the other dependencies, you can also run either `ddisasm` or `gtrib-pprinter`:

```
nix run .\#ddisasm -- <args>
nix run .\#gtirb-pprinter -- <args>
```

### Launch a dev shell

Alternatively, you can launch a development shell with useful PeAR dependencies loaded in:

```
nix develop
```

This add binaries for `pear`, `ddisasm`, `gtirb-pprinter` and `python3` with appropriate dependencies available in path.

If you have [devenv](https://devenv.sh/) installed, then the dev environment will get auto loaded on entering the directory.


