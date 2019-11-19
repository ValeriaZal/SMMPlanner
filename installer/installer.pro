TEMPLATE = aux

INSTALLER = SMM_Installer

INPUT = $$PWD/config/config.xml $$PWD/packages
example.input = INPUT
example.output = $$INSTALLER
example.commands = binarycreator -c $$PWD/config/config.xml -p $$PWD/packages $$PWD/SMM_Planner_Installer.exe
example.CONFIG += target_predeps no_link combine

QMAKE_EXTRA_COMPILERS += example

OTHER_FILES = README

DISTFILES += \
    config/config.xml
