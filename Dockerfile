FROM datadog/agent:7.16.1
ARG NVML_VERSION=e3d4399bdea6b48814524aa6cb7ec9d2011492f6
RUN curl https://raw.githubusercontent.com/ngi644/datadog_nvml/${NVML_VERSION}/requirements.txt > /opt/requirements_nvml.txt
RUN /opt/datadog-agent/embedded/bin/pip install -r /opt/requirements_nvml.txt
# Very install
RUN /opt/datadog-agent/embedded/bin/pip show nvidia-ml-py
RUN curl https://github.com/ngi644/datadog_nvml/blob/${NVML_VERSION}/nvml.py > /opt/nvml.py
