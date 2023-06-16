import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['url'] ?? '';  // api.metaltrade.io/api/$version/
