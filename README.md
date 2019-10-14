# SMMPlanner test

Представляет тестовый пример для проверки работы скриптов автоматической сборки.

Для работы процесса сборки необходимо установить все компоненты из раздела [1. Pre-installations](#1-pre-installations)

## 1. Pre-installations

0. GitBash: https://git-scm.com/download/win
1. Python3: https://www.python.org/ (3.7 or higher)
2. PyQt5: `pip3 install PyQt5` or https://www.riverbankcomputing.com/software/pyqt/download5 (5.13.1 or higher)
3. Qt:
* offline: https://download.qt.io/archive/qt/5.13/5.13.1/ (5.13.1 or higher)
* online: https://download.qt.io/archive/online_installers/3.1/qt-unified-windows-x86-3.1.1-online.exe (3.1.1 or higher)
    Minimum requirements: QtCreator, QtWebEngine, QtNetworkAuthorization, MinGW (7.3.0 or higher), QtInstallerFramework 3.0 (or you can install it singly from http://download.qt.io/official_releases/qt-installer-framework/3.1.1/ (3.1.1 or higher))
4. Pywin32: `pip install pypiwin32` or https://github.com/mhammond/pywin32/releases
5. PyInstaller: `pip install pyinstaller` or https://www.pyinstaller.org/

## 2. Running script:

```
python scripts/auto_build_smm_planner_test.py [src/release/exe] [branch(for src)/version(for release/exe)]
```
Примечание: если запустить скрипт со следующими параметрами:
```
python scripts/auto_build_smm_planner_test.py
```
то по умолчанию будут собираться исходники (src) с ветки [config_test](https://github.com/ValeriaZal/SMMPlanner/tree/config_test).

После работы скрипта в:
* `../Output/SMM_Planner` находится исполняемая конфигурация (файл SMM_Planner_v*.exe отвечает за запуск программы)
* `../supplement` располагаются файлы для отладки
* `../Src_x64` находятся исходные файлы (директория создается при выборе режима `src`)
* `../Release_Src_x64` располагаются исходные файлы релизной версии (директория создается при выборе режима `release`)

### Args:
- auto_build_smm_planner_test.py - имя скрипта
- [src/release/exe]:
  - src - загрузка исходников из раздела [code](https://github.com/ValeriaZal/SMMPlanner/tree/config_test)
  - release - загрузка исходников из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
  - exe - загрузка собранного приложения из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
- [branch(for src)/version(for release and exe)]:
  - branch - название ветки (используется, если выбран ключ src)
  - version - тег версии, поставляемая или исполняемая конфигурация которой закачиваются (если выбран release или exe)
