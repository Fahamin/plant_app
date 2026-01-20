import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_app/app/modules/plant/views/plant_view.dart';
import 'package:plant_app/app/modules/setting/views/setting_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'app/modules/home/views/home_view.dart';
import 'core/constance/colors.dart';
import 'core/helpers/helper_functions.dart';
import 'data/model/nav_model.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: Colors.white,

      /// ❤️ PERFECT CIRCLE FAB
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          controller.changePage(1); // middle page
        },
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// ⬇ NATIVE BOTTOM BAR
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// HOME
                NavItem(
                  icon: Icons.home,
                  label: 'Home',
                  isActive: controller.selectedIndex.value == 0,
                  onTap: () => controller.changePage(0),
                ),

                /// SPACE FOR FAB
                const SizedBox(width: 40),

                /// SETTING
                NavItem(
                  icon: Icons.settings,
                  label: 'Setting',
                  isActive: controller.selectedIndex.value == 2,
                  onTap: () => controller.changePage(2),
                ),
              ],
            ),
          ),
        ),
      ),

      /// 📄 PAGES
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomeView(), PlantView(), SettingView()],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController();

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
