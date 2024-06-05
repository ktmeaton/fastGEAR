# fastGEAR

- This repository contains a Dockerfile to run the recombination detection program [fastGEAR](https://users.ics.aalto.fi/pemartti/fastGEAR/).
- It is based on [this image for Matlab Runtime](https://github.com/virtual-imaging-platform/Matlab-Compiler-Runtime-Docker/blob/master/Dockerfile.2016a) by @virtual-imaging-platform.

## Install

1. Run recombination detection.

    ```bash
    docker run --rm -v $(pwd):/output ktmeaton/fastgear:latest \
      fastGEAR data3_many/alignment-rec.fa /output/data3_many_res.mat fG_input_specs.txt
    ```

## Build

```bash
git clone https://github.com/ktmeaton/fastGEAR.git
cd fastGEAR
docker build -t fastgear:latest .
```
