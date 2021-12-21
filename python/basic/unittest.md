# unittest

1. demo_code

    ```python
        # ~/tests/test_xx.py
        import unittest

        class TestCrypt(unittest.TestCase):

        def test_dewu_sign(self):
            query_string = {
                "catId": 2
            }
            self.assertAlmostEqual(dewu_sign(query_string), '23b0ee4fedbc330db564b451e2ae75e5')

        # 非必需
        if __name__ == '__main__':
            unittest.main()
    ```

2. run

    ```shell
    python3 -m unittest
    python3 test_xx.py
    ```
