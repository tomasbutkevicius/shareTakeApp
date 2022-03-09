
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NavigationParams extends Equatable {
  const NavigationParams();
}

@immutable
class NavigationParamsHome extends NavigationParams {
  final String title;

  const NavigationParamsHome({required this.title});

  @override
  List<Object> get props => [title];
}