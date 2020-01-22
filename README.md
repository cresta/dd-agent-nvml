[![Docker Repository on Quay](https://quay.io/repository/cresta/dd-agent-nvml/status "Docker Repository on Quay")](https://quay.io/repository/cresta/dd-agent-nvml)
# dd-agent-nvml
The [datadog/agent](https://hub.docker.com/r/datadog/agent/) image, but with [henry0312/datadog-gpustat](https://github.com/henry0312/datadog-gpustat) installed


# Important notes

Please keep image explicit, with an extact SHA for datadog-gpustat and exact image ID for datadog agent

# How to use

Just run the agent from this Dockerfile (https://quay.io/repository/cresta/dd-agent-nvml) instead of datadog's official agent.  Or make
your own in a similar extended way as this one (It's a pretty tiny Dockerfile).
