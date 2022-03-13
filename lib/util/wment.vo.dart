class WeatherMentionVO {
  List<String> prop;

  WeatherMentionVO({
    required this.prop,
  });

  @override
  String toString() {
    String res = "";
    for (String i in prop) {
      res += i;
      res += ", ";
    }

    return "[${res.substring(0, res.length - 1)}]";
  }
}
