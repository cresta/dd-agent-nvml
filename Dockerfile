FROM datadog/agent:7.16.1
ARG GPUSTAT_VERSION=cdf8a37c960325f121dad08d6e77684de3b3c43e

RUN mkdir -p /checks.d
RUN curl https://raw.githubusercontent.com/henry0312/datadog-gpustat/${GPUSTAT_VERSION}/gpu_stat.py > /checks.d/gpu_stat.py
RUN curl https://raw.githubusercontent.com/henry0312/datadog-gpustat/${GPUSTAT_VERSION}/requirementst.txt > /requirements.txt
RUN /opt/datadog-agent/embedded/bin/pip install -r requirements.txt
RUN rm /requirements.txt

# Why do you need these variables: See https://github.com/NVIDIA/nvidia-docker/wiki/Usage
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
