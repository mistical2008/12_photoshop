#!/bin/sh
# Fast Site Engine. Copyright © 2004-2018, AC (acwed@ya.ru). All rights reserved. 2-clause BSD license.
# fsen.ru/linux - сохранить файл с расширением *.sh и сделать его исполняемым. Затем запустить в консоли(терминале) и ввести пароль.
# K/Ubuntu 18.04 LTS (Bionic Beaver) / Linux Mint 19

# название префикса Wine $HOME/.wine # выделяемый размер видеопамяти видекарты # куда сохранять скриншот # папка с фотошопом
prefix=$W_PREFIXES/photoshop2018_test
videomemsize=2048
pscreen="/a/www/0.png"
photoshop="Photoshop18"

# устанавливаем wine
# sudo pacman -S wine

## ===============================================
# создаём 32 битный префикс
#rm -rfv $prefix
#WINEARCH=win32 WINEPREFIX=$prefix wine wineboot
## ===============================================

# устанавливаем необходимые библиотеки
winetricks prefix=$prefix vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 msxml3 msxml6 gdiplus corefonts atmlib

# дополнительные настройки
winetricks prefix=$prefix win10 nocrashdialog fontsmooth=rgb sound=disabled videomemorysize=$videomemsize

# копируем фотошоп
cp -va ./$photoshop $prefix/drive_c/

# добавим иконки из папки
sudo cp -v ./config/icons/16x16/photoshop.png /usr/share/icons/hicolor/16x16/apps/
sudo cp -v ./config/icons/22x22/photoshop.png /usr/share/icons/hicolor/22x22/apps/
sudo cp -v ./config/icons/32x32/photoshop.png /usr/share/icons/hicolor/32x32/apps/
sudo cp -v ./config/icons/48x48/photoshop.png /usr/share/icons/hicolor/48x48/apps/
sudo cp -v ./config/icons/64x64/photoshop.png /usr/share/icons/hicolor/64x64/apps/
sudo cp -v ./config/icons/128x128/photoshop.png /usr/share/icons/hicolor/128x128/apps/
sudo cp -v ./config/icons/256x256/photoshop.png /usr/share/icons/hicolor/256x256/apps/

# устраняем окошки с ошибками..
rm -rfv $prefix/drive_c/$photoshop/Required/CEP/CEPHtmlEngine/
rm -rfv $prefix/drive_c/$photoshop/Required/CEP/extensions/

# ставим поддержку сохранения иконок
cp -v ./config/ico/*.8bi $prefix/drive_c/$photoshop/App/Ps/Required/Plug-ins/"File Formats/"

# создадим скрипты и ярлыки запуска
echo '#!/bin/sh\nWINEPREFIX='$prefix' wine "C:\'$photoshop'\ps.19.1.6x86Pluginss.exe"' | sudo tee /usr/bin/photoshop.sh && sudo chmod +x /usr/bin/photoshop.sh
echo '[Desktop Entry]\nType=Application\nName=Photoshop\nComment=Adobe Photoshop CC 2017\nExec=/usr/bin/photoshop.sh\nIcon=photoshop\nCategories=Graphics;' | sudo tee /usr/share/applications/photoshop.desktop
#Icon=gnome-screenshot
# снимок экрана в файл и открыть в Photoshop
echo '#!/bin/sh\n/usr/bin/scrot "'$pscreen'"\nWINEPREFIX='$prefix' wine "C:\'$photoshop'\ps.19.1.6x86Pluginss.exe" "'$pscreen'"' | sudo tee /usr/bin/screentops.sh && sudo chmod +x /usr/bin/screentops.sh && echo '[Desktop Entry]\nType=Application\nName=ScreenToPhotoshop\nComment=Скриншот в Photoshop\nExec=/usr/bin/screentops.sh\nIcon=spectacle\nCategories=Graphics;' | sudo tee /usr/share/applications/screentops.desktop
# снимок экрана с задержкой в 3 сек (2 1 0 снимок) в файл и открыть в Photoshop
echo '#!/bin/sh\n/usr/bin/scrot -d 2 "'$pscreen'"\nWINEPREFIX='$prefix' wine "C:\'$photoshop'\ps.19.1.6x86Pluginss.exe" "'$pscreen'"' | sudo tee /usr/bin/screentops3.sh && sudo chmod +x /usr/bin/screentops3.sh && echo '[Desktop Entry]\nType=Application\nName=ScreenToPhotoshop3\nComment=Скриншот в Photoshop с задержкой в 3 сек.\nExec=/usr/bin/screentops3.sh\nIcon=spectacle\nCategories=Graphics;' | sudo tee /usr/share/applications/screentops3.desktop

sudo gtk-update-icon-cache /usr/share/icons/hicolor
sudo update-desktop-database
