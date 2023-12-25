import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/language_provider.dart';

class ShowFile extends StatefulWidget {
  const ShowFile({
    Key? key,
    required this.file,
    required this.onPressedCallback,
    required this.fileName,
  }) : super(key: key);
  final String file;
  final String fileName;
  final Function? onPressedCallback;
  @override
  State<ShowFile> createState() => _ShowFileState();
}

class _ShowFileState extends State<ShowFile> {
  late ValueNotifier<String> imageUrlNotifier;

  @override
  void initState() {
    super.initState();
    imageUrlNotifier = ValueNotifier<String>(widget.file);
  }

  @override
  void didUpdateWidget(covariant ShowFile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file != widget.file) {
      Future.microtask(() {
        imageUrlNotifier.value = widget.file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!isEnglish) ...[
                  Text(
                    'file_uploaded'.i18n(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
                Text(
                  widget.fileName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isEnglish) ...[
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'file_uploaded'.i18n(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.fileName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              ValueListenableBuilder<String>(
                                valueListenable: imageUrlNotifier,
                                builder: (context, imageUrl, child) {
                                  return Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                        loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          actions: [
                            widget.onPressedCallback == null
                                ? Center(
                                    child: ElevatedButton(
                                      child: Text("close".i18n()),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        child: Text("change_file".i18n()),
                                        onPressed: () async {
                                          await widget.onPressedCallback!();
                                          Future.delayed(Duration.zero, () {
                                            setState(() {
                                              imageUrlNotifier.value = widget.file;
                                            });
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("close".i18n()),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  )
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: Text(
                'View_Document'.i18n(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
