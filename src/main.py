import sys
import os

from PyQt5 import QtQml, QtGui, QtCore

from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlEngine, QQmlComponent, QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView

from modules.ComponentCacheManager import ComponentCacheManager
from modules.Login import Login

APIv = "5.101"
app_id = "7123948"
scope = "groups,wall"

if __name__ == "__main__":
    app_login = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    manager = ComponentCacheManager(engine)
    context = engine.rootContext()
    context.setContextProperty("componentCache", manager)

    current_path = os.path.abspath(os.path.dirname(__file__))
    qml_file = os.path.join(current_path, 'ui/GeneralPage.qml') # LoginPage
    engine.load(qml_file)

    login = Login()
    engine.rootContext().setContextProperty("login", login)

    win = engine.rootObjects()[0]

    win.show()

    app_login.exec_()

    if(login.res_token != ""):
        main_app = QGuiApplication(sys.argv)
        engine = QQmlApplicationEngine()

        manager = ComponentCacheManager(engine)
        context = engine.rootContext()
        context.setContextProperty("componentCache", manager)

        current_path = os.path.abspath(os.path.dirname(__file__))
        qml_file = os.path.join(current_path, 'ui/GeneralPage.qml')
        engine.load(qml_file)

        engine.rootContext().setContextProperty("access_token", login.res_token)

        win = engine.rootObjects()[0]

        win.show()
        sys.exit(main_app.exec_())
    else:
        sys.exit()
