from PyQt5 import QtWidgets, QtCore

class AuthenticationManager(QtCore.QObject):
    login_signal = QtCore.pyqtSignal()
    logout_signal = QtCore.pyqtSignal()
    close_signal = QtCore.pyqtSignal()
    get_wall_posts_signal = QtCore.pyqtSignal()
    get_wall_postponed_signal = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._token = ""
        self._user_id = ""
        self._group_id = ""

    @QtCore.pyqtProperty(str, constant=True)
    def token(self):
        return self._token

    @QtCore.pyqtProperty(str, constant=True)
    def user_id(self):
        return self._user_id

    @QtCore.pyqtProperty(str, constant=True)
    def group_id(self):
        return self._group_id

    @QtCore.pyqtSlot(result=str)
    def get_wall_posts(self):
        self.get_wall_posts_signal.emit()
        link_wall_posts = f"https://vk.com/wall-{self._group_id}?own=1"
        return link_wall_posts

    #@QtCore.pyqtSlot(result=str)
    #def get_wall_posts(self):
    #    self.get_wall_posts_signal.emit()
    #    link_wall_posts = f"https://vk.com/wall-{self._group_id}?postponed=1"
    #    return link_wall_posts
    @QtCore.pyqtSlot(result=str)
    def get_wall_postponed(self):
        self.get_wall_postponed_signal.emit()
        link_wall_posts = f"https://vk.com/wall-{self._group_id}?postponed=1"
        return link_wall_posts

    @QtCore.pyqtSlot(str, result=bool)
    def login(self, url_with_token):
        self._token, self._user_id = self._get_token(url_with_token)
        if self.token:
            self.login_signal.emit()
            return True
        return False

    @QtCore.pyqtSlot()
    def logout(self):
        self._token = ""
        self.logout_signal.emit()

    @QtCore.pyqtSlot()
    def close(self):
        self._token = ""
        self.close_signal.emit()

    def _get_token(self, url_with_token):
        find_begin = url_with_token.find("access_token")
        find_end = url_with_token.find("&", find_begin)
        res_token = url_with_token[find_begin+len("access_token="):find_end]
        find_begin = url_with_token.find("user_id")
        find_end = url_with_token.find("&", find_begin)
        res_id = url_with_token[find_begin+len("user_id="):find_end]
        return res_token, res_id

    @group_id.setter
    def group_id(self, group_id):
        self._group_id = group_id
