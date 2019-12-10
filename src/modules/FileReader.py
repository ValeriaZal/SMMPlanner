<<<<<<< Updated upstream
﻿# This Python file uses the following encoding: utf-8
=======
# This Python file uses the following encoding: utf-8
>>>>>>> Stashed changes
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import os


class FileReader(QObject):
    def __init__(self):
        QObject.__init__(self)

    version = pyqtSignal(str, arguments=['version'])

    @pyqtSlot()
    def getVersion(self):
        dirname=os.path.dirname(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
        f=open(os.path.join(dirname, "", "version"), "r")
        text = f.readlines()[0]
        self.version.emit(text)
