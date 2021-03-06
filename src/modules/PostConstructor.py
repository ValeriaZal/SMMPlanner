class PostConstructor:
    def __init__(self, vk_api, api_v):
        self._vk_api = vk_api
        self._api_v = api_v

    def create_post(self, post):
        tags = ""
        print("PostConstructor::create_post::post[1]:{}".format(post[1]))
        unique_tags = list(set(post[1]))
        for tag in unique_tags:
            tags += f"{tag} "
        message = f"{post[3]}\n\n{tags}"
        publish_date = post[2]
        return message, publish_date

    def publish_post(self, group_id, message, publish_date):
        self._vk_api.wall.post(owner_id=f"-{group_id}", from_group=1, message=message, publish_date=publish_date, v=self._api_v)
