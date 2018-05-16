class Register {

//  String _url = "https://api.dcoupon.eu/id/register";

  Map<String, String> body = {"emailAddress":"ixxgznle@sharklasers.com","password":"password","appId":"dcoupondev","alias":"Nombre","gender":"MALE","dob":"2004-04-10","lang":"es","source":"https://es.dcoupon.eu/market/"};

  Map<String, String> headers = {"Content-Type" : "application/json", "Authorization": "JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzYWRhNmFhNC1lY2UyLTQyMjAtYTVkMi0xYjBiY2FhYWM5NmMiLCJpc3MiOiJkY291cG9uLmNvbSIsImlhdCI6MTUyNjI4ODYzMSwiZXhwIjoxNTU3ODI0NjMxLCJzdWIiOiIxODgyNyIsImVtYWlsIjoiZWVwc2Zldm1Ac2hhcmtsYXNlcnMuY29tIiwiYWxpYXMiOiJOb21icmUiLCJyZWd0eXAiOiJlbWFpbCJ9.O-bpKSLYbZpREejOqVy4ENFoRG-0F2Ove21SSroKS4w"};

  Map<String, dynamic> response = {"statusCode":201,"message":"User created verify to confirm"};

}