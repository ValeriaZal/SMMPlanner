import sys
import os

from PyQt5 import QtQml, QtGui, QtCore

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlEngine, QQmlComponent, QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView


class ComponentCacheManager(QtCore.QObject):
    def __init__(self, engine):
        super(ComponentCacheManager, self).__init__()
        self.engine = engine

    @QtCore.pyqtSlot()
    def trim(self):
        self.engine.clearComponentCache()


# pip install pyqtwebengine

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    manager = ComponentCacheManager(engine)
    context = engine.rootContext()
    context.setContextProperty("componentCache", manager) #the string can be anything

    current_path = os.path.abspath(os.path.dirname(__file__))
    qml_file = os.path.join(current_path, 'ui/general_page.qml')
    engine.load(qml_file)

    win = engine.rootObjects()[0]
    win.show()
    sys.exit(app.exec_())
    #app.exec_()
