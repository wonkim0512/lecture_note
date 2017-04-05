import unittest
from ex1.py import print_url_n_times

class URLTest(unittest, TestCase):
    def test_url(self):
        self.assertEqual(print_url_n_times(3, "http://naver.com", True)

if __name__("__main__"):
    unittest.main()
