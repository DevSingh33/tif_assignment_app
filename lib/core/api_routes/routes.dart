///All the api routes used in the app .

class ApiRoutes {
  static const baseUrl = 'https://sde-007.api.assignment.theinternetfolks.works';
  static const apiVersion = 'v1';
  static const fetchEvents = '$baseUrl/$apiVersion/event';
  static  fetchEventDetails(int id) => '$baseUrl/$apiVersion/event/$id';
  static  fetchEventsByQuery(String query) => '$baseUrl/$apiVersion/event?search=$query';
}
