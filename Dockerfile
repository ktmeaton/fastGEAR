# Original: https://github.com/virtual-imaging-platform/Matlab-Compiler-Runtime-Docker/blob/master/Dockerfile.2016a
from centos:centos7
RUN yum update -y
RUN yum install wget unzip libXext libXt-devel libXmu mesa-libGLU libXrandr -y

RUN mkdir /mcr-install

# Copy MCR
# COPY MCR_R2016a_glnxa64_installer.zip /mcr-install
# Download MCR
RUN cd /mcr-install && wget -nv http://www.mathworks.com/supportfiiles/downloads/R2016a/deployment_files/R2016a/installers/glnxa64/MCR_R2016a_glnxa64_installer.zip

RUN cd /mcr-install && \
  unzip MCR_R2016a_glnxa64_installer.zip && \
	./install -mode silent -agreeToLicense yes

RUN rm -Rf /mcr-install
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/MATLAB/MATLAB_Runtime/v901/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v901/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v901/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v901/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:/usr/local/MATLAB/MATLAB_Runtime/v901/sys/java/jre/glnxa64/jre/lib/amd64/server:/usr/local/MATLAB/MATLAB_Runtime/v901/sys/java/jre/glnxa64/jre/lib/amd64
ENV XAPPLRESDIR=/usr/local/MATLAB/MATLAB_Runtime/v901/X11/app-defaults
ENV MCR_CACHE_VERBOSE=true
ENV MCR_CACHE_ROOT=/tmp

RUN mkdir /fastGEAR 

# Copy fastGEAR
# COPY fastGEARpackageLinux64bit.tar.gz /fastGEAR
# Download fastGEAR
RUN cd /fastGEAR && wget -nv https://users.ics.aalto.fi/pemartti/fastGEAR/fastGEARpackageLinux64bit.tar.gz

RUN cd /fastGEAR && \
		tar -xvf fastGEARpackageLinux64bit.tar.gz && \
		mv fastGEARpackageLinux64bit/* . && \
		rm -f fastGEARpackageLinux64bit.tar.gz && \
		rm -rf fastGEARpackageLinux64bit && \
		chmod -R 777 *

RUN ln -s /fastGEAR/fastGEAR /usr/local/bin/fastGEAR && \
    ln -s /fastGEAR/plotRecombinations /usr/local/bin/plotRecombinations && \
		ln -s /fastGEAR/plotColors /usr/local/bin/plotColors && \
		ln -s /fastGEAR/plotMarginalsForStrain /usr/local/bin/plotMarginalsForStrain

# Set default specs to complete output
RUN sed -i '$ s/1 #/0 #/g' /fastGEAR/fG_input_specs.txt

WORKDIR /fastGEAR

