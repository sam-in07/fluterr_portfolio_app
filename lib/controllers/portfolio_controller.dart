import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Project {
  final String title;
  final String description;
  final String tech;
  final String githubUrl;

  Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.githubUrl,
  });
}

class PortfolioController extends GetxController {
  var isDarkTheme = false.obs;
  var selectedProjectIndex = (-1).obs;
  var isProfileHovered = false.obs;
  var isSkillActive = false.obs;

  // FIXED: Moved inside the class scope so controller can access them
  final String linkedinUrl = 'https://www.linkedin.com/in/samin-ahmed-chowdhury-052b07231/';
  final String githubProfileUrl = 'https://github.com/sam-in07';
  final String youtubeUrl = 'https://www.youtube.com/@sam__in07152';
  final String emailAddress = 'mailto:chainsamin@gmail.com';

  // Repositories mapped with accurate application context details
  final List<Project> projects = [
    Project(
      title: 'Bangla Bulletin',
      description: 'An interactive newspaper reader application.',
      tech: 'Flutter • State Management',
      githubUrl: 'https://github.com/sam-in07/bangla_bulletin',
    ),
    Project(
      title: 'LEARNSPACE',
      description: 'An intuitive digital learning platform.',
      tech: 'Flutter • Educational UI/UX',
      githubUrl: 'https://github.com/sam-in07/LEARNSPACE',
    ),
    Project(
      title: 'ReGenie',
      description: 'A smart, magical helper that helps regenerate the planet. 💚',
      tech: 'Flutter • Eco Innovation',
      githubUrl: 'https://github.com/sam-in07/ReGenie',
    ),
  ];

  void toggleTheme() => isDarkTheme.value = !isDarkTheme.value;
  void selectProject(int index) => selectedProjectIndex.value = index;
  void toggleProfileHover(bool value) => isProfileHovered.value = value;
  void toggleSkillActive() => isSkillActive.value = !isSkillActive.value;

  Future<void> launchProjectUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not open the project link.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
