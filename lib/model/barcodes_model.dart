

class BarCodes {
  int barCode;
  String responseuser;

  BarCodes({
    this.barCode,
    this.responseuser,
  });

  factory BarCodes.fromJson(Map<String, dynamic> json) => BarCodes(
    barCode: json["rollNo"],
    responseuser: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "rollNo": barCode,
    "name": responseuser,
  };


  @override
  String toString() {
    // TODO: implement toString
    return """
    id: $barCode,
    name: $responseuser
    ----------------------------------
    """;
  }
}