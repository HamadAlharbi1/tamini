List<Company> companies = [
  Company(logo: 'assets/walaa.png', description: 'walaa'),
  Company(logo: 'assets/AlRajhiTakaful.png', description: "Al_Rajhi_Takaful"),
  Company(logo: 'assets/malath.png', description: "malath"),
  Company(logo: 'assets/tawuniya.png', description: "tawuniya"),
];

class Company {
  final String logo;
  final String description;

  Company({required this.logo, required this.description});
}
