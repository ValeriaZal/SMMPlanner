# This Python file uses the following encoding: utf-8
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5 import QtWidgets

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