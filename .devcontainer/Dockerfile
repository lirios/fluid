# syntax=docker/dockerfile:1

FROM archlinux:latest

# Update system and install required packages
RUN pacman --noconfirm --noprogressbar -Syyu && \
    pacman --noconfirm --noprogressbar -Sy \
      base-devel \
      git \
      doxygen \
      cmake \
      ninja \
      pkgconf \
      qt6-base \
      qt6-declarative \
      qt6-svg \
      qt6-wayland \
      qt6-shadertools \
      wayland-protocols \
      wayland && \
    # Clean pacman cache to reduce image size
    pacman -Scc --noconfirm
