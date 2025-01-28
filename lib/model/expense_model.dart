/*
* Model class for Expense
*/
class Expense {
  final int? id;
  final double amount;
  final String description;
  final String date;
  final String? category;

  Expense(
      {this.id,
      required this.amount,
      required this.description,
      required this.date,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date,
      'category': category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      date: map['date'],
      category: map['category'],
    );
  }
}
