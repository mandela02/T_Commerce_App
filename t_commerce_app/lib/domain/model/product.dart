class Product {
  final int id;
  final String name;

  final int originalPrice;
  final int discoutPrice;

  final int createDate;
  final int updateDate;
  final String barCode;

  final String description;
  final int catalogue;

  Product(
      this.id,
      this.name,
      this.originalPrice,
      this.discoutPrice,
      this.createDate,
      this.updateDate,
      this.barCode,
      this.description,
      this.catalogue);
}
