#!/bin/sh
# Fast Site Engine. Copyright © 2004-2018, AC (acwed@ya.ru). All rights reserved. 2-clause BSD license.
# fsen.ru/linux - сохранить файл с расширением *.sh и сделать его исполняемым. Затем запустить в консоли(терминале) и ввести пароль.
# K/Ubuntu 18.04 LTS (Bionic Beaver) / Linux Mint 19

# название префикса Wine $HOME/.wine # папка с фотошопом
prefix=~/.wine
photoshop="Photoshop18"

# удаляем фотошоп
rm -rfv $prefix/drive_c/$photoshop

# удаляем иконки
sudo rm -vf /usr/share/icons/hicolor/16x16/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/22x22/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/32x32/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/48x48/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/64x64/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/128x128/apps/photoshop.png
sudo rm -vf /usr/share/icons/hicolor/256x256/apps/photoshop.png

# удаляем скрипты и ярлыки запуска
sudo rm -vf /usr/bin/photoshop.sh
sudo rm -vf /usr/share/applications/photoshop.desktop
# снимок экрана в файл и открыть в Photoshop
sudo rm -vf /usr/bin/screentops.sh
sudo rm -vf /usr/share/applications/screentops.desktop
# снимок экрана с задержкой в 3 сек (2 1 0 снимок) в файл и открыть в Photoshop
sudo rm -vf /usr/bin/screentops3.sh
sudo rm -vf /usr/share/applications/screentops3.desktop

sudo gtk-update-icon-cache /usr/share/icons/hicolor
sudo update-desktop-database