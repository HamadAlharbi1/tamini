import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class ShowFile extends StatelessWidget {
  const ShowFile({
    Key? key,
    required this.file,
    required this.description,
  }) : super(key: key);

  final String file;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Expanded(
                child: Row(
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
                      description,
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
              ),
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
                    return AlertDialog(
                      content: InteractiveViewer(
                        child: Image.network(file),
                      ),
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
