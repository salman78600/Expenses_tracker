class Expense {
  final int? id;
  final double amount;
  final String description;
  final String date;

  Expense(
      {this.id,
      required this.amount,
      required this.description,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      date: map['date'],
    );
  }
}
