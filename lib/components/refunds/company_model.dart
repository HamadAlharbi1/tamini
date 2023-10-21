List<Company> companies = [
  Company(logo: 'https://m.eyeofriyadh.com/directory/images/2019/04/11980dbc89540.jpg', description: 'walaa'),
  Company(
      logo:
          'https://yt3.googleusercontent.com/ytc/APkrFKZIndH4nzI8PFt8jaVIJItwT-ED5xuBaPypgQzuYQ=s900-c-k-c0x00ffffff-no-rj',
      description: "Al_Rajhi_Takaful"),
  Company(
      logo:
          'https://play-lh.googleusercontent.com/zxehskOLifqtjD2NBpSfbxroRl2ToSK4jIJ3YJnMf71_68DaKgr9tEUW9WWRR5xmpB9Q',
      description: "malath"),
  Company(
      logo: 'https://argaamplus.s3.amazonaws.com/b86a59e1-7f14-480f-abd3-e2bf38cdbd28.png', description: "tawuniya"),
  Company(logo: 'https://www.aicc.com.sa/ar/thumb/index?width=870&height=495', description: "al_arabia"),
];

class Company {
  final String logo;
  final String description;

  Company({required this.logo, required this.description});
}
