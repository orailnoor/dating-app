import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<ServerResponse> getDemoBanners() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://webservice.salesparrow.in/app_api/get_demo_banners'));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return serverResponse(response.statusCode, response.body);
    } catch (e) {
      return ServerResponse(
          success: false,
          message: "Something went wrong, Unable to connect server",
          reason: e.toString());
    }
  }
}

ServerResponse serverResponse(int statusCode, String resp,
    {failMessage = 'Unknown error occured'}) {
  ServerResponse serverResponse =
      ServerResponse(success: false, message: "message", reason: "reason");
  try {
    if (statusCode == 200 || statusCode == 201) {
      var body = jsonDecode(resp);
      serverResponse.body = body;
      serverResponse.success = body['status'];
      serverResponse.reason = body['status'] ? 'Success' : 'Failed';
      serverResponse.message = ServerResponse.messageBuilder(
          body['message'], body['status'] ? "Data found" : "Data not founds");
      if (serverResponse.body?.containsKey("paginationData") ?? false) {
        serverResponse.pagination =
            PaginationData.fromJson(body['paginationData']);
      }
      return serverResponse;
    } else {
      try {
        serverResponse.body = jsonDecode(resp);
      } catch (e) {
        serverResponse.body = null;
      }
      serverResponse.success = false;
      serverResponse.reason = serverResponse.body != null
          ? serverResponse.body!['message']
          : statusCode;
      serverResponse.message = serverResponse.body != null
          ? serverResponse.body!['message']
          : failMessage;
      return serverResponse;
    }
  } catch (e) {
    serverResponse.body = null;
    serverResponse.success = false;
    serverResponse.reason = e.toString();
    serverResponse.message = 'Something went wrong, please try again';
    return serverResponse;
  }
}

class ServerResponse {
  bool success;
  String message;
  String reason;
  Map<String, dynamic>? body;
  PaginationData? pagination;

  ServerResponse({
    required this.success,
    required this.message,
    required this.reason,
    this.body,
    this.pagination,
  });

  static String messageBuilder(dynamic data, defaultMessage) {
    String message = defaultMessage;
    if (data.runtimeType != String) {
      return message;
    }
    return data;
  }
}

class PaginationData {
  PaginationData({
    required this.count,
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.prevPage,
    required this.nextPage,
  });

  int count;
  int totalCount;
  int totalPages;
  int currentPage;
  int? prevPage;
  int? nextPage;

  factory PaginationData.fromJson(Map<String, dynamic> json) => PaginationData(
        count: json["count"],
        totalCount: json["total_count"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        prevPage: json["prev_page"],
        nextPage: json["next_page"],
      );
}
