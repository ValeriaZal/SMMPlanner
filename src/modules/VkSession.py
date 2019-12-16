# This Python file uses the following encoding: utf-8
from PyQt5 import QtWidgets, QtCore

import vk
import sys
import time

from modules.CacheDatabase import CacheDatabase
from modules.DataDatabase import DataDatabase
from modules.PostConstructor import PostConstructor

non_bmp_map = dict.fromkeys(range(0x10000, sys.maxunicode + 1), 0xfffd)

class VkSession():
    class __VkSession():
        def __init__(self, token, user_id, api_v):
            self._token = token
            self._user_id = user_id
            self._api_v = api_v
            self._curr_group = None # vk id
            self._session = vk.AuthSession(access_token=token)
            self._vk_api = vk.API(self._session)
            self._cache = CacheDatabase(self._user_id)
            self._data = DataDatabase(self._user_id)
            self.load_cache_groups()
            self._post_const = PostConstructor(self._vk_api, self._api_v)

        def close(self):
            self._cache.close()
            self._cache.delete()
            del self._cache

        def load_cache_groups(self):
            groups_info = self._get_groups_info()
            for item in groups_info:
                self._cache.insert("groups", item)
            if(self._curr_group == None):
                self._curr_group = groups_info[0][0]
                self.load_cache_posts()

        def load_cache_posts(self):
            posts_info = self._get_posts_info()
            for item in posts_info:
                self._cache.insert("posts", item)

        def load_posts(self):
            cache_posts = self._cache.get_posts(self._curr_group)
            data_posts = self._data.get_posts(self._curr_group)
            return cache_posts + data_posts

        def set_group(self, group):
            self._curr_group = group

        def get_post(self, post_id, db):
            if(db == "cache"):
                res = self._cache.get_post(post_id, self._curr_group)
                return res
            elif(db == "data"):
                res = self._data.get_post(post_id, self._curr_group)
                return res
            else:
                print("Error! Post is not found")

        def get_tags(self):
            return self._data.get_tags()

        def get_templates(self):
            return self._data.get_templates()

        def add_tag(self, tag_name):
            self._data.insert_or_ignore("tags", (tag_name,))

        def save_post(self, post):
            tuple_post, tags = self._data.post_to_save(post)
            tuple_post[1] = "-"+str(self._curr_group)
            self._data.insert_or_replace("posts", tuple(tuple_post))
            post_id = self._data.get_post_id(post[3])
            for tag in tags:
                tag_id = self._data.get_tag_id(tag)
                self._data.insert("post_tag_list", (post_id, tag_id))

        def update(self):
            posts_info = self._get_posts_info()
            for item in posts_info:
                self._cache.update(self._curr_group, "posts", item)

        def publish_post(self, post):
            message, publish_date = self._post_const.create_post(post)
            self._post_const.publish_post(self._curr_group, message, publish_date)
            post_id = self._data.get_post_id(publish_date)
            self._data.delete_post(post_id)

        def get_template(self, template_name):
            res = self._data.get_template(template_name)
            return res

        def _get_groups_info(self):
            groups = self._vk_api.groups.get(filter='admin', v=self._api_v)
            groups_info = []
            for group in groups['items']:
                tmp = self._vk_api.groups.getById(group_id=str(group), v=self._api_v)[0]
                # We need as a tuple: "vk_id","name","screen_name","type","is_admin","photo_50","photo_100","photo_200"
                groups_info.append((tmp["id"], tmp["name"], tmp["screen_name"], tmp["type"],
                                    tmp["is_admin"], tmp["photo_50"], tmp["photo_100"], tmp["photo_200"]))
            return groups_info

        def _get_posts_info(self):
            count = "50" # how many posts/postponed posts we load
            posts_info = []
            group_db_id = self._cache.get_group_id(str(self._curr_group))
            postponed_posts = self._vk_api.wall.get(owner_id="-" + str(self._curr_group), count=count, filter="postponed", v=self._api_v)
            for post in postponed_posts['items']:
                # We need as a tuple:"vk_id","group_id","from_id","owner_id","postponed","date","marked_as_ads",
                #                    "post_type","text","can_pin","can_publish","can_edit","can_delete"
                posts_info.append((post['id'], group_db_id, post['from_id'], post['owner_id'],
                                    1, post['date'], post['marked_as_ads'], post['post_type'],
                                    post['text'].translate(non_bmp_map), 0, post['can_publish'], post['can_edit'],
                                    post['can_delete']))
            time.sleep(0.9)
            owner_posts = self._vk_api.wall.get(owner_id="-" + str(self._curr_group), count=count, filter="owner", v=self._api_v)
            for post in owner_posts['items']:
                posts_info.append((post['id'], group_db_id, post['from_id'], post['owner_id'],
                                    0, post['date'], post['marked_as_ads'], post['post_type'],
                                    post['text'].translate(non_bmp_map), post['can_pin'], 0, 0,
                                    post['can_delete']))

            return posts_info


    instance = None
    def __init__(self, token, user_id, api_v):
        if not VkSession.instance:
            VkSession.instance = VkSession.__VkSession(token, user_id, api_v)
        else:
            VkSession.instance._token = token
            VkSession.instance._user_id = user_id
            VkSession.instance._api_v = api_v
            VkSession.instance._curr_group = None
            VkSession.instance._session = vk.AuthSession(access_token=token)
            VkSession.instance._vk_api = vk.API(self._session)
            VkSession.instance._cache = CacheDatabase(self._user_id)
            VkSession.instance.load_cache_groups()

    def __getattr__(self, name):
        return getattr(self.instance, name)
