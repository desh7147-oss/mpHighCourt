class GalleryItems {
  int? status;
  List<User>? user;

  GalleryItems({this.status, this.user});

  GalleryItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? iD;
  String? postContent;
  String? postTitle;
  String? postName;
  String? imageUrl;

  User(
      {this.iD,
      this.postContent,
      this.postTitle,
      this.postName,
      this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    postContent = json['post_content'];
    postTitle = json['post_title'];
    postName = json['post_name'];
    imageUrl = json['gallery_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['post_content'] = this.postContent;
    data['post_title'] = this.postTitle;
    data['post_name'] = this.postName;
    return data;
  }
}
