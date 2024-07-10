class FilterItem {
  final String status;

  FilterItem(this.status);
}

List<FilterItem> menuItems = [
  FilterItem('All'),
  FilterItem('Pending'),
  FilterItem('Completed'),
];
