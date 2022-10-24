import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../utilies/appStrings.dart';
import '../utilies/toast.dart';

class InternetCheck{
 checkInternet() async{
   bool result = await InternetConnectionChecker().hasConnection;
   if (result == false) {
     showToast(text: AppStrings.noInternet, state: ToastStates.error);
   }
 }
}