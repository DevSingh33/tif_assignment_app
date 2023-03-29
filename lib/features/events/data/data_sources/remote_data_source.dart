import 'package:tif_assignment_app/core/api_routes/routes.dart';
import 'package:tif_assignment_app/core/errors/exceptions.dart';
import 'package:tif_assignment_app/features/events/data/models/event_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  ///[fetchEvents] will access the api and will provide all the events
  Future<List<EventModel>> fetchEvents();
  ///[fetchEventDetailsById] for accessing the api to get details of a particular event
  Future<EventModel?> fetchEventDetailsById({required int id});
  ///[fetchEventsByQuery] to search for a specific event from the api using the passed [query]
  Future<List<EventModel>> fetchEventsByQuery({required String query});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dioClient;
  RemoteDataSourceImpl({required this.dioClient});
  @override
  Future<EventModel?> fetchEventDetailsById({required int id}) async {
    try {
      EventModel? event;
      Response response = await dioClient.get(ApiRoutes.fetchEventDetails(id));
      var jsonEvent = response.data["content"]["data"];
      event = EventModel.fromJson(jsonEvent);
      return event;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(dioError: e);
    } catch (e) {

      throw UnknownException();
    }
  }

  @override
  Future<List<EventModel>> fetchEvents() async {
    List<EventModel>? events = [];
    try {
      Response response = await dioClient.get(ApiRoutes.fetchEvents);
      List<dynamic>? jsonEvents = response.data["content"]["data"];
      events = jsonEvents?.map((e) => EventModel.fromJson(e)).toList();
      return events ?? [];
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(dioError: e);
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<EventModel>> fetchEventsByQuery({required String query}) async {
    List<EventModel>? events = [];
    try {
      Response response = await dioClient.get(ApiRoutes.fetchEventsByQuery(query));
      List<dynamic>? jsonEvents = response.data["content"]["data"];
      events = jsonEvents?.map((e) => EventModel.fromJson(e)).toList();
      return events ?? [];
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(dioError: e);
    } catch (e) {
      throw UnknownException();
    }
  }
}
