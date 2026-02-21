class BlogModel {
  final int id;
  final String title;
  final String content;
  final List<String> categories;
  final int views;
  final String date;
  final String author;
  final String avatarUrl;
  final String imageUrl;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.categories,
    required this.views,
    required this.date,
    required this.author,
    required this.avatarUrl,
    required this.imageUrl,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      views: json['views'] ?? 0,
      date: json['date'] ?? '',
      author: json['author'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
