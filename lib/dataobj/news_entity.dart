
class NewsEntity {
  String title;
  String url;
  String time;

  NewsEntity.mock() {
    title = '【武汉疫情】华中农业大学教授称新冠病毒属于SARS病毒';
    url = 'https://www.dwnews.com/%E4%B8%AD%E5%9B%BD/60167698/%E6%AD%A6%E6%B1%89%E7%96%AB%E6%83%85%E5%8D%8E%E4%B8%AD%E5%86%9C%E4%B8%9A%E5%A4%A7%E5%AD%A6%E6%95%99%E6%8E%88%E7%A7%B0%E6%96%B0%E5%86%A0%E7%97%85%E6%AF%92%E5%B1%9E%E4%BA%8ESARS%E7%97%85%E6%AF%92';
    time = '02-01';
  }

  NewsEntity.fromJson(Map<String, dynamic> json) {
    title = json['propagandaTitle'];
    url = json['propagandaUrl'];
    time = json['propagandaTime'];
  }

  static List<NewsEntity> fromJsonList(List jsonList) {
    List<NewsEntity> list = List();
    jsonList.forEach((element) { list.add(NewsEntity.fromJson(element)); });
    return list;
  }
}