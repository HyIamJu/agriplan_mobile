import 'package:flutter/material.dart';
import 'package:mobile_flutter/utils/themes/custom_color.dart';
import 'package:mobile_flutter/view/tanamanku/screen/add_progress_mati_screen.dart';
import 'package:mobile_flutter/view/tanamanku/screen/add_progress_panen_screen.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/description_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/informasi_tanaman_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/pemupukan_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/penyiraman_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/progres_penyiraman_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/sudah_menanam_card.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/warning_cuaca.dart';
import 'package:mobile_flutter/view/tanamanku/widgets/cards/overview_card/weekly_progres_card.dart';
import 'package:mobile_flutter/view_model/tanamanku_viewmodel/overview_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WarningCuaca(),
            const SizedBox(
              height: 10,
            ),
            provider.sudahMenanam
                ? const Column(
                    children: [
                      ProgresPenyiraman(),
                      SizedBox(
                        height: 10,
                      ),
                      PenyiramanCard(),
                      SizedBox(
                        height: 10,
                      ),
                      PemupukanCard(),
                      SizedBox(
                        height: 10,
                      ),
                      WeeklyProgressCard(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : const SudahMenanamCard(),
            const SizedBox(
              height: 10,
            ),
            const DescriptionCard(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Informasi Tanaman',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const InformasiTanamanCard(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed:
                        provider.counterPenyiraman == provider.batasPenyiraman
                            ? () {
                                pushNewScreen(
                                  context,
                                  screen: AddPanenScreen(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              }
                            : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: primary,
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: Text(
                      'Tanamanmu Berhasil Panen?',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: neutral[10],
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        provider.counterPenyiraman == provider.batasPenyiraman
                            ? () {
                                pushNewScreen(
                                  context,
                                  screen: AddProgresMatiScreen(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              }
                            : null,
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(error.withOpacity(0.1)),
                    ),
                    child: Text(
                      'Tanamanmu mati?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: provider.counterPenyiraman ==
                                  provider.batasPenyiraman
                              ? error
                              : neutral[40]),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
