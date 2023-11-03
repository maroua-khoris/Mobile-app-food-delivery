class ResponseModel{
  bool _isSucces;
  String _message;
  ResponseModel(this._isSucces,this._message);
  String get message=>_message;
  bool get isSucess=>_isSucces;
}