# Intel's Open Source Sound Driver Fix

[Link to article](https://www.linuxuprising.com/2018/06/fix-no-sound-dummy-output-issue-in.html)

**System Info**

- Distro `Ubuntu 20.04`
- Kernel Version `Linux 5.4.0-40-generic`
- Laptop `Lenovo S340 Intel i5 10gen with Nvidia MX250 GPU`

**Fix**

- Append below lines to `/etc/modprobe.d/alsa-base.conf`

  ```shell
  options snd-hda-intel model=auto
  options snd-hda-intel dmic_detect=0
  ```

- Append below line to `/etc/modprobe.d/blacklist.conf`

  ```shell
  blacklist snd_soc_skl
  ```

- And **restart** the PC