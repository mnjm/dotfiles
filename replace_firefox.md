# Replace Firefox-snap with Firefox-deb

**Reason to replace: Snap-firefox is unstable and startup is longer**

[Link](ttps://askubuntu.com/questions/1399383/how-to-install-firefox-as-a-traditional-deb-package-without-snap-in-ubuntu-22/1404401#1404401)

***Steps***
- First add the ppa to apt (ppa is from mozilla team)
```shell
sudo add-apt-repository ppa:mozillateam/ppa
```
- Prioritize apt version of firefox so that apt dont reset to snap while updating.
```shell
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
```
- Close firefox if opened and remove Firefox-snap
```shell
sudo snap remove firefox --purge
```
- Install firefox through apt
```shell
sudo apt install firefox -y
```
- To ensure that unattended upgrades do not reinstall the snap version of Firefox, enter the following command.
```shell
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
```
