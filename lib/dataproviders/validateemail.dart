class ValidateEmail {

//  String _url = "https://api.dcoupon.eu/id/validate";

  Map<String, String> body = {"email":"eepsfevm@sharklasers.com","registrationType":"EMAIL"};

  Map<String, dynamic> badResponse = {"responseCode": 101,"error": "ERROR.CONFLICT"};
  Map<String, dynamic> goodResponse = {"responseCode":105,"error":"EMAIL.NOT.IN.USE"};

  Map<String, String> headers = {"Content-Type" : "application/json", "Authorization": "JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzYWRhNmFhNC1lY2UyLTQyMjAtYTVkMi0xYjBiY2FhYWM5NmMiLCJpc3MiOiJkY291cG9uLmNvbSIsImlhdCI6MTUyNjI4ODYzMSwiZXhwIjoxNTU3ODI0NjMxLCJzdWIiOiIxODgyNyIsImVtYWlsIjoiZWVwc2Zldm1Ac2hhcmtsYXNlcnMuY29tIiwiYWxpYXMiOiJOb21icmUiLCJyZWd0eXAiOiJlbWFpbCJ9.O-bpKSLYbZpREejOqVy4ENFoRG-0F2Ove21SSroKS4w"};

}