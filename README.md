# TOPPERS/ASP3 Nucleo-F767ZI

This repositoy provides TOPPERS/ASP3 kernel for [STM32 NUCLEO-F767ZI](https://www.st.com/en/evaluation-tools/nucleo-f767zi.html).
[TOPPERS Project](https://www.toppers.jp/en/project.html) is Japanese NPO that researches and develops the high-quality platforms for embedded systems.

We use this repository as a component of [mros2-asp3-f767zi](https://github.com/mROS-base/mros2-asp3-f767zi), by adding some modifications from [the original repository implemented by @yurie](https://github.com/yurie/asp3-f767zi). So the base branch of this repository has been changed to `mros2`.

## How to build `sample1` app (without mros feature)

Currently, we should use **arm-none-eabi 7.3.1** which can be installed with STM32CubeIDE v1.5.0. (detail: [#5](https://github.com/mROS-base/asp3-f767zi/issues/5))

```
# Clone repositories
$ git clone https://github.com/mROS-base/asp3-f767zi
$ git clone https://github.com/mROS-base/STM32CubeF7

# Build binary
$ cd asp3-f767zi/OBJ
$ make

# Copy binary to the board
$ cp asp.bin /media/$USER/NODE_F767ZI/

# Connect with picocom
$ sudo picocom -b 115200 /dev/ttyACM0
```

## License

[TOPPERS License](https://www.toppers.jp/en/license.html)
