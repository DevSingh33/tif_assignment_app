import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
/*
A model class containing all the values which a event will have it also have toJson() and fromJson() utility methods
*/
class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.bannerImage,
    required super.dateTime,
    required super.organiserName,
    required super.organiserIcon,
    required super.venueName,
    required super.venueCity,
    required super.venueCountry,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: json['date_time'],
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'banner_image': bannerImage,
      'date_time': dateTime,
      'organiser_name':organiserName,
      'organiser_icon': organiserIcon,
      'venue_name': venueName,
      'venue_city': venueCity,
      'venue_country': venueCountry,
    };
  }
}
