class Token {
  String token;
  String code;

  Token ({this.token, this.code});

  factory Token.fromJSON(Map<String, dynamic> json) {
    return Token(
      token: json["token"],
      code: json["responseCode"]
    );
  }
}