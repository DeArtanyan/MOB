enum ProfileActivityFilter {
  activeRentals('Активные аренды'),
  favorites('Избранное'),
  rentalHistory('История аренды'),
  requests('Заявки');

  const ProfileActivityFilter(this.label);
  final String label;
}
