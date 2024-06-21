class Product {
  int Id = 0;
  String ProductName = '';
  double Price = 0;
  int CategoryId = 0;
  String CategoryName = '';
  String Foto = '';

  Product(this.Id, this.ProductName, this.Price, this.CategoryId,
      this.CategoryName, this.Foto);

  Product.empty() {
    this.Id = 0;
    this.ProductName = '';
    this.Price = 0;
    this.CategoryId = 0;
    this.CategoryName = '';
    this.Foto = '';
  }

  @override
  String toString() {
    return 'Id = $Id, ProductName = $ProductName, Price = $Price, CategoryId = $CategoryId, CategoryName = $CategoryName, Foto = $Foto';
  }
}
