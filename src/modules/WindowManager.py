import os

from PyQt5 import QtWidgets, QtCore, QtQml

from modules.ComponentCacheManager import ComponentCacheManager
from modules.AuthenticationManager import AuthenticationManager
from modules.DataBaseManager import DataBaseManager

from modules.VkSession import VkSession

class WindowManager(QtCore.QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.api_v = "5.101"
        self.app_id = "7221578"
        self.scope = "groups,wall,photos"

        self._current_page = ""
        self.vk_session = None

        self._engine = QtQml.QQmlApplicationEngine()

        self._authentication = AuthenticationManager()
        self._manager = ComponentCacheManager(self._engine)
        self._db_manager = DataBaseManager()


        self._authentication.login_signal.connect(self.on_login_signal)
        self._authentication.logout_signal.connect(self.on_logout_signal)
        self._authentication.close_signal.connect(self.on_close_signal)
        self._db_manager.choose_group_signal.connect(self.on_choose_group)
        self._db_manager.update_signal.connect(self.on_update)

        self._db_manager.load_posts_signal.connect(self.on_load_posts)
        self._db_manager.get_post_signal.connect(self.on_get_post)
        self._db_manager.get_tags_signal.connect(self.on_get_tags)

        self._engine.rootContext().setContextProperty(
            "authentication", self._authentication
        )
        self._engine.rootContext().setContextProperty(
            "componentCache", self._manager
        )
        self._engine.rootContext().setContextProperty(
            "db_manager", self._db_manager
        )
        self._engine.rootContext().setContextProperty(
            "APIv", self.api_v
        )
        self._engine.rootContext().setContextProperty(
            "app_id", self.app_id
        )
        self._engine.rootContext().setContextProperty(
            "scope", self.scope
        )

    def init(self):
        self.on_logout_signal()

    def on_login_signal(self):
        # self._engine.rootObjects().clear()
        self.current_page = "../ui/GeneralPage.qml"
        self._engine.rootObjects()[-1].show()

    def on_logout_signal(self):
        self.current_page = "../ui/LoginPage.qml"
        # self.current_page = "../ui/GeneralPage.qml"
        self._engine.rootObjects()[-1].show()

    def on_close_signal(self):
        self.vk_session.close()

    def on_choose_group(self):
        self.vk_session.set_group(self._db_manager.group) # group is a property = vk_id without "-"
        self.vk_session.load_cache_posts()

    def on_update(self):
        self.vk_session.update()

    def on_load_posts(self):
        post_list = self.vk_session.load_posts()
        self._db_manager.posts = post_list

    def on_get_post(self):
        post_id = self._db_manager.post_id
        db = self._db_manager.db
        res = self.vk_session.get_post(post_id, db)
        self._db_manager.res_post = res

    def on_get_tags(self):
        self._db_manager.tags = self.vk_session.get_tags()


    @property
    def current_page(self):
        return self._current_page

    @current_page.setter
    def current_page(self, page):
        if(page == "../ui/GeneralPage.qml"):
            self.vk_session = VkSession(self._authentication.token, self._authentication.user_id, self.api_v)
        self._current_page = page
        current_dir = os.path.abspath(os.path.dirname(__file__))
        qml_file = os.path.join(current_dir, self.current_page)
        self._engine.load(qml_file)
