class GroupModel {
  final int id;
  final String name;
  final String description;
  final String logoImage;
  final String openDate;
  final String finishDate;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logoImage,
    required this.openDate,
    required this.finishDate,
  });

  // Método para converter JSON em uma instância de Group
  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      logoImage: map['logo_image'],
      openDate: map['open_date'],
      finishDate: map['finish_date'],
    );
  }
}
