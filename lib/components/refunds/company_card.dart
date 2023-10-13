import 'package:flutter/material.dart';
import 'package:tamini_app/components/refunds/company_model.dart';

class CompanyCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: company.logo.isNotEmpty
                      ? Image.network(
                          company.logo,
                          fit: BoxFit.scaleDown,
                        )
                      : const CircularProgressIndicator()),
            ),
            const SizedBox(height: 10),
            Text(
              company.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
