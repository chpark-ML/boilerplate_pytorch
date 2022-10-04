# Reference :
# https://github.com/anibali/docker-pytorch/blob/master/dockerfiles/1.11.0-cuda11.5-ubuntu20.04/Dockerfile

FROM nvidia/cuda:11.5.1-base-ubuntu20.04

# args
ARG USR=MI_alumni

# Remove any third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
 && rm -rf /var/lib/apt/lists/*

# Create a working directory
RUN mkdir /opt
WORKDIR /opt

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user \
 && chown -R user:user /opt
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
USER ${USR}

# All users can use /home/user as their home directory
ENV HOME=/home/user
RUN mkdir $HOME/.cache $HOME/.config \
 && chmod -R 777 $HOME

# Set up the Conda environment (using Miniforge)
ENV PATH=$HOME/mambaforge/bin:$PATH
COPY environment.yml /opt/environment.yml
RUN curl -sLo ~/mambaforge.sh https://github.com/conda-forge/miniforge/releases/download/4.12.0-2/Mambaforge-4.12.0-2-Linux-x86_64.sh \
 && chmod +x ~/mambaforge.sh \
 && ~/mambaforge.sh -b -p ~/mambaforge \
 && rm ~/mambaforge.sh \
 && mamba env update -n base -f /opt/environment.yml \
 && rm /opt/environment.yml \
 && mamba clean -ya

# Set the default command to python3
CMD ["/bin/zsh"]