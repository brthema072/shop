class AuthException implements Exception{

  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "Email já cadastrado",
    "OPERATION_NOT_ALLOWED": "Operação não permitida. Tente mais tarde",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Bloqueamos todos os pedidos deste dispositivo devido a atividades incomuns. Tente mais tarde.",
    "EMAIL_NOT_FOUND": "Email não encontrado",
    "INVALID_PASSWORD": "Senha inválida",
    "USER_DISABLED": "Usuário desativado",
  };
  
  final String key;

  const AuthException(this.key);

  @override
  String toString(){
    if(errors.containsKey(key)){
      return errors[key];
    }else{
      return "Ocorreu um erro na sua aplicação!";
    }
  }
}