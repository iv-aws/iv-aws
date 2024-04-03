import unittest

from .main import lambda_handler, lambda_helper

class HelloTests(unittest.TestCase):

    def test_initialize(self):
        lh = lambda_handler
        self.assertIsNotNone(lh)

    def test_hello_ok(self):
        result = lambda_helper()
        self.assertEqual(200, result['statusCode'])

    def test_hello_body(self):
        result = lambda_helper()
        self.assertEqual('Hello World', result['body'])


if __name__ == '__main__':
    unittest.main()