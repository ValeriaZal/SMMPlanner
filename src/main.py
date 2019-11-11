import sys
import os

from PyQt5 import QtQml, QtGui, QtCore

from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlEngine, QQmlComponent, QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView

APIv = "5.101"
app_id = "7123948"
scope = "groups,wall"

class ComponentCacheManager(QtCore.QObject):
    def __init__(self, engine):
        super(ComponentCacheManager, self).__init__()
        self.engine = engine

    @pyqtSlot()
    def trim(self):
        self.engine.clearComponentCache()

class Login(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.res_token = ""

    tokenResult = pyqtSignal(str, arguments=['token'])

    @pyqtSlot(str)
    def token(self, arg1):
        find_start = arg1.find("access_token")
        find_stop = arg1.find("&", find_start)
        self.res_token = arg1[find_start+len("access_token="):find_stop]
        self.tokenResult.emit(self.res_token)

if __name__ == "__main__":
    app_login = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    manager = ComponentCacheManager(engine)
    context = engine.rootContext()
    context.setContextProperty("componentCache", manager)

    current_path = os.path.abspath(os.path.dirname(__file__))
    qml_file = os.path.join(current_path, 'ui/login_page.qml')
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
        qml_file = os.path.join(current_path, 'ui/general_page.qml')
        engine.load(qml_file)

        engine.rootContext().setContextProperty("access_token", login.res_token)

        win = engine.rootObjects()[0]

        win.show()
        sys.exit(main_app.exec_())
    else:
        sys.exit()
