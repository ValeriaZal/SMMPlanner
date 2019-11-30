# This Python file uses the following encoding: utf-8
import vk
import sys
import time

from modules.CacheDatabase import CacheDatabase

non_bmp_map = dict.fromkeys(range(0x10000, sys.maxunicode + 1), 0xfffd)

class VkSession:
    class __VkSession:
        def __init__(self, token, user_id, api_v):
            self._token = token
            self._user_id = user_id
            self._api_v = api_v
            self._session = vk.AuthSession(access_token=token)
            self._vk_api = vk.API(self._session)
            self._cache = CacheDatabase(self._user_id)
            self.load_cache()

        def close(self):
            self._cache.close()
            self._cache.delete()
            del self._cache

        def load_cache(self):
            groups_info = self._get_groups_info()
            for item in groups_info:
                self._cache.insert("groups", item)
            posts_info = self._get_posts_info()
            for item in posts_info:
                self._cache.insert("posts", item)

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
            groups = self._vk_api.groups.get(filter='admin', v=self._api_v)

            posts_info = []
            time.sleep(0.5)
            for group in groups['items']:
                group_db_id = self._cache.get_group_id(str(group))
                postponed_posts = self._vk_api.wall.get(owner_id="-" + str(group), count="3", filter="postponed", v=self._api_v)
                for post in postponed_posts['items']:
                    # We need as a tuple:"vk_id","group_id","from_id","owner_id","postponed","date","marked_as_ads",
                    #                    "post_type","text","can_pin","can_publish","can_edit","can_delete"
                    posts_info.append((post['id'], group_db_id, post['from_id'], post['owner_id'],
                                        1, post['date'], post['marked_as_ads'], post['post_type'],
                                        post['text'].translate(non_bmp_map), 0, post['can_publish'], post['can_edit'],
                                        post['can_delete']))
                time.sleep(0.9)
                owner_posts = self._vk_api.wall.get(owner_id="-" + str(group), count="3", filter="owner", v=self._api_v)
                for post in owner_posts['items']:
                    posts_info.append((post['id'], group_db_id, post['from_id'], post['owner_id'],
                                        0, post['date'], post['marked_as_ads'], post['post_type'],
                                        post['text'], post['can_pin'], 0, 0,
                                        post['can_delete']))
                time.sleep(0.9)

            return posts_info


    instance = None
    def __init__(self, token, user_id, api_v):
        if not VkSession.instance:
            VkSession.instance = VkSession.__VkSession(token, user_id, api_v)
        else:
            VkSession.instance._token = token
            VkSession.instance._user_id = user_id
            VkSession.instance._api_v = api_v
            VkSession.instance._session = vk.AuthSession(access_token=token)
            VkSession.instance._vk_api = vk.API(self._session)
            VkSession.instance._cache = CacheDatabase(self._user_id)
            VkSession.instance.load_cache()

    def __getattr__(self, name):
        return getattr(self.instance, name)
