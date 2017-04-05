import argparse
import requests
from bs4 import BeautifulSoup

parser = argparse.ArgumentParser()

parser.add_argument('--number', '-n', help = 'number of requests', type = int)
parser.add_argument('--url', '-u', help = 'url to make http request')
args = parser.parse_args()

url = args.url
number = args.number


def print_url_n_times(number, url):
    for i in range(number):
        try:
            res = requests.get(args.url)
            content = res.text
            soup = BeautifulSoup(content)
            print soup.title.get_text()

        except:
            return False

    return True

print_url_n_times(number, url)
