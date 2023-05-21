class Exersise {
  int? _id;
  late String _title;
  late String _lastWorkoutDate;
  late int _count;
  late String _muscle;
  late int _set1Avg;
  late int _set2Avg;
  late int _set3Avg;
  late int _set1High;
  late int _set2High;
  late int _set3High;

  Exersise(
      this._title,
      this._lastWorkoutDate,
      this._count,
      this._muscle,
      this._set1Avg,
      this._set2Avg,
      this._set3Avg,
      this._set1High,
      this._set2High,
      this._set3High);

  Exersise.withId(
      this._id,
      this._title,
      this._lastWorkoutDate,
      this._count,
      this._muscle,
      this._set1Avg,
      this._set2Avg,
      this._set3Avg,
      this._set1High,
      this._set2High,
      this._set3High);

  int? get id => _id;
  String get title => _title;
  String get lastWorkoutDate => _lastWorkoutDate;
  String get muscle => _muscle;
  int get count => _count;
  int get set1Avg => _set1Avg;
  int get set2Avg => _set2Avg;
  int get set3Avg => _set3Avg;
  int get set1High => _set1High;
  int get set2High => _set2High;
  int get set3High => _set3High;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set count(int newCount) {
    _count = newCount;
  }

  set set1Avg(int set1Avg) {
    _set1Avg = set1Avg;
  }

  set set2Avg(int set2Avg) {
    _set2Avg = set2Avg;
  }

  set set3Avg(int set3Avg) {
    _set3Avg = set3Avg;
  }

  set set1High(int set1High) {
    _set1High = set1High;
  }
  
  set set2High(int set2High) {
    _set2High = set2High;
  }
  
  set set3High(int set3High) {
    _set3High = set3High;
  }

  set lastWorkoutDate(String newDate) {
    _lastWorkoutDate = newDate;
  }

  // Convert a Exersise object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['lastWorkoutDate'] = _lastWorkoutDate;
    map['count'] = _count;
    map['muscle'] = muscle;
    map['set1Avg'] = _set1Avg;
    map['set2Avg'] = _set2Avg;
    map['set3Avg'] = _set3Avg;
    map['set1High'] = _set1High;
    map['set2High'] = _set2High;
    map['set3High'] = _set3High;
    return map;
  }

  // Extract a Note object from a Map object
  Exersise.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _lastWorkoutDate = map['lastWorkoutDate'];
    _count = map['count'];
    _muscle = map['muscle'];
    _set1Avg = map['set1Avg'];
    _set2Avg = map['set2Avg'];
    _set3Avg = map['set3Avg'];
    _set1High = map['set1High'];
    _set2High = map['set2High'];
    _set3High = map['set3High'];
  }
}
