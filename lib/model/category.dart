class Category {
  int id = 0;
  String categoryName = '';
  bool isChecked = true;

  Category(this.id, this.categoryName, this.isChecked);

  Category.empty() {
    id = 0;
    categoryName = '';
    isChecked = true;
  }

  @override
  String toString() {
    return 'id = $id, categoryName = $categoryName, isChecked = $isChecked';
  }
}
