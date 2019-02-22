# SpinalHDL development environment

[![Build Status](https://img.shields.io/travis/com/SpinalHDL/docker/master.svg?longCache=true&style=flat-square&logo=travis)](https://travis-ci.com/SpinalHDL/docker/branches) [![Join the chat at https://gitter.im/SpinalHDL/SpinalHDL](https://img.shields.io/badge/chat-on%20gitter-4db797.svg?longCache=true&style=flat-square&logo=gitter&logoColor=4db797)](https://gitter.im/SpinalHDL/SpinalHDL?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This repository contains utilities and sources to build docker images used in the [SpinalHDL GitHub organization](https://github.com/SpinalHDL).
All of them are periodically built at [travis-ci.com/spinalhdl](https://travis-ci.com/spinalhdl) and pushed to [hub.docker.com/u/spinalhdl](https://hub.docker.com/u/spinalhdl/):

- [![spinalhdl/dev pulls](https://img.shields.io/docker/pulls/spinalhdl/dev.svg?style=flat-square&logo=docker&logoColor=00acd3&label=spinalhdl/dev)](https://hub.docker.com/r/spinalhdl/dev/) images with development depedendencies for [SpinalHDL](https://github.com/SpinalHDL/SpinalHDL).
  - `latest`:
  - `ide`:

Other images based on these are:

- Generated in [SpinalHDL/SpinalHDL](https://github.com/SpinalHDL/SpinalHDL):

[![spinalhdl/spinalhdl pulls](https://img.shields.io/docker/pulls/spinalhdl/spinalhdl.svg?style=flat-square&logo=docker&logoColor=00acd3&label=spinalhdl/spinalhdl)](https://hub.docker.com/r/spinalhdl/spinalhdl/) images with ready-to-use releases of [SpinalHDL](https://github.com/SpinalHDL/SpinalHDL), along with...

[![spinalhdl/riscv pulls](https://img.shields.io/docker/pulls/spinalhdl/riscv.svg?style=flat-square&logo=docker&logoColor=00acd3&label=spinalhdl/riscv)](https://hub.docker.com/r/spinalhdl/riscv/) images with ready-to-use releases of [SpinalHDL](https://github.com/SpinalHDL/SpinalHDL), along with all the dependencies (including the software toolchain for RISCV).

---

See [USE_CASES.md](./USE_CASES.md) if you are looking for usage examples from a user perspective.
