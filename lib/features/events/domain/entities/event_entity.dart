import 'package:equatable/equatable.dart';

/*
Entity model class will be used by the presentation layer and will only contain the values that are required in the UI
*/
class EventEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String bannerImage;
  final String dateTime;
  final String organiserName;
  final String organiserIcon;
  final String venueName;
  final String venueCity;
  final String venueCountry;

  const EventEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.bannerImage,
      required this.dateTime,
      required this.organiserName,
      required this.organiserIcon,
      required this.venueName,
      required this.venueCity,
      required this.venueCountry});

  @override
  List<Object?> get props => [id, title, description, bannerImage, dateTime, organiserName, organiserIcon, venueName, venueCity, venueCountry];
}
