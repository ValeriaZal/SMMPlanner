SMM Planner build instructions
==============================

## Table of Contents
* [1. Pre-installations](#1-pre-installations)
* [2. Manual build instruction](#2-manual_build-smm-planner)
* [3. Auto build instruction](#3-auto_build-smm-planner)
* [4. Running SMM Planner](#4-running-smm-planner)


## 1. Pre-installations

0. GitBash: https://git-scm.com/download/win
1. Python3: https://www.python.org/ (3.7 or higher)
2. PyQt5: https://www.riverbankcomputing.com/software/pyqt/download5 (5.13.1 or higher)
3. QtCreator: https://download.qt.io/archive/qt/5.13/5.13.1/ (5.13.1 or higher):
    Для установки необходимы QtCreator, QtWebEngine, ... <in progress>
4. Qt Installer Framework: http://download.qt.io/official_releases/qt-installer-framework/3.1.1/ (3.1.1 or higher)


## 2. Manual build instruction

1. Для загрузки всех исходных файлов с репозитория нужно выполнить следующую команду:
```
git clone https://github.com/ValeriaZal/SMMPlanner
```

2. Сборка из исходников:
    1. Открыть в QtCreator smm_planner.pyproject;
    2. Собрать проект <in progress>
    
3. Сборка инсталлятора
    1. Открыть в QtCreator installer/SMMPlanner_installer.pro
    2. Собрать проект <in progress>

    
## 3. Auto build instruction

1. Для автоматической сборки SMM Planner'a необходимо выполнить следующие команды:
```
git clone https://github.com/ValeriaZal/SMMPlanner
python SMMPlanner/scripts/auto_build_smm_planner.py
```

2. Для автоматической сборки инсталлятора необходимо выполнить следующие команды:
```
git clone https://github.com/ValeriaZal/SMMPlanner
python SMMPlanner/scripts/auto_build_installer.py
```


## 4. Running SMM Planner

1. Для запуска процесса установки нужно запустить SMM Planner Installer с правами администратора;
2. Для запуска SMM Planner'а нужно запустить SMM_planner.exe.
