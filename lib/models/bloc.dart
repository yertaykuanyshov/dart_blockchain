class Bloc {
  Bloc({
    required this.text,
    this.hash = '',
    this.prevHash = '',
    required this.date,
  });

  final String text;
  final String prevHash;
  final String hash;
  final DateTime date;

  static Bloc fromJson(Map<String, dynamic> data) {
    return Bloc(
      text: data["text"],
      hash: data["hash"],
      prevHash: data["prevHash"],
      date: DateTime.now(),
    );
  }

  @override
  String toString() {
    return {
      "text": text,
      "hash": hash,
      "prevHash": prevHash,
      "date": date.toLocal().toIso8601String(),
    }.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "hash": hash,
      "prevHash": prevHash,
      "date": date.toIso8601String(),
    };
  }

  Bloc copyFrom({String? hash, String? prevHash}) {
    return Bloc(
      text: text,
      date: date,
      hash: hash ?? this.hash,
      prevHash: prevHash ?? this.prevHash,
    );
  }
}
