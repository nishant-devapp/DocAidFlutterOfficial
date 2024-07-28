  final Map<String, String> dayAbbreviations = {
    "MONDAY": "M",
    "TUESDAY": "Tu",
    "WEDNESDAY": "W",
    "THURSDAY": "Th",
    "FRIDAY": "F",
    "SATURDAY": "Sa",
    "SUNDAY": "Su",
  };

  String getAbbreviatedDays(List<String> clinicDays) {
    return clinicDays.map((day) => dayAbbreviations[day]).join("  ");
  }

