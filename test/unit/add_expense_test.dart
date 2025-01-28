// import 'package:bloc_test/bloc_test.dart';
// import 'package:expenses_tracker/bloc/expense/expense_bloc_bloc.dart';
// import 'package:expenses_tracker/model/expense_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockExpenseBloc extends MockBloc<ExpenseEvent, ExpenseState>
//     implements ExpenseBloc {}

// class MockBuildContext extends Mock implements BuildContext {}

// void main() {
//   late MockExpenseBloc mockExpenseBloc;

//   setUp(() {
//     mockExpenseBloc = MockExpenseBloc();
//   });

//   group('AddExpense', () {
//     final expense = Expense(
//       amount: 100.0,
//       description: 'Test expense',
//       date: '01-01-2023',
//       category: 'Test Category',
//     );

//     blocTest<MockExpenseBloc, ExpenseState>(
//       'emits [ExpenseLoading, ExpenseSuccess] when AddExpense is added',
//       build: () => mockExpenseBloc,
//       act: (bloc) => bloc.add(AddExpense(expense, MockBuildContext())),
//       expect: () => [
//         ExpenseLoading(),
//         ExpenseSuccess('Expense added successfully'),
//       ],
//       verify: (_) {
//         verify(() =>
//                 mockExpenseBloc.add(AddExpense(expense, MockBuildContext())))
//             .called(1);
//       },
//     );

//     blocTest<MockExpenseBloc, ExpenseState>(
//       'emits [ExpenseLoading, ExpenseError] when AddExpense is added and fails',
//       build: () => mockExpenseBloc,
//       act: (bloc) {
//         whenListen(
//           mockExpenseBloc,
//           Stream.fromIterable(
//               [ExpenseLoading(), ExpenseError('Failed to add expense')]),
//         );
//         bloc.add(AddExpense(expense, MockBuildContext()));
//       },
//       expect: () => [
//         ExpenseLoading(),
//         ExpenseError('Failed to add expense'),
//       ],
//       verify: (_) {
//         verify(() =>
//                 mockExpenseBloc.add(AddExpense(expense, MockBuildContext())))
//             .called(1);
//       },
//     );

//     blocTest<MockExpenseBloc, ExpenseState>(
//       'emits [ExpenseLoading, ExpenseSuccess] when AddExpense is added with different data',
//       build: () => mockExpenseBloc,
//       act: (bloc) {
//         final differentExpense = Expense(
//           amount: 200.0,
//           description: 'Another test expense',
//           date: '02-02-2023',
//           category: 'Another Test Category',
//         );
//         bloc.add(AddExpense(differentExpense, MockBuildContext()));
//       },
//       expect: () => [
//         ExpenseLoading(),
//         ExpenseSuccess('Expense added successfully'),
//       ],
//       verify: (_) {
//         verify(() => mockExpenseBloc.add(AddExpense(any(), MockBuildContext())))
//             .called(1);
//       },
//     );
//   });
// }
