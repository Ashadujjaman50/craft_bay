import 'package:craft_bay/app/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_category_list.dart';
import '../widgets/home_slider.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProductSearchBar(),
            const SizedBox(height: 16),
            HomeSlider(),
            const SizedBox(height: 16),
            SectionHeader(name: 'Categories', onTapSeeAll: () {}),
            HomeCategoryList(),
          ],
        ),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPaths.navLogoSvg),
      actions: [
        AppBarIconButton(onTap: () {}, icon: Icons.person),
        const SizedBox(width: 6),
        AppBarIconButton(onTap: () {}, icon: Icons.call),
        const SizedBox(width: 6),
        AppBarIconButton(
          onTap: () {},
          icon: Icons.notifications_active_outlined,
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}



