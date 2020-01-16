import sys

from PyQt5 import QtGui

from modules.WindowManager import WindowManager


if __name__ == "__main__":
    app = QtGui.QGuiApplication(sys.argv)
    app.setOrganizationName("VV");
    app.setOrganizationDomain("VV");

    manager = WindowManager()
    manager.init()
    sys.exit(app.exec_())
