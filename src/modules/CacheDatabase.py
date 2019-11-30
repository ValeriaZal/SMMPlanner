# This Python file uses the following encoding: utf-8
import sqlite3
from sqlite3 import Error

class CacheDatabase:
    class __CacheDatabase:
        def __init__(self, user_id):
            self._db = f"D:/Files/Documents/Studying/4_year/rep/SMMPlanner/src/user_cache/{user_id}/cache.db"
            print(self._db)
            self._conn = None
            self._create_connection()
            self._tables = self._create_tables()

        def _create_connection(self):
            self._conn = None
            try:
                self._conn = sqlite3.connect(self._db)
            except Error as e:
                print(e)

        def _create_table(self, create_table_sql):
            try:
                c = self._conn.cursor()
                c.execute(create_table_sql)
            except Error as e:
                print(e)
        def _create_tables(self):
            sql_create_groups_table = """ CREATE TABLE IF NOT EXISTS groups (
                                            id integer PRIMARY KEY,
                                            vk_id integer,
                                            name text NOT NULL,
                                            screen_name text,
                                            type text NOT NULL,
                                            is_admin integer,
                                            photo_50 text,
                                            photo_100 text,
                                            photo_200 text
                                        ); """
            sql_create_posts_table = """ CREATE TABLE IF NOT EXISTS posts (
                                            id integer PRIMARY KEY,
                                            vk_id integer,
                                            group_id integer,
                                            from_id integer,
                                            owner_id integer,
                                            postponed integer,
                                            date integer,
                                            marked_as_ads integer,
                                            post_type text,
                                            text text,
                                            can_pin integer,
                                            can_publish integer,
                                            can_edit integer,
                                            can_delete integer,
                                            FOREIGN KEY (group_id) REFERENCES groups (id)
                                        ); """
            sql_create_attachments_table = """ CREATE TABLE IF NOT EXISTS attachments (
                                            id integer PRIMARY KEY,
                                            post_id integer,
                                            owner_id integer,
                                            vk_id integer,
                                            type integer NOT NULL,
                                            album_id integer,
                                            date integer,
                                            access_key text,
                                            text text,
                                            FOREIGN KEY (post_id) REFERENCES posts (id)
                                        ); """
            if self._conn is not None:
                self._create_table(sql_create_groups_table)
                self._create_table(sql_create_posts_table)
                self._create_table(sql_create_attachments_table)
                return {"groups":["vk_id","name","screen_name","type","is_admin","photo_50","photo_100","photo_200"],
                        "posts":["vk_id","group_id","from_id","owner_id","postponed","date","marked_as_ads",
                                "post_type","text","can_pin","can_publish","can_edit","can_delete"],
                        "attachments":["post_id","owner_id","vk_id","type","album_id","date","access_key","text"]}
            else:
                print("Error! cannot create the database connection.")
                return None

        def insert(self, table, data):
            if(table in self._tables.keys()):
                if(len(data) == len(self._tables[table])):
                    cols = "("
                    insert_cols = "("
                    for col in self._tables[table]:
                        cols += f"{col},"
                        insert_cols += "?,"
                    cols = cols[:-1] + ")"
                    insert_cols = insert_cols[:-1] + ")"
                    sql = f"INSERT INTO {table} {cols} VALUES {insert_cols}"
                    cur = self._conn.cursor()
                    cur.execute(sql, data)
                    self._conn.commit()
                else:
                    print("Error: invalid data len.\nExpected: {}\nGot: {}".format(len(self._tables[table]), len(self._tables[table])))
            else:
                print(f"Error: cannot find table '{table}'")

        def get_group_id(self, vk_id):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM groups WHERE vk_id=?", (vk_id,))
            rows = cur.fetchall()
            return rows[0][0]

    instance = None
    def __init__(self, user_id):
        if not CacheDatabase.instance:
            CacheDatabase.instance = CacheDatabase.__CacheDatabase(user_id)
        else:
            CacheDatabase.instance._db = f"../user_cache/{user_id}/cache.db"
            CacheDatabase.instance._conn = None
            CacheDatabase.instance._create_connection()
            CacheDatabase.instance._tables = self._create_tables()
            CacheDatabase.instance._conn.commit()

    def __getattr__(self, name):
        return getattr(self.instance, name)