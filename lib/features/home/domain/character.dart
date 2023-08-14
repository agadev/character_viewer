class Character {
  final String title;
  final String description;
  final String imageUrl;

  Character({required this.title, required this.description, required this.imageUrl});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      title: json['FirstURL'].split('/').last.replaceAll('_', ' '),
      description: json['Text'],
      imageUrl: IconRes.fromJson(json["Icon"]).url ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "FirstURL": title,
        "Icon": imageUrl,
        "Text": description,
      };
}

class IconRes {
  String? height;
  String? url;
  String? width;

  IconRes({
    this.height,
    this.url,
    this.width,
  });

  factory IconRes.fromJson(Map<String, dynamic> json) => IconRes(
        height: json["Height"],
        url: json["URL"],
        width: json["Width"],
      );

  Map<String, dynamic> toJson() => {
        "Height": height,
        "URL": url,
        "Width": width,
      };
}
