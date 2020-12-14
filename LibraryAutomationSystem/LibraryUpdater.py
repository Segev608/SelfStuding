# coding: utf-8

import argparse
from LibraryAutomationSystem import HandleWebsiteRequest, DataBase

update_rate = 900  # requests are sending every 15 minute by default

view_list = False
link = None
live_tracking = False
remove_book = None


def parse_flags():
    global link, update_rate, view_list, live_tracking, remove_book
    parser = argparse.ArgumentParser()
    # insert the args variables to CLI for help
    parser.add_argument("-i", "--link", action="store_true", help="pass new url to the book you want")
    parser.add_argument("-u", "--updateRate", help="the duration between each update from server in seconds")
    parser.add_argument("-vC", "--view", action="store_true", help="view current books")
    parser.add_argument("-lT", "--liveTracking", action="store_true", help="view current books")
    parser.add_argument("-r", "--remove", help="remove book from tracking")
    args = parser.parse_args()
    if args.link:
        set_url()    # set new link to track after from urls.txt file
    if args.updateRate:
        update_rate = args.updateRate   # update rate in seconds
    if args.remove:
        remove_book = args.remove
    view_list = args.view   # is the user wants to see all the books?
    live_tracking = args.liveTracking # see updates every @update_rate seconds?


# use the txt file to load url from user
def set_url():
    global link
    with open('/LibraryAutomationSystem/input_urls.txt', 'r') as read:
        url_file = read.read()
        link = url_file


if __name__ == "__main__":
    parse_flags()

    # initializations
    req = HandleWebsiteRequest.Handle_Library()
    email = HandleWebsiteRequest.Handle_Email("segev608@gmail.com")
    my_db = DataBase.DataBase('libraryTrackerTEST.pkl')
    if view_list:
        try:
            print(str(my_db))
        except EOFError:
            print("Database is empty!")
        except RuntimeWarning:
            print("ERROR - Could not present the database currently, try later")

    if remove_book is not None:
        my_db.remove_book(remove_book)

    if link is not None:  # user wants to update the list
        my_db.insert_item(req.get_title(link), link)
        my_db.update_database()
        print("database has just updated. Currently:\n"+str(my_db))

    if live_tracking:
        print(HandleWebsiteRequest.check_availability(my_db, req))
        # while not HandleWebsiteRequest.check_availability(my_db, req):
        #     print(f"next update - {update_rate / 60} minutes")
        #     time.sleep(update_rate)
        # title = req.get_title(link)
        # print(f"{title} is found in the library - email is about to be sent!")
        # remove book from database after email has sent



    #     while not check_availability():
    #         print(f"next update - {update_rate/60} minutes")
    #         time.sleep(update_rate)
    #     title = check_availability()
    #     print(f"{title} is found in the library - email is about to be sent!")
    #     # if handle_password(getpass()):
    #     #     send_update_email(key)
    #     #     print('success')
    #     # else:
    #     #     print('ERROR: Invalid_password - Program closed!')
    # if view_list:
    #     books_database = load_items()
    #     for title, _ in books_database.items():
    #         print(str(title) + '\r\n')
