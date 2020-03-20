FROM datadog/agent:7.18.0

COPY datadog_nvml-0.0.1-py2.py3-none-any.whl /tmp/datadog_nvml-0.0.1-py2.py3-none-any.whl
RUN ln -s /etc/datadog-agent/datadog-docker.yaml /etc/datadog-agent/datadog.yaml && agent integration install -r -w /tmp/datadog_nvml-0.0.1-py2.py3-none-any.whl && rm /etc/datadog-agent/datadog.yaml

# Why do you need these variables: See https://github.com/NVIDIA/nvidia-docker/wiki/Usage
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
