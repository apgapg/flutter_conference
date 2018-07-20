import 'package:flutter/cupertino.dart';
import 'package:flutter_conference/bloc.dart';

class Provider extends InheritedWidget {

  Provider({Key key, Widget child})
      : super(key: key, child: child);
  final bloc = new Bloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
