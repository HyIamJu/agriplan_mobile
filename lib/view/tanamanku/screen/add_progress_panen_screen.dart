import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_flutter/utils/themes/custom_color.dart';
import 'package:mobile_flutter/utils/widget/show_dialog/show_dialog_icon_widget.dart';
import 'package:mobile_flutter/view_model/tanamanku_viewmodel/add_panen_mati_progress.dart';
import 'package:mobile_flutter/view_model/tanamanku_viewmodel/tanamanku_provider.dart';
import 'package:provider/provider.dart';

class AddPanenScreen extends StatelessWidget {
  AddPanenScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddPanenMatiProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Panen Tanaman',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              provider.refresh();
            },
            icon: const Icon(
              FluentIcons.chevron_left_16_regular,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '24 May 2023',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: primary[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catatan Progres',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: neutral,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 4,
                          maxLength: 100,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            filled: true,
                            counterStyle: TextStyle(color: neutral),
                            fillColor: neutral[10],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Masukkan deskripsi progres tanaman kamu',
                            hintStyle:
                                ThemeData().textTheme.bodyMedium!.copyWith(
                                      color: neutral[50],
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          validator: (value) => provider.validateDesc(value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primary[200],
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final List<XFile>? imagesFromPhone =
                                await ImagePicker().pickMultiImage();

                            if (imagesFromPhone != null) {
                              provider.addListImage(imagesFromPhone);
                            }
                          },
                          child: Text(
                            'Tambahkan foto tanamanmu',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '|',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: neutral),
                            ),
                            TextButton(
                              onPressed: () async {
                                final pickedFileCamera = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                if (pickedFileCamera != null) {
                                  provider.addImage(pickedFileCamera);
                                }
                              },
                              child: const Icon(
                                FluentIcons.camera_20_filled,
                                color: neutral,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Consumer<AddPanenMatiProvider>(
                    builder: (context, provider, _) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: provider.image?.length ?? 0,
                        itemBuilder: (context, index) {
                          final image = provider.image![index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  width: 100,
                                  height: 100,
                                  File(image.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.removeImage(index);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Consumer<AddPanenMatiProvider>(
                    builder: (context, provider, _) {
                      return ElevatedButton(
                        onPressed: () async {
                          // Logika Database

                          // Dialog Sementara
                          if (_formKey.currentState!.validate()) {
                            await customShowDialogIcon(
                                context: context,
                                iconDialog: FluentIcons.premium_16_regular,
                                title: 'Selamat',
                                desc: 'Kamu berhasil memanen tanaman kamu');
                            if (context.mounted) {
                              provider.refresh();
                              Provider.of<TanamankuProvider>(context,
                                      listen: false)
                                  .setSelectedIndex(context, 1);
                              Navigator.pop(context);
                            }
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: primary,
                          minimumSize: const Size(double.infinity, 0),
                          elevation: 0,
                        ),
                        child: Text(
                          'Simpan progres',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: neutral[10],
                                  ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
