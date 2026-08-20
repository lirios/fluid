# syntax=docker/dockerfile:1

FROM archlinux:latest

# Update system and install required packages
RUN pacman --noconfirm --noprogressbar -Syyu && \
    pacman --noconfirm --noprogressbar -Sy \
      less \
      vim \
      python python-pipx python-requests \
      ttf-roboto ttf-roboto-mono-nerd \
      noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
      base-devel \
      openssh \
      git \
      doxygen xdot \
      cmake \
      ninja \
      pkgconf \
      qt6-base \
      qt6-declarative \
      qt6-5compat \
      qt6-svg \
      qt6-wayland \
      qt6-shadertools \
      qt6-doc \
      wayland-protocols \
      wayland && \
    # Install doxyqml via pipx
    pipx install --global doxyqml && \
    # Clean pacman cache to reduce image size
    pacman -Scc --noconfirm

# Create an unprivileged user
RUN useradd -m -s /bin/bash -u 1000 developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to unprivileged user
USER developer
WORKDIR /home/developer
