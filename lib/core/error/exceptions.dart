import 'package:movie_app/core/network/error_message_model.dart';

class ServerExceptions implements Exception
{
final ErrorMessageModel errorMessageModel;
const ServerExceptions({required this.errorMessageModel});
}

class LocalExceptions implements Exception
{final String message;
  const LocalExceptions ({required this.message});
}