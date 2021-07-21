from abc import ABC, abstractclassmethod
from flaskext.mysql import MySQL
from pymysql import NULL


class DB(ABC):
    __db_name = ""
    __query = ""
    __data = ""
    rows = NULL

    def __init__(self, app) -> None:
        super().__init__()
        self.__mysql = MySQL()
        self.__app = app
        self.__db_host = ""
        self.__db_user = ""
        self.__db_pass = ""

    @abstractclassmethod
    def querySelect(self):
        pass

    @abstractclassmethod
    def queryExec(self):
        pass

    def setDBName(self, db_name):
        self.__db_name = db_name

    def __open_conn(self):
        self.__conn = self.__mysql.connect()
        self.__cursor = self.__conn.cursor()

    def __close_conn(self):
        self.__cursor.close()
        self.__conn.close()

    def __commit_conn(self):
        self.__conn.commit()

    def init_app(self):
        self.__app.config['MYSQL_DATABASE_HOST'] = self.__db_host
        self.__app.config['MYSQL_DATABASE_USER'] = self.__db_user
        self.__app.config['MYSQL_DATABASE_PASSWORD'] = self.__db_pass
        self.__app.config['MYSQL_DATABASE_DB'] = self.__db_name
        self.__mysql.init_app(self.__app)

    def execute_simple_query(self, sql, data):
        self.__query = sql
        self.__data = data
        try:
            self.__open_conn()
            self.__conn.begin()
            self.__cursor.execute(self.__query, self.__data)
            self.__commit_conn()
        except:
            self.__conn.rollback()
        finally:
            self.__close_conn()
            self.__query = ""
            self.__data = ""

    def get_results_from_query(self, sql, data):
        self.__query = sql
        self.__data = data
        self.rows = NULL
        try:
            self.__open_conn()
            self.__conn.begin()
            if self.__data:
                self.__cursor.execute(self.__query, self.__data)
            else:
                self.__cursor.execute(self.__query)

            self.rows = self.__cursor.fetchall()
            self.__commit_conn()
        except:
            self.__conn.rollback()
        finally:
            self.__close_conn()
            self.__query = ""
            self.__data = ""
