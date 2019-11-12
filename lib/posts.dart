class Posts {
  final int id;
  final String title;
  final String excerpt;
  final String body;
  final String featuredImgUrl;

  Posts({this.id, this.title, this.excerpt, this.body, this.featuredImgUrl});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'] as int,
      title: json['title']['rendered'] as String,
      excerpt: json['excerpt']['rendered'] as String,
      body: json['content']['rendered'] as String,
      featuredImgUrl: json['better_featured_image']['media_details']['sizes']['thumbnail']['source_url'] as String,
    );
  }

}
