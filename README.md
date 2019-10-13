# SMMPlanner test

Представляет тестовый пример для проверки работы скриптов автоматической сборки.

## Запуск скрипта:
```
python auto_build_smm_planner_test.py [src/release] [branch(for src)/version(for release)]
```
Примечание: если запустить скрипт со следующими параметрами:
```
python auto_build_smm_planner_test.py
```
то по умолчанию будут собираться исходники с ветки [config_test](https://github.com/ValeriaZal/SMMPlanner/tree/config_test).

## Аргументы:
- auto_build_smm_planner_test.py - имя скрипта
- [src/release/exe]:
  - src - загрузка исходников из раздела [code](https://github.com/ValeriaZal/SMMPlanner/tree/config_test)
  - release - загрузка исходников из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
  - exe - загрузка собранного приложения из раздела [releases](https://github.com/ValeriaZal/SMMPlanner/releases)
- [branch(for src)/version(for release and exe)]:
  - branch - название ветки (используется, если выбран ключ src)
  - version - тег версии, поставляемая или исполняемая конфигурация которой закачиваются (если выбран release или exe)
