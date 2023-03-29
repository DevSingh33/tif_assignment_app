import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment_app/features/events/domain/entities/event_entity.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/search_event_cubit/search_event_cubit.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/event_details_page.dart';

class SearchEventPage extends StatefulWidget {
  const SearchEventPage({super.key});
  static const routeName = '/search_event';
  @override
  State<SearchEventPage> createState() => _SearchEventPageState();
}

class _SearchEventPageState extends State<SearchEventPage> {
  TextEditingController textEditingController = TextEditingController();

  ///[getFormattedDate] will return a [String] date according to the required format for the UI
  String getFormattedDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    String formattedString = DateTimeFormat.format(dateTime, format: 'd M - D -h:i A');
    return formattedString;
  }

  ///[initBloc] will initialize the [SearchEventCubit] with the provided [query (i.e event name or title)]
  void initBloc(String eventName) {
    final cubit = BlocProvider.of<SearchEventCubit>(context);
    cubit.searchForEvents(eventName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black, size: size.width * 0.06), onPressed: () => Navigator.pop(context)),
          centerTitle: false,
          title: Text("Search", style: TextStyle(color: Colors.black, fontSize: size.width * 0.06)),
          backgroundColor: Colors.white,
          toolbarHeight: size.height * 0.1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  Icon(Icons.search, size: size.width * 0.06, color: Colors.blueAccent),
                  Text(' | ', style: TextStyle(fontSize: size.width * 0.05, color: Colors.grey)),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(hintText: "Type Event Name"),
                      onSubmitted: (value) {
                        initBloc(value.trim());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              BlocBuilder<SearchEventCubit, SearchEventState>(
                builder: (context, state) {
                  if (state is SearchEventError) {
                    return Center(child: Text(state.errorMsg, style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold)));
                  } else if (state is SearchEventLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchEventLoaded) {
                    final List<EventEntity> events = state.events;
                    if (events.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No Event Found By The Provided Name!!",
                          style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return SizedBox(
                      height: size.height * 0.68,
                      child: ListView.builder(
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
                                elevation: 1,
                                shadowColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // height: size.height * 0.3,
                                        width: size.width * 0.22,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(event.bannerImage)),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(getFormattedDate(event.dateTime),
                                                style: TextStyle(color: Colors.blueAccent, fontSize: size.width * 0.03)),
                                          )),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(event.title, style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.w500)),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
