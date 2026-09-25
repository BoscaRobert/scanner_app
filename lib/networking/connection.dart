import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart' show rootBundle;

class ServerConnection {
  static String serverHost = '';
  static bool connectionHealth = false;


  static Future<IOClient> newIoClient() async {
    
    //TODO(implement real security)
    final httpClient = HttpClient();
    httpClient.badCertificateCallback = (_,_,_) => true;
    final client = IOClient(httpClient);
    
    return client;
  }

  static void changeHost(String newHost){
    serverHost=newHost;
  }

  static Future<bool> test() async{
  debugPrint('initiated test');
  IOClient client = await newIoClient();

  try {var response = await client.get(
    Uri(
      scheme: 'https',
      host:serverHost,
      port: 443,
      path:'/health.txt'
    )
  ).timeout(const Duration(seconds:10));
  if(response.statusCode==200)
  {
    connectionHealth=true;
    debugPrint("Http Health Check OK: Message: ${response.body}");
    return true;
  }
  else
  {
    debugPrint("Http Health Check Fail: Status code: ${response.statusCode}");
    return false;
  }
  }
  catch(e){
    debugPrint("Http Health Check Fail");
    debugPrint("test error $e");
    return false;
  }
  finally
  {
    client.close();
  }
 }

  static Future<bool> sendIdToServer(String text) async {
    debugPrint('sent string to server');
    IOClient client = await newIoClient();

    try {
      var response = await client.post(
        Uri(
          scheme: 'https',
          host: serverHost,
          port: 443,
          path: '/id',
        ),
        headers: {'Content-Type': 'text/plain'},
        body: text,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        connectionHealth = true;
        debugPrint("Send ID OK: Message: ${response.body}");
        return true;
      } else {
        debugPrint("Send ID Fail: Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Send ID Fail");
      debugPrint("sendIdToServer error $e");
      return false;
    } finally {
      client.close();
    }
  }
}
