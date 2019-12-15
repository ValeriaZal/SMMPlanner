from PyQt5 import QtWidgets, QtCore

class DataBaseManager(QtCore.QObject):
    choose_group_signal = QtCore.pyqtSignal()
    update_signal = QtCore.pyqtSignal()
    load_posts_signal = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._curr_group = ""
        self._groups = ""
        self._posts = []

    @QtCore.pyqtProperty(str, constant=True)
    def group(self):
        return self._curr_group

    @QtCore.pyqtProperty(str, constant=True)
    def posts(self):
        return self._posts

    @QtCore.pyqtSlot(str)
    def choose_group(self, group_vk_id):
        self._curr_group = group_vk_id
        self.choose_group_signal.emit()

    @QtCore.pyqtSlot()
    def update(self):
        self.update_signal.emit()

    # load_posts (list of post<id, title, color, time, status>)
    @QtCore.pyqtSlot(result=list)
    def load_posts(self):
        self.load_posts_signal.emit()
        return self._posts

    @posts.setter
    def posts(self, post_list):
        self._posts = post_list


