[![Docker Repository on Quay](https://quay.io/repository/cresta/dd-agent-nvml/status "Docker Repository on Quay")](https://quay.io/repository/cresta/dd-agent-nvml)
# dd-agent-nvml
The [datadog/agent](https://hub.docker.com/r/datadog/agent/) image, but with nvml eand helm integration installed


# How to use

Just run the agent from this Dockerfile (https://quay.io/repository/cresta/dd-agent-nvml) instead of datadog's official agent.  Or make
your own in a similar extended way as this one (It's a pretty tiny Dockerfile).

# Tips

Just make sure your `docker run` includes `docker run --runtime=nvidia` or the correct .so files will not be exposed.  More info at [nvidia-docker](https://github.com/NVIDIA/nvidia-docker).
