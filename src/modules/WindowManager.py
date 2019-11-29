import os

from PyQt5 import QtWidgets, QtCore, QtQml

from modules.ComponentCacheManager import ComponentCacheManager
from modules.AuthenticationManager import AuthenticationManager
from modules.FileReader import FileReader


class WindowManager(QtCore.QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        self._current_page = ""

        self._engine = QtQml.QQmlApplicationEngine()

        self._reader = FileReader()
        self._authentication = AuthenticationManager()
        self._manager = ComponentCacheManager(self._engine)

        self._authentication.login_signal.connect(self.on_login_signal)
        self._authentication.logout_signal.connect(self.on_logout_signal)

        self._engine.rootContext().setContextProperty(
            "authentication", self._authentication
        )
        self._engine.rootContext().setContextProperty(
            "componentCache", self._manager
        )
        self._engine.rootContext().setContextProperty(
            "fileReader", self._reader
        )

    def init(self):
        self.on_logout_signal()

    def on_login_signal(self):
        # self._engine.rootObjects().clear()
        self.current_page = "../ui/GeneralPage.qml"
        self._engine.rootObjects()[-1].show()


    def on_logout_signal(self):
        # self.current_page = "../ui/LoginPage.qml"
        self.current_page = "../ui/GeneralPage.qml"
        self._engine.rootObjects()[-1].show()

    @property
    def current_page(self):
        return self._current_page

    @current_page.setter
    def current_page(self, page):
        self._current_page = page
        current_dir = os.path.abspath(os.path.dirname(__file__))
        qml_file = os.path.join(current_dir, self.current_page)
        self._engine.load(qml_file)
