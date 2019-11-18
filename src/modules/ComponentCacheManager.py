# This Python file uses the following encoding: utf-8
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5 import QtWidgets

class ComponentCacheManager(QObject):
    def __init__(self, engine):
        super(ComponentCacheManager, self).__init__()
        self.engine = engine

    @pyqtSlot()
    def trim(self):
        self.engine.clearComponentCache()
