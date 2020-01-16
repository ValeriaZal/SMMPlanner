from PyQt5 import QtWidgets, QtCore

class DataBaseManager(QtCore.QObject):
    choose_group_signal = QtCore.pyqtSignal()
    update_signal = QtCore.pyqtSignal()
    load_posts_signal = QtCore.pyqtSignal()
    get_post_signal = QtCore.pyqtSignal()
    get_posts_by_time_signal = QtCore.pyqtSignal()
    get_tags_signal = QtCore.pyqtSignal()
    delete_post_signal = QtCore.pyqtSignal()
    get_templates_signal = QtCore.pyqtSignal()
    get_groups_signal = QtCore.pyqtSignal()
    add_tag_signal = QtCore.pyqtSignal()
    save_post_signal = QtCore.pyqtSignal()
    publish_post_signal = QtCore.pyqtSignal()
    get_template_signal = QtCore.pyqtSignal()
    save_template_signal = QtCore.pyqtSignal()
    delete_template_signal = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._curr_group = ""
        self._groups = []
        self._posts = []
        self._post_id = ""
        self._start_time = 0
        self._end_time = 0
        self._db = ""
        self._tag = ""
        self._post = ""
        self._template_name = ""
        self._template = []
        self._res_post = []
        self._tags = []
        self._templates = []

    @QtCore.pyqtProperty(str, constant=True)
    def group(self):
        return self._curr_group

    @QtCore.pyqtProperty(list, constant=True)
    def posts(self):
        return self._posts

    @QtCore.pyqtProperty(int)
    def start_time(self):
        return self._start_time

    @QtCore.pyqtProperty(int)
    def end_time(self):
        return self._end_time

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

    @QtCore.pyqtProperty(list)
    def groups(self):
        return self._groups

    @QtCore.pyqtProperty(str)
    def tag(self):
        return self._tag

    @QtCore.pyqtProperty(list)
    def post(self):
        return self._post

    @QtCore.pyqtProperty(str)
    def template_name(self):
        return self._template_name

    @QtCore.pyqtProperty(list)
    def template(self):
        return self._template

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

    # get_posts_by_time(start_time, end_time) -> [<id, title, color, time, status>]
    @QtCore.pyqtSlot(int, int, result=list)
    def get_posts_by_time(self, start_time, end_time):
        self._start_time = start_time
        self._end_time = end_time
        self.get_posts_by_time_signal.emit()
        return self._posts

    # delete_post(post_id) -> True/False
    @QtCore.pyqtSlot(int, result=bool)
    def delete_post(self, post_id):
        self._post_id = post_id
        self.delete_post_signal.emit()
        return True


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

    # get_groups() -> [[<group names>, <group id>]]
    @QtCore.pyqtSlot(result=list)
    def get_groups(self):
        self.get_groups_signal.emit()
        return self._groups

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

    # publish_post(["title",[<tags>],"date","text"]) -> True/False
    @QtCore.pyqtSlot(list, result=bool)
    def publish_post(self, post):
        self._post = post
        print(f"DSM:publish_post:{post}")
        self.publish_post_signal.emit()
        return True

    # get_template(template_name) -> [name, colour, date, text, [<tags>]]
    @QtCore.pyqtSlot(str, result=list)
    def get_template(self, template_name):
        self._template_name = template_name
        self.get_template_signal.emit()
        return self._template

    # save_template([name, colour, date, text, [<tags>]]) -> True/False
    @QtCore.pyqtSlot(list, result=bool)
    def save_template(self, template):
        self._template = template
        self.save_template_signal.emit()
        return True

    # delete_template(template_name) -> True/False
    @QtCore.pyqtSlot(str, result=bool)
    def delete_template(self, template_name_):
        self._template_name = template_name_
        self.delete_template_signal.emit()
        return True

    @posts.setter
    def posts(self, post_list):
        self._posts = post_list

    @start_time.setter
    def start_time(self, start_time):
        self._start_time = start_time

    @end_time.setter
    def end_time(self, end_time):
        self._end_time = end_time

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

    @template_name.setter
    def template_name(self, template_name_):
        self._template_name = template_name_

    @template.setter
    def template(self, template):
        self._template = template

    @groups.setter
    def groups(self, groups):
        self._groups = groups


