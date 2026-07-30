import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dev Portfolio'),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isDarkTheme.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: controller.toggleTheme,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- COMP 1: Profile Avatar Card  ---
            Center(
              child: GestureDetector(
                onTapDown: (_) => controller.toggleProfileHover(true),
                onTapUp: (_) => controller.toggleProfileHover(false),
                onTapCancel: () => controller.toggleProfileHover(false),
                child: Obx(() {
                  final isHovered = controller.isProfileHovered.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isHovered ? 140 : 110,
                    height: isHovered ? 140 : 110,
                    decoration: BoxDecoration(
                      color: isHovered ? Colors.amber : Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isHovered ? Colors.amber : Colors.blue,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: isHovered ? 12 : 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('Assets/pro_pic/cr7_suii.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Samin Ahmed Chowdhury',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'Flutter Developer',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(height: 40),

            // --- COMP 2: Tech Skills Section  ---
            const Text(
              'Technical Expertise',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: controller.toggleSkillActive,
              borderRadius: BorderRadius.circular(12),
              child: Obx(() {
                final isActive = controller.isSkillActive.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: isActive ? 150 : 60, // Size transition
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.teal.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.1), // Color transition
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isActive ? Colors.teal : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isActive
                                  ? 'Core Tech Stack'
                                  : 'Tap to expand stack...',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              isActive ? Icons.expand_less : Icons.expand_more,
                            ),
                          ],
                        ),
                        if (isActive) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                [
                                      'Flutter',
                                      'Dart',
                                      'GetX',
                                      'Firebase',
                                      'REST APIs',
                                      'Git',
                                    ]
                                    .map(
                                      (skill) => Chip(
                                        label: Text(skill),
                                        backgroundColor: Colors.teal.shade700,
                                        labelStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Divider(height: 40),

            // --- COMPONENT 3: Interactive Project List (Size & Color Animation) ---
            const Text(
              'Featured Projects',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.projects.length,
              itemBuilder: (context, index) {
                final project = controller.projects[index];
                return GestureDetector(
                  onTap: () => controller.selectProject(index),
                  child: Obx(() {
                    final isSelected =
                        controller.selectedProjectIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      height: isSelected ? 165 : 75,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.purple.withOpacity(0.15)
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.purple
                              : Colors.grey.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  project.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.purple,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project.tech,
                              style: TextStyle(
                                color: Colors.purple.shade300,
                                fontSize: 12,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      project.description,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () => controller
                                        .launchProjectUrl(project.githubUrl),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.open_in_new,
                                      size: 16,
                                    ),
                                    label: const Text(
                                      'GitHub',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),

            const Divider(height: 40),

            // --- SOCIALS & CONTACT FOOTER AREA ---
            const Text(
              'Get In Touch',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            InkWell(
              onTap: () => controller.launchProjectUrl(controller.emailAddress),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blueGrey, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      'chainsamin@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () =>
                      controller.launchProjectUrl(controller.githubProfileUrl),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.yellowAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.code, size: 18, color: Colors.yellow),
                  label: const Text('GitHub'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      controller.launchProjectUrl(controller.linkedinUrl),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade700,
                    side: BorderSide(color: Colors.blue.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.business_center,
                    size: 18,
                    color: Colors.blue.shade700,
                  ),
                  label: const Text('LinkedIn'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      controller.launchProjectUrl(controller.youtubeUrl),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                    side: BorderSide(color: Colors.red.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.video_library,
                    size: 18,
                    color: Colors.red.shade700,
                  ),
                  label: const Text('YouTube'),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
