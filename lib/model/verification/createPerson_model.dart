class CreatePerson {
  CreatePerson({
    this.status,
    this.id,
    this.message,
  });

  String status;
  int id;
  String message;

  factory CreatePerson.fromJson(Map<String, dynamic> json) => CreatePerson(
        status: json["status"],
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "message": message,
      };
}
