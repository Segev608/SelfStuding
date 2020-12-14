import smtplib
import ssl
import requests
import time
from bs4 import BeautifulSoup
from googletrans import Translator
import hashlib
from getpass import getpass


# static function to translate value from hebrew to english
def translate(book_name):
    translator = Translator()
    try:
        result = translator.translate(book_name)
        print(result.text)
        return result.text
    except AttributeError:
        # sometimes the translation works on second attempt
        time.sleep(1)
        translate(book_name)


# handle password in order to send mail
def handle_password(password_key):
    # get password and compare to the one which was hashed
    password = hashlib.md5(password_key.encode()).digest()
    return b'bb%|\xdfP\xba\xa7\xcaTH\x16\xac\x84\x97P' == password


# this function creates a progress bar for places which has
# long waiting time
def printProgressBar(iteration, total, prefix='', suffix='', decimals=1, length=100, fill='█', printEnd="\r"):
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f'\r{prefix} |{bar}| {percent}% {suffix}', end=printEnd)
    # Print New Line on Complete
    if iteration == total:
        print()


# scan the database after books that turned to available
def check_availability(database, library):  # # # here # # #
    printProgressBar(0, len(database.show_database()), prefix='progress', suffix='Complete')
    i = 0
    ready_to_order = []
    for b_title, book_url in database.show_database().items():
        num = library.get_quantity(book_url)
        if int(num) != 0:
            ready_to_order.append(b_title)
        i += 1
        printProgressBar(i, len(database.show_database()), prefix='progress', suffix='Complete')
    return (" => ready to order\r\n".join(map(str, ready_to_order))) + str(" => ready to order")


class Handle_Email(object):
    def __init__(self, receiver):
        # must-have variables to initiate the
        # server and to the email properly

        self.port = 587  # SMTP port
        self.smtp_server = "smtp.gmail.com"  # server address
        self.sender_email = "translations272@gmail.com"  # email updater
        self.receiver_email = receiver  # "segev608@gmail.com"  to person who gets the update
        self.message = None  # The content of the email

    # takes care for initialize the server and send the email text
    def send_email(self, message, password):
        if not handle_password(getpass()):  # invalid password
            raise PermissionError

        self.message = message
        context = ssl.create_default_context()
        with smtplib.SMTP(self.smtp_server, self.port) as server:
            server.ehlo()
            server.starttls(context=context)
            server.ehlo()
            server.login(self.sender_email, password)
            server.sendmail(self.sender_email, self.receiver_email, self.message)


class Handle_Library(object):
    def __init__(self):
        self.attempts = 0

    # returns the website page
    def get_response(self, link):
        page = None
        try:
            page = requests.get(link)
        except requests.exceptions.Timeout:
            if self.attempts == 10:
                print("ERROR: Cannot create connection with the website! - try later")
                return
            self.attempts += 1
            time.sleep(3)  # wait 3 second and then retry!
            self.get_response(link)
        except requests.exceptions.TooManyRedirects:
            print("ERROR: There was an error trying to get information from the given address - try another address")
            return
        except requests.exceptions.RequestException as e:
            print("ERROR: catastrophic error - " + str(e))
            return
        if page is None:
            if self.attempts == 3:
                print("ERROR: Could not load web-page - try again later")
                raise RuntimeWarning
            self.attempts += 1
            self.get_response(link)
        self.attempts = 0  # reset the attempts for next time
        return BeautifulSoup(page.content, 'html.parser')

    # extract the book quantity from the web-page
    def get_quantity(self, link):
        try:
            soup = self.get_response(link)
        except RuntimeWarning:
            raise RuntimeWarning  # Bubble up the problem

        quantity = soup.find_all('span', {'class': 'bidie'})  # number of available books
        return quantity[1].text

    def get_title(self, link):
        soup = self.get_response(link)
        book_title = soup.find_all('span', {'class': 'bidi'})  # the title of the current book
        title = translate(str(book_title[0].text))
        if title == 'None':
            print(book_title[0].text is None)
            time.sleep(1)
            return self.get_title(link)
        else:
            return title


