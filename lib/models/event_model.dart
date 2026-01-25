class EventModel {
  int? id;
  String title;
  String? description;
  String startTime;
  String? endTime;
  String imageUrl;
  String category;
  String? location;
  double? latitude;
  double? longitude;
  DateTime get startDateTime => DateTime.parse(startTime);

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.startTime,
    this.endTime,
    required this.imageUrl,
    required this.category,
    this.location,
    this.latitude,
    this.longitude,
  });

  // We must ensure no field of this model return a null value

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'],
      imageUrl: json['image_url'] ?? '',
      category: json['category_name'] ?? 'Unknown',
      location: json['location'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  get maxAttendees => null;

  get price => null;
}
