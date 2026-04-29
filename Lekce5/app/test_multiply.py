from unittest import TestCase
from .calculator import nasobeni
class TestMultiply(TestCase):
    def test_multiply_integers(self):
        self.assertEqual(nasobeni(2, 3), 6)

    def test_multiply_floats(self):
        self.assertEqual(nasobeni(2.5, 4.0), 10.0)

    def test_multiply_integer_and_float(self):
        self.assertEqual(nasobeni(2, 4.0), 8.0)
    def test_multiply_zero(self):
        self.assertEqual(nasobeni(0, 5), 0)
        self.assertEqual(nasobeni(5, 0), 0)
    
    def test_multiply_negative_numbers(self):
        self.assertEqual(nasobeni(-2, 3), -6)
        self.assertEqual(nasobeni(2, -3), -6)
        self.assertEqual(nasobeni(-2, -3), 6)
    def test_multiply_large_numbers(self):
        self.assertEqual(nasobeni(1000000, 2000000), 2000000000000)
        self.assertEqual(nasobeni(1e6, 2e6), 2e12)
    def test_multiply_small_numbers(self):
        self.assertEqual(nasobeni(0.0001, 0.0002), 0.00000002)
        self.assertEqual(nasobeni(1e-4, 2e-4), 2e-8)
    def test_multiply_with_none(self):
        with self.assertRaises(TypeError):
            nasobeni(None, 3)
        with self.assertRaises(TypeError):
            nasobeni(2, None)
        with self.assertRaises(TypeError):
            nasobeni(None, None)

        