class RequestParams {
  final String url;
  final ApiMethods apiMethods;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? header;

  const RequestParams(
      {required this.url, required this.apiMethods, this.body, this.header});
}

enum ApiMethods { get, post, delete, put, patch }

// Map<String, String> header = {
//   "Authorization": "Bearer ${LocalStorage.instance.token}",
//   "Content-Type": "application/json",
// };

Map<String, String> header = {
  "Authorization":
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTE5ODExODcxNDUxIiwiaWF0IjoxNjg2MzExMzA0LCJleHAiOjE3MTc4NDczMDR9.F-YhmCzGl2xxTsbGoCGuZ-qarWig1QBbEOF1REAvR2U",
  "Content-Type": "application/json",
};
