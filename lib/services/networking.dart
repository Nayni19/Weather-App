import 'dart:io';
import 'dart:convert';
import 'package:http/io_client.dart';

class NetworkingData {
  NetworkingData(this.url);
  final String url;

  Future getData() async {
    try {
      HttpClient httpClient = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);

      var res = await ioClient.get(Uri.parse(url));
      
      if (res.statusCode == 200) {
        String data = res.body;
        return jsonDecode(data);
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
