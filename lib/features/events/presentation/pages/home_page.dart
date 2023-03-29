import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/events_cubit/events_cubit.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/event_details_page.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/search_event_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    ///initializing the cubit when this screen get created on the navigation stack
    final cubit = BlocProvider.of<EventsCubit>(context);
    cubit.getEvents();
    super.initState();
  }

  ///[getFormattedDate] will return a [String] date according to the required format for the UI
  String getFormattedDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    String formattedString = DateTimeFormat.format(dateTime, format: 'D, M d •  h:i a');
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: false,
          title: Text("Events", style: TextStyle(color: Colors.black, fontSize: size.width * 0.06)),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded, color: Colors.black, size: size.width * 0.06),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchEventPage.routeName);
              },
            ),
            SizedBox(width: size.width * 0.04),
            Icon(Icons.more_vert_rounded, color: Colors.black, size: size.width * 0.06),
          ],
          toolbarHeight: size.height * 0.1,
        ),
        body: BlocBuilder<EventsCubit, EventsState>(
          builder: (context, state) {
            if (state is EventsError) {
              return Center(child: Text(state.errorMsg, style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold)));
            } else if (state is EventsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventsLoaded) {
              final List<EventEntity> events = state.events;
              return ListView.builder(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final EventEntity event = events[index];
                  return SizedBox(
                    height: size.height * 0.14,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(EventDetailsPage.routeName, arguments: {'id': event.id});
                      },
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.22,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(event.bannerImage)),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(' ${getFormattedDate(event.dateTime)}',
                                        style: TextStyle(color: Colors.blueAccent, fontSize: size.width * 0.03)),
                                  ),
                                  Expanded(child: Text(' ${event.title}', style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.w500))),
                                  SizedBox(
                                    width: size.width * 0.6,
                                    height: size.height * 0.05,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.grey),
                                        Expanded(
                                          child: Text(
                                            '${event.venueName} • ${event.venueCity}, ${event.venueCountry}',
                                            style: TextStyle(color: Colors.grey, fontSize: size.width * 0.03),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
