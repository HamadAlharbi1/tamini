import 'package:localization/localization.dart';

List<Company> companies = [
  Company(logo: 'https://m.eyeofriyadh.com/directory/images/2019/04/11980dbc89540.jpg', description: 'walaa'.i18n()),
  Company(
      logo:
          'https://yt3.googleusercontent.com/ytc/APkrFKZIndH4nzI8PFt8jaVIJItwT-ED5xuBaPypgQzuYQ=s900-c-k-c0x00ffffff-no-rj',
      description: "Al_Rajhi_Takaful".i18n()),
  Company(
      logo:
          'https://play-lh.googleusercontent.com/zxehskOLifqtjD2NBpSfbxroRl2ToSK4jIJ3YJnMf71_68DaKgr9tEUW9WWRR5xmpB9Q',
      description: "malath".i18n()),
  Company(logo: 'https://www.tawuniya.com.sa/static/media/TawuniyaLogo.64ca7c50.png', description: "tawuniya".i18n()),
  Company(logo: 'https://www.aicc.com.sa/ar/thumb/index?width=870&height=495', description: "al_arabia".i18n()),
];

class Company {
  final String logo;
  final String description;

  Company({required this.logo, required this.description});
}
