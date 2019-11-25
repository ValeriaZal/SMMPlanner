from PyQt5 import QtWidgets, QtCore

class AuthenticationManager(QtCore.QObject):
    login_signal = QtCore.pyqtSignal()
    logout_signal = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._token = ""

    @QtCore.pyqtProperty(str, constant=True)
    def token(self):
        return self._token

    @QtCore.pyqtSlot(str, result=bool)
    def login(self, url_with_token):
        self._token = self._get_token(url_with_token)
        if self.token:
            self.login_signal.emit()
            return True
        return False

    @QtCore.pyqtSlot()
    def logout(self):
        self._token = ""
        self.logout_signal.emit()

    def _get_token(self, url_with_token):
        find_begin = url_with_token.find("access_token")
        find_end = url_with_token.find("&", find_begin)
        res_token = url_with_token[find_begin+len("access_token="):find_end]
        return res_token
