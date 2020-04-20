# Use an intermediate step to build the nvml datadog integration
# Setup taken from https://docs.datadoghq.com/agent/guide/community-integrations-installation-with-docker-agent/?tab=docker
FROM python:3.8 AS wheel_builder
WORKDIR /wheels-nvml

RUN pip install "datadog-checks-dev[cli]==3.1.0"
RUN git clone https://github.com/cresta/integrations-extras.git

RUN ddev config set extras ./integrations-extras
RUN ddev -e release build nvml

WORKDIR /wheels-helm

RUN pip install "datadog-checks-dev[cli]==3.1.0"
RUN git clone --branch helm https://github.com/cresta/integrations-extras.git

RUN ddev config set extras ./integrations-extras
RUN ddev -e release build helm

# You will need to change this version to whichever datadog version you want to install
FROM datadog/agent:7.18.1

COPY --from=wheel_builder /wheels-nvml/integrations-extras/nvml/dist/ /dist-nvml
COPY --from=wheel_builder /wheels-nvml/integrations-extras/nvml/requirements.in /requirements.in.nvml

COPY --from=wheel_builder /wheels-helm/integrations-extras/helm/dist/ /dist-helm
COPY --from=wheel_builder /wheels-helm/integrations-extras/helm/requirements.in /requirements.in.helm

# Work around bug https://github.com/DataDog/datadog-agent/issues/4142
RUN ln -s /etc/datadog-agent/datadog-docker.yaml /etc/datadog-agent/datadog.yaml && \
	agent integration install -r -w /dist-nvml/*.whl && \
	agent integration install -r -w /dist-helm/*.whl && \
	rm /etc/datadog-agent/datadog.yaml

# The command 'agent integration install' does not capture dependencies.  This is strange
# to me.  Install those on their own
RUN /opt/datadog-agent/embedded/bin/pip3 install -r /requirements.in.nvml
RUN /opt/datadog-agent/embedded/bin/pip3 install -r /requirements.in.helm

# Why do you need these variables: See https://github.com/NVIDIA/nvidia-docker/wiki/Usage
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
