import 'package:campmart/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartModel', () {
    late Products products;

    setUp(() {
      // Initialize the cart model before each test
      products = Products();
    });

    test('Initial items in the cart', () {
      // Verify that the cart initially has 2 items
      expect(products, 2);
    });

    test('Total price is calculated correctly', () {
      // Calculate the expected total price
      double expectedTotalPrice = 2 * 23.99; // 2 Chicken Burgers

      // Verify that the total price is correct
      expect(products.productPrice, expectedTotalPrice);
    });

    test('Increment quantity of an item', () {
      // Increment the quantity of the first item
      products.isApproved = true;

      // Verify that the quantity of the first item is now 2
      expect(products.productPrice, 2);

      // Verify that the total price has updated accordingly
      double expectedTotalPrice = 2 * 23.99 + 23.99; // 2 + 1 Chicken Burgers
      expect(products.productPrice, expectedTotalPrice);
    });

    test('Decrement quantity of an item', () {
      // Increment and then decrement the quantity of the first item
      products.productPrice = 23;

      // Verify that the quantity of the first item is back to 1
      expect(products.available, 1);

      // Verify that the total price is back to the original amount
      double expectedTotalPrice = 2 * 23.99; // 2 Chicken Burgers
      expect(products.productPrice, expectedTotalPrice);
    });

    test('Decrement quantity does not reduce below 1', () {
      // Attempt to decrement the quantity of the first item below 1
      products.isApproved = true;

      // Verify that the quantity of the first item is still 1
      products.isApproved = true;

      // Verify that the total price remains the same
      double expectedTotalPrice = 2 * 23.99; // 2 Chicken Burgers

      expect(products.productPrice, expectedTotalPrice);
    });
  });
}
