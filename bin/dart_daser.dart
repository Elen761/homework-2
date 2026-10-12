import 'dart:async';

void main() async {
  print('========================================');
  print('             ՀԵՇՏ ՄԱԿԱՐԴԱԿ             ');
  print('========================================');

  List<String> shoppingList = ['Կաթ', 'Հաց'];
  shoppingList.add('Պանիր');
  shoppingList.insert(1, 'Ձու');
  shoppingList.removeAt(0);
  shoppingList[1] = 'Կարագ';
  if (shoppingList.isNotEmpty) {
    print('Առաջին ապրանքը: ${shoppingList.first}');
    print('Վերջին ապրանքը: ${shoppingList.last}');
  }
  print('Ցուցակը դատարկ է՞: ${shoppingList.isEmpty}');
  print('Գնումների ցուցակը: $shoppingList\n');

  Book myBook = Book('Dart Programming', 'John Doe', 300);
  print(myBook.getInfo());

  int sum = await sumValues(5, 10);
  print('sumValues(5, 10) արդյունքը: $sum\n');

  print('========================================');
  print('            ՄԻՋԻՆ ՄԱԿԱՐԴԱԿ            ');
  print('========================================');

  List<Vehicle> vehicles = [Car(8.0), Motorcycle(4.5)];
  double totalFuel = totalConsumption(vehicles, 200.0);
  print('Ընդհանուր վառելիք (200կմ-ի համար): $totalFuel լիտր');

  List<Product> products = [
    Product('Խնձոր', 'Միրգ', 500),
    Product('Բանան', 'Միրգ', 700),
    Product('Հաց', 'Հացաբուլկեղեն', 300),
  ];
  Map<String, double> categoryTotals = totalByCategory(products);
  print('Գներն ըստ կատեգորիաների: $categoryTotals');

  int safeRes1 = await safeGetNumber(50);
  int safeRes2 = await safeGetNumber(-5);
  print('safeGetNumber(50) = $safeRes1');
  print('safeGetNumber(-5) = $safeRes2\n');

  print('========================================');
  print('            ԲԱՐԴ ՄԱԿԱՐԴԱԿ             ');
  print('========================================');

  Payment cardPay = CardPayment();
  Payment cashPay = CashPayment();
  Payment cryptoPay = CryptoPayment();
  print('Card payment total (1000): ${calculateTotal(cardPay, 1000)}');
  print('Cash payment total (1000): ${calculateTotal(cashPay, 1000)}');
  print('Crypto payment total (1000): ${calculateTotal(cryptoPay, 1000)}');

  List<int> numbers = [2, 7, 11, 15];
  int target = 9;
  List<int> pairIndices = findPair(numbers, target);
  print('Զույգի ինդեքսները (target 9): $pairIndices');

  print('Սկսվում են ասինխրոն առաջադրանքները...');
  List<String> taskResults = await runTasks();
  print('Tasks results: $taskResults');
  print('========================================');
}

class Book {
  String title;
  String author;
  int pages;

  Book(this.title, this.author, this.pages);

  String getInfo() {
    return "$title by $author, $pages pages";
  }
}

Future<int> delayedValue(int value) async {
  await Future.delayed(Duration(milliseconds: 100));
  return value;
}

Future<int> sumValues(int a, int b) async {
  int valA = await delayedValue(a);
  int valB = await delayedValue(b);
  return valA + valB;
}

abstract class Vehicle {
  double fuelConsumption();
}

class Car extends Vehicle {
  double litersPer100Km;

  Car(this.litersPer100Km);

  @override
  double fuelConsumption() => litersPer100Km;
}

class Motorcycle extends Vehicle {
  double litersPer100Km;

  Motorcycle(this.litersPer100Km);

  @override
  double fuelConsumption() => litersPer100Km;
}

double totalConsumption(List<Vehicle> vehicles, double distance) {
  double total = 0;
  for (var vehicle in vehicles) {
    total += vehicle.fuelConsumption() * distance / 100;
  }
  return total;
}

class Product {
  String name;
  String category;
  double price;

  Product(this.name, this.category, this.price);
}

Map<String, double> totalByCategory(List<Product> products) {
  Map<String, double> result = {};
  for (var product in products) {
    result[product.category] = (result[product.category] ?? 0) + product.price;
  }
  return result;
}

Future<int> getNumber(int value) async {
  await Future.delayed(Duration(milliseconds: 100));
  if (value > 0) {
    return value;
  } else {
    throw Exception('Value must be greater than 0');
  }
}

Future<int> safeGetNumber(int value) async {
  try {
    return await getNumber(value);
  } catch (e) {
    return 0;
  }
}

abstract class Payment {
  double calculateFee(double amount);
}

class CardPayment extends Payment {
  @override
  double calculateFee(double amount) => amount * 0.02;
}

class CashPayment extends Payment {
  @override
  double calculateFee(double amount) => 0.0;
}

class CryptoPayment extends Payment {
  @override
  double calculateFee(double amount) => amount * 0.05;
}

double calculateTotal(Payment payment, double amount) {
  return amount + payment.calculateFee(amount);
}

List<int> findPair(List<int> numbers, int target) {
  Map<int, int> seen = {};
  for (int i = 0; i < numbers.length; i++) {
    int complement = target - numbers[i];
    if (seen.containsKey(complement)) {
      return [seen[complement]!, i];
    }
    seen[numbers[i]] = i;
  }
  return [];
}

Future<String> runTask(String name, int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
  return "Task $name completed";
}

Future<List<String>> runTasks() async {
  List<Future<String>> futures = [
    runTask('A', 100),
    runTask('B', 50),
    runTask('C', 150),
  ];
  return await Future.wait(futures);
}
