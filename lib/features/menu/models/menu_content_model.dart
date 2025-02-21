class MenuContentModel {
    Data? data;

    MenuContentModel({
        this.data,
    });

    factory MenuContentModel.fromJson(Map<String, dynamic> json) => MenuContentModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    String? message;
    bool? success;
    List<Content>? content;
    List<dynamic>? errors;

    Data({
        this.message,
        this.success,
        this.content,
        this.errors,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        success: json["success"],
        content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
    };
}

class Content {
    int? id;
    int? userid;
    String? contentTitle;
    String? contentDescription;
    DateTime? createdAt;
    String? image;
    String? contentPageUrl;

    Content({
        this.id,
        this.userid,
        this.contentTitle,
        this.contentDescription,
        this.createdAt,
        this.image,
        this.contentPageUrl,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        userid: json["userid"],
        contentTitle: json["content_title"],
        contentDescription: json["content_description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        image: json["image"],
        contentPageUrl: json["content_page_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "content_title": contentTitle,
        "content_description": contentDescription,
        "created_at": createdAt?.toIso8601String(),
        "image": image,
        "content_page_url": contentPageUrl,
    };
}
