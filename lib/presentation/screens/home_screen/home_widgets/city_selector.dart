import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/models.dart/createCity_model.dart';

class CitySelector extends StatelessWidget {
  final List<City> cities;
  final City selectedCity;
  final Function(City) onChanged;

  const CitySelector({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          AppText.selectACity,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.deepChestnut,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.flight_rounded, color: AppColors.chestnutBrown),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButton<City>(
            value: selectedCity,
            isExpanded: true,
            dropdownColor: AppColors.ivoryCream,
            iconEnabledColor: AppColors.chestnutBrown,
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            items: cities.map((city) {
              IconData icon;
              switch (city.name) {
                case 'Cairo':
                  icon = Icons.location_city;
                  break;
                case 'Luxor':
                  icon = Icons.temple_buddhist;
                  break;
                case 'Alexandria':
                  icon = Icons.beach_access;
                  break;
                case 'Giza':
                  icon = Icons.landscape;
                  break;
                default:
                  icon = Icons.temple_buddhist_outlined;
              }

              return DropdownMenuItem<City>(
                value: city,
                child: Row(
                  children: [
                    Icon(icon, color: AppColors.chestnutBrown, size: 20),
                    const SizedBox(width: 10),
                    Text(city.name, style: const TextStyle(color: AppColors.chestnutBrown)),
                  ],
                ),
              );
            }).toList(),
            underline: Container(height: 1, color: AppColors.chestnutBrown),
          ),
        ),
      ],
    );
  }
}
