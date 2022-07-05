import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class User {
  String name;
  String? email;
  User({required this.name, this.email});
  storeLoginInformation() {
    _setToSharedPreferences(email!);
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  }
}
