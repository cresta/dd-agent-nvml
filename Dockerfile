# Use an intermediate step to build the nvml datadog integration
# Setup taken from https://docs.datadoghq.com/agent/guide/community-integrations-installation-with-docker-agent/?tab=docker
FROM python:3.8 AS wheel_builder
WORKDIR /wheels

RUN pip install "datadog-checks-dev[cli]==3.1.0"
RUN git clone https://github.com/cresta/integrations-extras.git

RUN ddev config set extras ./integrations-extras
RUN ddev -e release build nvml

# You will need to change this version to whichever datadog version you want to install
FROM datadog/agent:7.18.0

COPY --from=wheel_builder /wheels/integrations-extras/nvml/dist/ /dist
COPY --from=wheel_builder /wheels/integrations-extras/nvml/requirements.in /requirements.in

# Work around bug https://github.com/DataDog/datadog-agent/issues/4142
RUN ln -s /etc/datadog-agent/datadog-docker.yaml /etc/datadog-agent/datadog.yaml && \
	agent integration install -r -w /dist/*.whl && \
	rm /etc/datadog-agent/datadog.yaml

# The command 'agent integration install' does not capture dependencies.  This is strange
# to me.  Install those on their own
RUN /opt/datadog-agent/embedded/bin/pip3 install -r /requirements.in

# Why do you need these variables: See https://github.com/NVIDIA/nvidia-docker/wiki/Usage
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
