import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/event_details_cubit/event_detail_cubit.dart';

class EventDetailsPage extends StatefulWidget {
  final int? eventId;
  const EventDetailsPage({super.key, this.eventId});
  static const routeName = '/event_details';
  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  ///[initBloc] will initialize the [EventDetailCubit] with the provided [eventID]
  void initBloc(int eventID) {
    final cubit = BlocProvider.of<EventDetailCubit>(context);
    cubit.getEventDetails(eventID);
  }

  ///[getFormattedDate] will return a [String] date according to the required format for the UI
  String getFormattedDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    String formattedString = DateTimeFormat.format(dateTime, format: 'd F, Y');
    return formattedString;
  }

  ///[getFormattedDate] will return a [String] time according to the required format for the UI
  String getFormattedTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    String formattedString = DateTimeFormat.format(dateTime, format: 'l, g:iA');
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;
    initBloc(routes["id"]);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: size.height * 0.06,
          leading: IconButton(icon: Icon(Icons.arrow_back, size: size.width * 0.06), onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: size.width * 0.02, bottom: size.width * 0.02),
            child: Text("Event Details", style: TextStyle(fontSize: size.width * 0.06)),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04, bottom: size.width * 0.02),
              child: Container(
                width: size.width * 0.12,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.bookmark, size: size.width * 0.06),
              ),
            )
          ],
        ),
        body: BlocBuilder<EventDetailCubit, EventDetailState>(
          builder: (context, state) {
            if (state is EventDetailError) {
              return Center(child: Text(state.errorMsg, style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold)));
            } else if (state is EventDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventDetailLoaded) {
              final EventEntity event = state.event;
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    children: [
                      SizedBox(height: size.height * 0.28, child: Image.network(event.bannerImage, fit: BoxFit.cover, width: double.infinity)),
                      SizedBox(
                        height: size.height * 0.62,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.organiserName, style: TextStyle(fontSize: size.width * 0.08)),
                              ListTile(
                                leading: Image.network(
                                  event.organiserIcon,
                                  fit: BoxFit.contain,
                                  height: size.width * 0.3,
                                  width: size.width * 0.2,
                                ),
                                title: Text(
                                  event.organiserName,
                                  style: TextStyle(fontSize: size.width * 0.04),
                                ),
                                subtitle: Text("Organizer", style: TextStyle(fontSize: size.width * 0.03)),
                              ),
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/D.png',
                                  fit: BoxFit.contain,
                                  height: size.width * 0.3,
                                  width: size.width * 0.2,
                                ),
                                title: Text(
                                  getFormattedDate(event.dateTime),
                                  style: TextStyle(fontSize: size.width * 0.04),
                                ),
                                subtitle: Text(getFormattedTime(event.dateTime), style: TextStyle(fontSize: size.width * 0.03)),
                              ),
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/L.png',
                                  fit: BoxFit.contain,
                                  height: size.width * 0.3,
                                  width: size.width * 0.2,
                                ),
                                title: Text(
                                  event.venueName,
                                  style: TextStyle(fontSize: size.width * 0.04),
                                ),
                                subtitle: Text(
                                  '${event.venueCity}, ${event.venueCountry}',
                                  style: TextStyle(color: Colors.grey, fontSize: size.width * 0.04),
                                ),
                              ),
                              Text("About Event", style: TextStyle(fontSize: size.width * 0.05)),
                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.1,
                                child: SingleChildScrollView(
                                  child: Text(
                                    event.description,
                                    style: TextStyle(fontSize: size.width * 0.04),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white70,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 40, right: 40),
                      height: size.height * 0.08,
                      width: size.width,
                      decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("BOOK NOW", style: TextStyle(color: Colors.white, fontSize: size.width * 0.05)),
                          CircleAvatar(radius: size.width * 0.04, child: Icon(Icons.arrow_forward, size: size.width * 0.06)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
