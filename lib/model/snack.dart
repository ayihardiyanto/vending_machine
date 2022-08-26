class Snack {
  final double price;
  final int stock;
  final String thumbnail;
  final String name;
  Snack({
    required this.price,
    required this.stock,
    required this.thumbnail,
    required this.name,
  });

  Snack copyWith({
    double? price,
    int? stock,
    String? thumbnail,
    String? name,
  }) {
    return Snack(
      price: price ?? this.price,
      stock: stock ?? this.stock,
      thumbnail: thumbnail ?? this.thumbnail,
      name: name ?? this.name,
    );
  }
}

class Oreo extends Snack {
  Oreo({required super.price, required super.stock, required super.thumbnail})
      : super(name: 'Oreo');
}

class Cookies extends Snack {
  Cookies({
    required super.price,
    required super.stock,
    required super.thumbnail,
  }) : super(name: 'Cookies');
}

class Chips extends Snack {
  Chips({required super.price, required super.stock, required super.thumbnail})
      : super(name: 'Chips');

}

class Tango extends Snack {
  Tango({required super.price, required super.stock, required super.thumbnail})
      : super(name: 'Tango');

}

class ChocolateBar extends Snack {
  ChocolateBar(
      {required super.price, required super.stock, required super.thumbnail})
      : super(name: 'Chocolate Bar');

}
