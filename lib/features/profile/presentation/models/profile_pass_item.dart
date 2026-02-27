class ProfilePassItem {
  const ProfilePassItem({
    required this.title,
    required this.showButtonLabel,
    this.parkingPlace,
    this.validUntilText,
  });

  final String title;
  final String showButtonLabel;
  final String? parkingPlace;
  final String? validUntilText;

  bool get hasActivePass => (validUntilText?.trim().isNotEmpty ?? false);

  String get parkingPlaceOrFallback {
    final value = parkingPlace?.trim();
    if (value == null || value.isEmpty) return 'Нет';
    return value;
  }
}
