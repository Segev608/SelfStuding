import pickle
import os.path
import pathlib
from LibraryAutomationSystem.HandleWebsiteRequest import Handle_Library


class DataBase(object):
    # constructor
    def __init__(self, db_name):
        self.file_path = pathlib.Path(__file__).parent.absolute()
        self.database_name = db_name
        self.database = dict()
        if not os.path.exists(f"{str(self.file_path)}\\{self.database_name}"):
            with open(f"{str(self.file_path)}\\{self.database_name}", 'w'):
                pass
        if os.path.getsize(f"{str(self.file_path)}\\{self.database_name}") > 0:
            self.database = self.show_database()
        print('[Welcome Back - Library Updater - Version 1.0.1]')

    # insert one item (name, url) into database
    def insert_item(self, book_name, book_url):
        # load the database and then update it
        if os.path.getsize(f"{str(self.file_path)}\\{self.database_name}") > 0:
            with open(f"{str(self.file_path)}\\{self.database_name}", "rb") as read:
                self.database = pickle.load(read)

        self.database[book_name] = book_url

        with open(f"{str(self.file_path)}\\{self.database_name}", "wb") as write:
            pickle.dump(self.database, write)

    # validate correctness of database
    def update_database(self):
        with open(f"{str(self.file_path)}\\{self.database_name}", "wb") as update:
            pickle.dump(self.database, update)

    # returns the full database as dictionary
    def show_database(self):
        if os.path.getsize(f"{str(self.file_path)}\\{self.database_name}") == 0:  # file is empty
            raise EOFError

        db = dict()
        with open(f"{str(self.file_path)}\\{self.database_name}", "rb") as show:
            db = pickle.load(show)
        return db

    # remove one book element
    def remove_book(self, book_name):
        # prepare the database instance to removal
        with open(f"{str(self.file_path)}\\{self.database_name}", "rb") as delete:
            self.database = pickle.load(delete)

        delete = input("Are you sure? [Y/n]")
        if delete.lower() == 'y':
            try:
                del self.database[book_name]
                self.update_database()
            except KeyError:
                print("ERROR - cannot find book do delete")
                return
            print("The book has been successfully deleted")
        else:
            print("Operation canceled")

    def __str__(self):
        lib = Handle_Library()
        output = ""
        for (name, url) in self.database.items():
            output += f"[+]  {name} has {lib.get_quantity(url)} copies \r\n"
        return output

