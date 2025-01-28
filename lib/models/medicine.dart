class Medicine {
  final String id;
  final String name;
  final String image;
  final String dosage;
  final String composition;
  final String function;
  final String usage;
  final String instructions;

  Medicine({
    required this.id,
    required this.name,
    required this.image,
    required this.dosage,
    required this.composition,
    required this.function,
    required this.usage,
    required this.instructions,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      dosage: json['dosage'],
      composition: json['composition'],
      function: json['function'],
      usage: json['usage'],
      instructions: json['instructions'],
    );
  }
}
