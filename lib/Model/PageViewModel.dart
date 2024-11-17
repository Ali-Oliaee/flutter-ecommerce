class PageViewModel {
  final int _id;
  final String _title;
  final double _price;
  final String _category;
  final String _description;
  final String _image;

  PageViewModel(this._id, this._title, this._price, this._category,
      this._description, this._image);

  get id => _id;
  get title => _title;
  get price => _price;
  get category => _category;
  get description => _description;
  get image => _image;
}
