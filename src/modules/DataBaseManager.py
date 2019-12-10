from PyQt5 import QtWidgets, QtCore

class DataBaseManager(QtCore.QObject):
    choose_group_signal = QtCore.pyqtSignal(str, arguments=['choose_group_signal'])
    update_signal = QtCore.pyqtSignal(arguments=['update_signal'])

    def __init__(self, parent=None):
        super().__init__(parent)
        self._curr_group = ""
        self._groups = ""

    @QtCore.pyqtProperty(str, constant=True)
    def group(self):
        return self._curr_group

    @QtCore.pyqtSlot(str)
    def choose_group(self, group_vk_id):
        self._curr_group = group_vk_id
        self.choose_group_signal.emit()

    @QtCore.pyqtSlot()
    def update(self):
        self.update_signal.emit()
