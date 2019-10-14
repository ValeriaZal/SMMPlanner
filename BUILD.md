SMM Planner build instructions
==============================

## Table of Contents
* [1. Pre-installations](#1-pre-installations)
* [2. Manual build instruction](#2-manual-build-instruction)
* [3. Auto build instruction](#3-auto-build-instruction)
* [4. Running instruction](#4-running-instruction)


## 1. Pre-installations

0. GitBash: https://git-scm.com/download/win
1. Python3: https://www.python.org/ (3.7 or higher)
2. PyQt5: `pip3 install PyQt5` or https://www.riverbankcomputing.com/software/pyqt/download5 (5.13.1 or higher)
3. Qt:
* offline: https://download.qt.io/archive/qt/5.13/5.13.1/ (5.11.1 or higher)
* online: https://download.qt.io/archive/online_installers/3.1/qt-unified-windows-x86-3.1.1-online.exe (3.1.1 or higher)
    Minimum requirements: QtCreator, QtWebEngine, QtNetworkAuthorization, MinGW (7.3.0 or higher), QtInstallerFramework 3.0 (or you can install it singly from http://download.qt.io/official_releases/qt-installer-framework/3.1.1/ (3.1.1 or higher))
4. Pywin32: `pip install pypiwin32` or https://github.com/mhammond/pywin32/releases
5. PyInstaller: `pip install pyinstaller` or https://www.pyinstaller.org/

## 2. Manual build instruction

### 1. Для загрузки всех исходных файлов с репозитория нужно выполнить следующую команду:
```
git clone https://github.com/ValeriaZal/SMMPlanner
```

### 2. Сборка из исходников:
1. Перейти в каталог `SMMPlanner\src`;
2. Открыть cmd и ввести следующую команду: `pyinstaller SMM_Planner.py`
       Указав доп. параметры можно изменить каталоги сборки. Подробнее: https://pyinstaller.readthedocs.io/en/stable/usage.html;
3. При вызове `pyinstaller` без доп. параметров в каталоге `dist` будут располагаться файлы исполняемой кофигурации, а в каталоге `build` - файлы для отладки;
4. В каталоге `dist\SMM_Planner` лежит SMM_Planner.exe.
    
### [TODO] 3. Сборка инсталлятора
1. Открыть в QtCreator installer/SMMPlanner_installer.pro
2. Собрать проект //in progress

    
## 3. Auto build instruction

Для работы скриптов необходимо выполнить пункт [1. Pre-installations](#1-pre-installations).

Для автоматической сборки необходимо скачать только сам скрипт.

### 1. Автоматическая сборка SMM Planner'a:
```
python scripts/auto_build_smm_planner.py [src/release/exe] [branch(for src)/version(for release/exe)]
```
Примечание: если запустить скрипт со следующими параметрами:
```
python scripts/auto_build_smm_planner.py
```
то по умолчанию будут собираться исходники с ветки [master](https://github.com/ValeriaZal/SMMPlanner/tree/master).

После работы скрипта в:
* `../Output/SMM_Planner` находится исполняемая конфигурация (файл SMM_Planner_v*.exe отвечает за запуск программы)
* `../supplement` располагаются файлы для отладки
* `../Src_x64` находятся исходные файлы (директория создается при выборе режима `src`
* `../Release_Src_x64` располагаются исходные файлы релизной версии

### [TODO] 2. Автоматическая сборка инсталлятора:
```
python auto_build_installer.py [src/release/exe] [branch(for src)/version(for release/exe)]
```

#### Аргументы:
- auto_build_smm_planner.py - имя скрипта
- [src/release/exe]:
  - src - загрузка исходников из раздела [code](https://github.com/ValeriaZal/SMMPlanner/tree/master)
  - release - загрузка исходников из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
  - exe - загрузка собранного приложения из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
- [branch(for src)/version(for release and exe)]:
  - branch - название ветки (используется, если выбран ключ src)
  - version - тег версии, поставляемая или исполняемая конфигурация которой закачиваются (если выбран release или exe)

## 4. Running instruction

1. Для запуска процесса установки нужно запустить SMM Planner Installer с правами администратора;
2. Для запуска SMM Planner'а нужно запустить SMM_Planner.exe.
