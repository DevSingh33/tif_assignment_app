import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment_app/core/singletons/singletons.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/event_details_cubit/event_detail_cubit.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/events_cubit/events_cubit.dart';
import 'package:tif_assignment_app/features/events/presentation/blocs/search_event_cubit/search_event_cubit.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/event_details_page.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/home_page.dart';
import 'package:tif_assignment_app/features/events/presentation/pages/search_event_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsCubit>(create: (context) => EventsCubit(getEventsUseCase: serviceLocator())),
        BlocProvider<EventDetailCubit>(create: (context) => EventDetailCubit(getEventDetailsUseCase: serviceLocator())),
        BlocProvider<SearchEventCubit>(create: (context) => SearchEventCubit(searchForEventsUseCase: serviceLocator())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true, //device preview config
        locale: DevicePreview.locale(context), //device preview config
        builder: DevicePreview.appBuilder, //device preview config
        title: 'TIF Assignment',

        theme: ThemeData(fontFamily: 'Inter', iconTheme: const IconThemeData(color: Colors.black)),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          EventDetailsPage.routeName: (context) => const EventDetailsPage(),
          SearchEventPage.routeName: (context) => const SearchEventPage(),
        },
      ),
    );
  }
}
