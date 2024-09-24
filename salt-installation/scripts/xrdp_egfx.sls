# Add the XRDP repository
add-xrdp-repository:
  cmd.run:
    - name: apt-add-repository -y ppa:saxl/xrdp-egfx
    - unless: grep -q 'saxl/xrdp-egfx' /etc/apt/sources.list /etc/apt/sources.list.d//\*

# Update the APT package cache
update-apt-cache:
  cmd.run:
    - name: apt-get update
    - require:
      - cmd: add-xrdp-repository

# Install XRDP with H.264 support
install-xrdp-egfx:
  pkg.installed:
    - pkgs:
      - xrdp-egfx
      - xorgxrdp-egfx
    - require:
      - cmd: update-apt-cache

# Optional: Install PulseAudio module for XRDP (sound redirection)
install-pulseaudio-xrdp:
  pkg.installed:
    - name: pulseaudio-module-xrdp
    - require:
      - pkg: install-xrdp-egfx
