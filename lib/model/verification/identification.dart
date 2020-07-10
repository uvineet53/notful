class Identification {
  Identification({
    this.id,
    this.name,
    this.probability,
    this.rectangle,
  });

  int id;
  String name;
  double probability;
  Rectangle rectangle;

  factory Identification.fromJson(Map<String, dynamic> json) => Identification(
        id: json["id"],
        name: json["name"],
        probability: json["probability"].toDouble(),
        rectangle: Rectangle.fromJson(json["rectangle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "probability": probability,
        "rectangle": rectangle.toJson(),
      };
}

class Rectangle {
  Rectangle({
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  int left;
  int top;
  int right;
  int bottom;

  factory Rectangle.fromJson(Map<String, dynamic> json) => Rectangle(
        left: json["left"],
        top: json["top"],
        right: json["right"],
        bottom: json["bottom"],
      );

  Map<String, dynamic> toJson() => {
        "left": left,
        "top": top,
        "right": right,
        "bottom": bottom,
      };
}
