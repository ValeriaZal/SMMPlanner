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
                                            status integer,
                                            date integer,
                                            text text,
                                            FOREIGN KEY (template_id) REFERENCES templates (id)
                                        ); """
            sql_create_templates_table = """ CREATE TABLE IF NOT EXISTS templates (
                                            id integer PRIMARY KEY,
                                            name text NOT NULL,
                                            group_id integer NOT NULL,
                                            colour text,
                                            date integer,
                                            text text
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
                                            name text NOT NULL
                                        ); """

            sql_create_post_tag_list_table = """ CREATE TABLE IF NOT EXISTS post_tag_list (
                                            id integer PRIMARY KEY,
                                            post_id integer,
                                            tag_id integer,
                                            FOREIGN KEY (tag_id) REFERENCES tags (id),
                                            FOREIGN KEY (post_id) REFERENCES posts (id)
                                        ); """

            sql_create_temp_tag_list_table = """ CREATE TABLE IF NOT EXISTS temp_tag_list (
                                            id integer PRIMARY KEY,
                                            template_id integer,
                                            tag_id integer,
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
                        "templates":["name","group_id","colour","date","text"],
                        "post_attachments":["post_id"],
                        "template_attachments":["post_id"],
                        "tags":["name"],
                        "post_tag_list":["post_id","tag_id"],
                        "temp_tag_list":["template_id","tag_id"]}
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
                    print("Error: invalid data len.\nExpected: {}\nGot: {}".format(len(self._tables[table]), len(data)))
            else:
                print(f"Error: cannot find table '{table}'")

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
