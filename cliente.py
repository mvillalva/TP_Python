from db import *


class Cliente(DB):

    def __init__(self, app) -> None:
        super().__init__(app)
        self.setDBName("resto")
        self.init_app()

    def querySelect(self, sql, data=""):
        self.get_results_from_query(sql, data)
        return self.rows

    def queryExec(self, sql, data):
        self.execute_simple_query(sql, data)
