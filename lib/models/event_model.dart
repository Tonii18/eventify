class EventModel {
  int? id;
  String title;
  String startTime;
  String? endTime;
  String imageUrl;
  String category;
  String? location;
  double? latitude;
  double? longitude;

  EventModel({
    this.id,
    required this.title,
    required this.startTime,
    this.endTime,
    required this.imageUrl,
    required this.category,
    this.location,
    this.latitude,
    this.longitude,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      imageUrl: json['image_url'],
      category: json['category'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
