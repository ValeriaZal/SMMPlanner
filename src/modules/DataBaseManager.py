from PyQt5 import QtWidgets, QtCore

class DataBaseManager(QtCore.QObject):
    choose_group_signal = QtCore.pyqtSignal()
    get_groups_signal = QtCore.pyqtSignal()

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
