import sys
import os

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    ctx = engine.rootContext()
    ctx.setContextProperty("qmlapp", engine) #the string can be anything
    current_path = os.path.abspath(os.path.dirname(__file__))
    qml_file = os.path.join(current_path, 'app.qml')
    engine.load(qml_file)
    win = engine.rootObjects()[0]
    win.show()
    sys.exit(app.exec_())
