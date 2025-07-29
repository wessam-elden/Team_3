Card(
  color: Colors.white,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  elevation: 2,
  child: Column(
    children: [
      ListTile(
        leading: const Icon(Icons.flag, color: AppColors.brown),
        title: const Text("Country"),
        subtitle: Text(country),
        trailing: Icon(
          showCountryOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: AppColors.brown,
        ),
        onTap: () {
          setState(() {
            showCountryOptions = !showCountryOptions;
          });
        },
      ),
      if (showCountryOptions)
        Column(
          children: [
            RadioListTile(
              title: const Text("Egypt"),
              value: "Egypt",
              groupValue: country,
              activeColor: AppColors.brown,
              onChanged: (value) {
                setState(() {
                  country = value.toString();
                  showCountryOptions = false;
                });
              },
            ),
            RadioListTile(
              title: const Text("France"),
              value: "France",
              groupValue: country,
              activeColor: AppColors.brown,
              onChanged: (value) {
                setState(() {
                  country = value.toString();
                  showCountryOptions = false;
                });
              },
            ),
          ],
        ),
    ],
  ),
)
