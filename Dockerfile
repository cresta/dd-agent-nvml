FROM datadog/agent:7.16.1
ARG NVML_VERSION=e3d4399bdea6b48814524aa6cb7ec9d2011492f6
# Note: We can't install the documented version since the agent is on py3, but
# this patched pip seems to work
RUN /opt/datadog-agent/embedded/bin/pip install nvidia-ml-py3
# Very install
RUN /opt/datadog-agent/embedded/bin/pip show nvidia-ml-py3
RUN mkdir -p /checks.d
RUN curl https://raw.githubusercontent.com/ngi644/datadog_nvml/${NVML_VERSION}/nvml.py > /checks.d/nvml.py
