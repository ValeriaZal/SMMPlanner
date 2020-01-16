# This Python file uses the following encoding: utf-8
import sqlite3
from sqlite3 import Error
import os

class DataDatabase:
    class __DataDatabase:
        def __init__(self, user_id):
            current_dir = os.path.abspath(os.path.dirname(__file__))
            self._create_dirs(user_id)
            db = f"../user_data/{user_id}/data.db"
            self._db = os.path.join(current_dir, db)
            self._conn = None
            self._create_connection()
            self._tables = self._create_tables()
            self.insert_or_ignore("templates", ("Default", "#00d9fb", "", ""))

        def _create_dirs(self, user_id):
            current_dir = os.path.abspath(os.path.dirname(__file__))
            directory = f"../user_data"
            full_path_dir = os.path.join(current_dir, directory)
            if not os.path.exists(full_path_dir):
                os.makedirs(full_path_dir)
            directory = f"../user_data/{user_id}"
            full_path_dir = os.path.join(current_dir, directory)
            if not os.path.exists(full_path_dir):
                os.makedirs(full_path_dir)

        def close(self):
            try:
                self._conn.close()
            except Error as e:
                print(e)

        def delete(self):
            os.remove(self._db)

        def _create_connection(self):
            self._conn = None
            try:
                self._conn = sqlite3.connect(self._db)
                self._conn.commit()

            except Error as e:
                print(e)

        def _create_table(self, create_table_sql):
            try:
                c = self._conn.cursor()
                c.execute(create_table_sql)
                self._conn.commit()
            except Error as e:
                print(e)
        def _create_tables(self):
            sql_create_posts_table = """ CREATE TABLE IF NOT EXISTS posts (
                                            id integer PRIMARY KEY,
                                            name text NOT NULL,
                                            group_id integer NOT NULL,
                                            template_id integer,
                                            status text,
                                            date integer,
                                            text text,
                                            FOREIGN KEY (template_id) REFERENCES templates (id)
                                        ); """
            sql_create_templates_table = """ CREATE TABLE IF NOT EXISTS templates (
                                            id integer PRIMARY KEY,
                                            name text NOT NULL,
                                            colour text,
                                            date integer,
                                            text text,
                                            UNIQUE(name)
                                        ); """
            sql_create_post_attachments_table = """ CREATE TABLE IF NOT EXISTS post_attachments (
                                            id integer PRIMARY KEY,
                                            post_id integer,
                                            FOREIGN KEY (post_id) REFERENCES posts (id)
                                        ); """

            sql_create_template_attachments_table = """ CREATE TABLE IF NOT EXISTS template_attachments (
                                            id integer PRIMARY KEY,
                                            template_id integer,
                                            FOREIGN KEY (template_id) REFERENCES templates (id)
                                        ); """

            sql_create_tags_table = """ CREATE TABLE IF NOT EXISTS tags (
                                            id integer PRIMARY KEY,
                                            name text NOT NULL,
                                            UNIQUE(name)
                                        ); """

            sql_create_post_tag_list_table = """ CREATE TABLE IF NOT EXISTS post_tag_list (
                                            id integer PRIMARY KEY,
                                            post_id integer,
                                            tag_id integer,
                                            UNIQUE(tag_id, post_id),
                                            FOREIGN KEY (tag_id) REFERENCES tags (id),
                                            FOREIGN KEY (post_id) REFERENCES posts (id)
                                        ); """

            sql_create_temp_tag_list_table = """ CREATE TABLE IF NOT EXISTS temp_tag_list (
                                            id integer PRIMARY KEY,
                                            template_id integer,
                                            tag_id integer,
                                            UNIQUE(tag_id, template_id),
                                            FOREIGN KEY (tag_id) REFERENCES tags (id),
                                            FOREIGN KEY (template_id) REFERENCES templates (id)
                                        ); """
            if self._conn is not None:
                self._create_table(sql_create_posts_table)
                self._create_table(sql_create_templates_table)
                self._create_table(sql_create_post_attachments_table)
                self._create_table(sql_create_template_attachments_table)
                self._create_table(sql_create_tags_table)
                self._create_table(sql_create_post_tag_list_table)
                self._create_table(sql_create_temp_tag_list_table)

                return {"posts":["name","group_id","template_id","status","date","text"],
                        "templates":["name","colour","date","text"],
                        "post_attachments":["post_id"],
                        "template_attachments":["post_id"],
                        "tags":["name"],
                        "post_tag_list":["post_id","tag_id"],
                        "temp_tag_list":["template_id","tag_id"]}
            else:
                print("Error! cannot create the database connection.")
                return None

        def insert_or_ignore(self, table, data):
            if(table in self._tables.keys()):
                if(len(data) == len(self._tables[table])):
                    cols = "("
                    insert_cols = "("
                    for col in self._tables[table]:
                        cols += f"{col},"
                        insert_cols += "?,"
                    cols = cols[:-1] + ")"
                    insert_cols = insert_cols[:-1] + ")"
                    sql = f"INSERT OR IGNORE INTO {table} {cols} VALUES {insert_cols}"
                    cur = self._conn.cursor()
                    cur.execute(sql, data)
                    self._conn.commit()
                else:
                    print("Error: invalid data len.\nExpected: {}\nGot: {}".format(len(self._tables[table]), len(data)))
            else:
                print(f"Error: cannot find table '{table}'")

        def insert_or_replace(self, table, data):
            if(table in self._tables.keys()):
                if(len(data) == len(self._tables[table])):
                    cols = "("
                    insert_cols = "("
                    for col in self._tables[table]:
                        cols += f"{col},"
                        insert_cols += "?,"
                    cols = cols[:-1] + ")"
                    insert_cols = insert_cols[:-1] + ")"
                    sql = f"INSERT OR REPLACE INTO {table} {cols} VALUES {insert_cols}"
                    cur = self._conn.cursor()
                    cur.execute(sql, data)
                    self._conn.commit()
                else:
                    print("Error: invalid data len.\nExpected: {}\nGot: {}".format(len(self._tables[table]), len(data)))
            else:
                print(f"Error: cannot find table '{table}'")

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
                    print("DataDatabase::insert::data={}".format(data))
                    cur.execute(sql, data)
                    self._conn.commit()
                else:
                    print("Error: invalid data len.\nExpected: {}\nGot: {}".format(len(self._tables[table]), len(data)))
            else:
                print(f"Error: cannot find table '{table}'")

        def get_posts(self, group_vk_id):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM posts WHERE group_id=?", (f"-{group_vk_id}",))
            rows = cur.fetchall()
            if(len(rows) > 0):
                res = []
                for r in rows:
                    status = "Saved"
                    cur.execute("SELECT * FROM templates WHERE id=?", (f"{r[3]}",))
                    template_rows = cur.fetchall()
                    colour = "#00d9fb"
                    if(len(template_rows) > 0):
                        colour = template_rows[0][2]
                    res.append([r[0], r[1], colour, r[6], status])
                return res
            return []

        def get_posts_by_time(self, group_vk_id, start_time, end_time):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM posts WHERE (group_id=? AND date >= ? AND date <= ?)", (f"-{group_vk_id}",str(start_time), str(end_time)))
            rows = cur.fetchall()
            if(len(rows) > 0):
                res = []
                for r in rows:
                    status = "Saved"
                    cur.execute("SELECT * FROM templates WHERE id=?", (f"{r[3]}",))
                    template_rows = cur.fetchall()
                    colour = "#00d9fb"
                    if(len(template_rows) > 0):
                        colour = template_rows[0][2]
                    res.append([r[0], r[1], colour, r[6], status])
                return res
            return []

        def get_post(self, post_id, group_vk_id):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM posts WHERE id=? AND group_id=?", (post_id, f"-{group_vk_id}"))
            rows = cur.fetchall()
            if(len(rows) > 0):
                colour = "#00d9fb"
                template_name = ""
                cur.execute("SELECT * FROM templates WHERE id=?", (f"{rows[0][3]}",))
                template_rows = cur.fetchall()
                if(len(template_rows) > 0):
                    colour = template_rows[0][2]
                    template_name = template_rows[0][1]
                cur.execute("SELECT * FROM post_tag_list WHERE post_id=?", (f"{rows[0][0]}",))
                tag_list_rows = cur.fetchall()
                tags = []
                if(len(tag_list_rows) > 0):
                    for tag_r in tag_list_rows:
                        cur.execute("SELECT * FROM tags WHERE id=?", (f"{tag_r[2]}",))
                        tags_rows = cur.fetchall()
                        if(len(tags_rows) > 0):
                            tags.append(tags_rows[0][1])
                res = [rows[0][1], template_name, colour, tags, rows[0][5], rows[0][6]]
                return res
            return []

        def get_tags(self):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM tags")
            rows = cur.fetchall()
            if(len(rows) > 0):
                res = []
                for r in rows:
                    res.append(r[1])
                return res
            return []

        def get_templates(self):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM templates")
            rows = cur.fetchall()
            if(len(rows) > 0):
                res = []
                for r in rows:
                    res.append(r[1])
                return res
            return []

        def post_to_save(self, post):
            cur = self._conn.cursor()
            template_id = 1
            cur.execute("SELECT * FROM templates WHERE name=?", (str(post[1]),))
            rows = cur.fetchall()
            if(len(rows) > 0):
                template_id = rows[0][0]
            tuple_post = [post[0],0,template_id,"Saved",post[3],post[4]]
            tags = post[3]
            return tuple_post, tags

        def get_post_id(self, date):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM posts WHERE date=?", (date, ))
            rows = cur.fetchall()
            if(len(rows) > 0):
                return rows[0][0]
            return 0

        def get_tag_id(self, tag):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM tags WHERE name=?", (tag, ))
            rows = cur.fetchall()
            if(len(rows) > 0):
                return rows[0][0]
            return 0

        def get_template_id(self, template_name):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM templates WHERE name=?", (template_name, ))
            rows = cur.fetchall()
            if(len(rows) > 0):
                return rows[0][0]
            return 0

        def delete_post(self, post_id):
            cur = self._conn.cursor()
            cur.execute("DELETE FROM posts WHERE id=?", (post_id, ))
            self._conn.commit()

        def get_template(self, template_name):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM templates WHERE name=?", (template_name, ))
            rows = cur.fetchall()
            res = []
            if(len(rows) > 0):
                res = list(rows[0])[1:]
                cur.execute("SELECT * FROM temp_tag_list WHERE template_id=?", (f"{rows[0][0]}",))
                tag_list_rows = cur.fetchall()
                tags = []
                if(len(tag_list_rows) > 0):
                    for tag_r in tag_list_rows:
                        cur.execute("SELECT * FROM tags WHERE id=?", (f"{tag_r[2]}",))
                        tags_rows = cur.fetchall()
                        if(len(tags_rows) > 0):
                            tags.append(tags_rows[0][1])
                res.append(tags)
                return res
            return []

        def delete_template(self, template_id):
            cur = self._conn.cursor()
            cur.execute("DELETE FROM templates WHERE id=?", (template_id, ))
            self._conn.commit()

        def change_post_templates(self, template_id):
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM posts WHERE template_id=?", (template_id, ))
            rows = cur.fetchall()
            res = []
            if(len(rows) > 0):
                default_id = self.get_template_id("Default")
                for r in rows:
                    cur.execute(f"UPDATE posts SET template_id={default_id} WHERE template_id={template_id} AND id={r[0]}")
                    self._conn.commit()
                return True
            return False

    instance = None
    def __init__(self, user_id):
        if not DataDatabase.instance:
            DataDatabase.instance = DataDatabase.__DataDatabase(user_id)
        else:
            current_dir = os.path.abspath(os.path.dirname(__file__))
            DataDatabase.instance._create_dirs(user_id)
            db = f"../user_data/{user_id}/data.db"
            DataDatabase.instance._db = os.path.join(current_dir, db)
            DataDatabase.instance._conn = None
            DataDatabase.instance._create_connection()
            DataDatabase.instance._tables = self._create_tables()

    def __getattr__(self, name):
        return getattr(self.instance, name)
