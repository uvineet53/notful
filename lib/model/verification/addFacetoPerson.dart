class AddFacetoPerson {
  AddFacetoPerson({
    this.status,
    this.message,
    this.id,
    this.url,
  });

  String status;
  String message;
  int id;
  String url;

  factory AddFacetoPerson.fromJson(Map<String, dynamic> json) =>
      AddFacetoPerson(
        status: json["status"],
        message: json["message"],
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
        "url": url,
      };
}
