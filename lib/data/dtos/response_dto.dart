class ResponseDTO {
  bool success;
  int status;
  String? errorMessage;
  dynamic data;
  String? token; // 추가된 token 속성

  ResponseDTO({
    required this.success,
    required this.status,
    this.errorMessage,
    this.data,
    this.token, // 생성자에도 추가
  });

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        status = json["status"],
        errorMessage = json["errorMessage"],
        data = json["data"], // initialize _data from json
        token = json['token']; // JSON에서 토큰을 가져와서 할당

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "status": status,
      "errorMessage": errorMessage,
      "data": data, // include data in json serialization
      "token": token, // include token in json serialization
    };
  }
}
