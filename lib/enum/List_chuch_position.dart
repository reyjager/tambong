class Position {
  final String _name;
  const Position._(this._name);

  static const Position Member = Position._('Member');
  static const Position Visitor = Position._('Visitor');
  static const Position Pastor = Position._('Pastor');
  static const Position Worker = Position._('Worker');

  static List<Position> get values => [Member, Visitor, Pastor, Worker];

  @override
  String toString() => _name;
}

// Church Class
class Church {
  final String _name;
  const Church._(this._name);

  static const Church NLFBC = Church._('NLFBC');
  static const Church JUFBC = Church._('JUFBC');
  static const Church NLFBC_Thuwal = Church._('NLFBC Thuwal');

  static List<Church> get values => [NLFBC, JUFBC, NLFBC_Thuwal];

  @override
  String toString() => _name;
}
