    
import 'package:dio/dio.dart';

abstract class Failure {

      final String errMessage;

  Failure({required this.errMessage});
}


 class SeviceFailure extends Failure {
  SeviceFailure({required super.errMessage});

 
}