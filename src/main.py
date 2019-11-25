import sys

from PyQt5 import QtGui

from modules.WindowManager import WindowManager

APIv = "5.101"
app_id = "7221578"
scope = "groups,wall"

if __name__ == "__main__":
    app = QtGui.QGuiApplication(sys.argv)
    manager = WindowManager()
    manager.init()
    sys.exit(app.exec_())
