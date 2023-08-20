import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({required this.token});

  /// const LoginHandle.fooBar() : token = 'foobar';
  ///
  /// Is a special constructor called a factory constructor.
  /// Factory constructors are used to create instances of a class in a way
  /// that might differ from the normal constructor process.
  /// In this case, the fooBar factory constructor creates an instance of
  /// LoginHandle with a token value of 'foobar'.
  const LoginHandle.fooBar() : token = 'foobar';

  /// @override
  /// bool operator ==(covariant LoginHandle other) => token == other.token;
  ///
  /// This method overrides the equality operator (==).
  /// It compares the token property of two LoginHandle instances
  /// and returns true if they have the same token value.
  /// The covariant keyword allows the parameter type to be a subtype of
  /// the current class.
  ///
  /// Example:
  /// void main() {
  /// final handle1 = LoginHandle(token: 'abcdef');
  ///   final handle2 = LoginHandle(token: 'abcdef');
  ///   final handle3 = LoginHandle.fooBar();

  /// Using the overridden == operator
  ///   print(handle1 == handle2); // Output: true
  ///   print(handle1 == handle3); // Output: false
  /// }
  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle (toke = $token)';
}

enum LoginErrors {
  invalidHandle,
}

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() => 'Note (title = $title)';
}

final mockNotes = Iterable.generate(3, (i) => Note(title: 'Note ${i + 1}'));
