import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile_flutter/utils/themes/custom_color.dart';
import 'package:mobile_flutter/view/tanamanku/screen/edit_nama_tanaman_screen.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/overview_section.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/progress_section.dart';
import 'package:mobile_flutter/view_model/tanamanku_viewmodel/overview_provider.dart';
import 'package:mobile_flutter/view_model/tanamanku_viewmodel/tanamanku_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

// enum TabPreview { overview, progress }

class DetailTanamanScreen extends StatefulWidget {
  const DetailTanamanScreen({super.key});

  @override
  State<DetailTanamanScreen> createState() => _DetailTanamanScreenState();
}

class _DetailTanamanScreenState extends State<DetailTanamanScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TanamankuProvider>(context, listen: false);
    final providerOverview =
        Provider.of<OverviewProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: FloatingActionButton.small(
            heroTag: "backDetailScreen",
            elevation: 0,
            backgroundColor: Colors.black12,
            highlightElevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const CircleBorder(),
            disabledElevation: 0,
            onPressed: () {
              provider.refresh();
              providerOverview.refresh();
              Navigator.pop(context);
            },
            child: Icon(
              FluentIcons.chevron_left_16_regular,
              size: 30,
              color: neutral[10],
            ),
          ),
        ),
        body: Consumer<TanamankuProvider>(
          builder: (context, provider, _) {
            return ListView(
              children: [
                Image.asset(
                  'assets/images/sample_tomat.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tomat',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                              onPressed: () {
                                pushNewScreen(
                                  context,
                                  screen: EditNamaTanamanScreen(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              icon: const Icon(FluentIcons.edit_16_regular))
                        ],
                      ),
                      Text(
                        'Solanum lycopersicum',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: neutral[40]),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.setSelectedIndex(context, 0);
                            },
                            child: Container(
                              height: 25,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.5,
                                vertical: 2.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: provider.selectedIndex == 0
                                    ? success[500]
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Overview',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: provider.selectedIndex == 0
                                            ? neutral[10]
                                            : primary[500],
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.setSelectedIndex(context, 1);
                            },
                            child: Container(
                              height: 25,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.5,
                                vertical: 2.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: provider.selectedIndex == 1
                                    ? primary[500]
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Progress',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: provider.selectedIndex == 1
                                            ? neutral[10]
                                            : success[500],
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      provider.selectedIndex == 0
                          ? const OverviewSection()
                          : const ProgressSection(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
