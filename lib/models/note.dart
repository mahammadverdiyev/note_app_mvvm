class Note {
  String _title;
  String _content;
  int? id;

  String get title => _title;

  String get content => _content;

  Note({required title, required content})
      : _title = title,
        _content = content;

  Map<String, dynamic> toMap() {
    final map = {"title": _title, "content": _content};

    if (id != null) {
      map['id'] = this.id.toString();
    }

    return map;
  }

  Note.fromMap(Map<String, dynamic> map)
      : _title = map['title'],
        _content = map['content'],
        id = map.containsKey("id") ? map['id'] : null;
}
