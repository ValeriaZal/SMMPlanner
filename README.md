# SMM Planner

SMM Planner - программное обеспечение, осуществляющее помощь в организации SMM-процессов администраторам сообществ социальной сети Вконтакте.

Предназначено для упрощения организации SMM-процессов администраторов сообществ социальной сети Вконтакте (Vk). ПО позволяет сэкономить время формирования контента (далее: поста) редактору, администратору или владельцу сообщества.

SMM Planner доступен как отдельное приложение с интерфейсом пользователя для Windows®.

## Table of Contents
* [System Requirements](#system-requirements)
* [Installation and Build](#installation-and-build)
* [Source Code Directory Layout](#source-code-directory-layout)
* [Known Issues](#known-issues)


## System Requirements

- OS: Windows 7, 8.1, and 10 (only x64)
- Процессор: не ниже AMD Athlon II и Intel Celeron G3930
- Оперативная память: минимум 1ГБ


## Installation and Build

Установка: используйте поставляемый файл установщика [SMM_Planner_Installer_*.exe](https://github.com/ValeriaZal/SMMPlanner/releases).

Сборка из исходников:
- Загрузка всех исходных файлов с репозитория:
```
git clone https://github.com/ValeriaZal/SMMPlanner
```
- Сборка SMM Planner'a и инсталлятора описана в [BUILD.md](https://github.com/ValeriaZal/SMMPlanner/blob/docs/BUILD.md)
- После сборки бинарники можно найти `SMMPlanner\Output\$(Configuration)\bin` (пример: `SMMPlanner\Output\Release\bin`)


## Source Code Directory Layout
* [scripts](scripts) - содержит скрипты для автоматической сборки компонентов
* [src](src) - содержит исходники
* [supplement](supplement) - содержит файлы для отладки


## Known Issues
