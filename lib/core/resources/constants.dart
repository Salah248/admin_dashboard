
 List<DropMenu> kDrop = [
 DropMenu('sports', 'Sports'),
 DropMenu('electronics', 'Electronics'),
 DropMenu('collections', 'Collections'),
 DropMenu('books', 'Books'),
 DropMenu('games', 'Games'),
 DropMenu('bikes', 'Bikes'),
];


class DropMenu {
  final String category;
  final String label;

  DropMenu(this.category, this.label);
}
