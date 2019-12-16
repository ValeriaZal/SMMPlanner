from PyQt5 import QtWidgets, QtCore

class DataBaseManager(QtCore.QObject):
    choose_group_signal = QtCore.pyqtSignal()
    update_signal = QtCore.pyqtSignal()
    load_posts_signal = QtCore.pyqtSignal()
    get_post_signal = QtCore.pyqtSignal()
    get_tags_signal = QtCore.pyqtSignal()
    get_templates_signal = QtCore.pyqtSignal()
    add_tag_signal = QtCore.pyqtSignal()
    save_post_signal = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._curr_group = ""
        self._groups = ""
        self._posts = []
        self._post_id = ""
        self._db = ""
        self._tag = ""
        self._post = ""
        self._res_post = []
        self._tags = []
        self._templates = []

    @QtCore.pyqtProperty(str, constant=True)
    def group(self):
        return self._curr_group

    @QtCore.pyqtProperty(list, constant=True)
    def posts(self):
        return self._posts

    @QtCore.pyqtProperty(str)
    def post_id(self):
        return self._post_id

    @QtCore.pyqtProperty(str)
    def db(self):
        return self._db

    @QtCore.pyqtProperty(list)
    def res_post(self):
        return self._res_post

    @QtCore.pyqtProperty(list)
    def tags(self):
        return self._tags

    @QtCore.pyqtProperty(list)
    def templates(self):
        return self._templates

    @QtCore.pyqtProperty(str)
    def tag(self):
        return self._tag

    @QtCore.pyqtProperty(list)
    def post(self):
        return self._post

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

    # get_post(post_id, db) -> ["title","template_name","colour",[<tags>],"date","text"]
    @QtCore.pyqtSlot(int, str, result=list)
    def get_post(self, post_id, db):
        self._post_id = post_id
        self._db = db
        self.get_post_signal.emit()
        return self._res_post

    # get_tags() -> [<tags>]
    @QtCore.pyqtSlot(result=list)
    def get_tags(self):
        self.get_tags_signal.emit()
        return self._tags

    # get_templates() -> [<Names of templates>]
    @QtCore.pyqtSlot(result=list)
    def get_templates(self):
        self.get_templates_signal.emit()
        return self._templates

    # add_tag(tag_name) -> True/False (might be ignored)
    @QtCore.pyqtSlot(str, result=bool)
    def add_tag(self, tag_name):
        self._tag = tag_name
        self.add_tag_signal.emit()
        return True

    # save_post(["title","template_name",[<tags>],"date","text"]) -> True/False
    @QtCore.pyqtSlot(list, result=bool)
    def save_post(self, post):
        self._post = post
        self.save_post_signal.emit()
        return True

    @posts.setter
    def posts(self, post_list):
        self._posts = post_list

    @db.setter
    def db(self, db):
        self._db = db

    @post_id.setter
    def post_id(self, post_id):
        self._post_id = post_id

    @res_post.setter
    def res_post(self, res_post):
        self._res_post = res_post

    @tags.setter
    def tags(self, tags):
        self._tags = tags

    @templates.setter
    def templates(self, templates):
        self._templates = templates

    @tag.setter
    def tag(self, tag):
        self._tag = tag

    @post.setter
    def post(self, post):
        self._post = post

