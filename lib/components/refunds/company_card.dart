import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/components/refunds/company_model.dart';
import 'package:tamini_app/provider/language_provider.dart';

class CompanyCard extends StatefulWidget {
  final Company company;
  final bool isSelected;
  final VoidCallback onTap;

  const CompanyCard({
    Key? key,
    required this.company,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context); // this is added since the language could changes on profile_page
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(widget.isSelected ? 0.3 : 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              )
            ],
            border: Border.all(
              color: widget.isSelected ? Theme.of(context).primaryColor : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: widget.company.logo.isNotEmpty
                        ? Image.network(
                            widget.company.logo,
                            fit: BoxFit.scaleDown,
                          )
                        : const CircularProgressIndicator()),
              ),
              const SizedBox(height: 10),
              Text(
                widget.company.description.i18n(),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
