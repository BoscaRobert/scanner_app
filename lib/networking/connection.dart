import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart' show rootBundle;

class ServerConnection {
  static String serverHost = '192.168.0.106';
  static bool connectionHealth = false;


  static Future<IOClient> newIoClient() async {
    
    final certBytes = (await rootBundle.load('assets/certs/apache.crt'))
        .buffer.asUint8List();
    
    final context = SecurityContext(withTrustedRoots: true)
      ..setTrustedCertificatesBytes(certBytes);
    
    final httpClient = HttpClient(context: context);
    final client = IOClient(httpClient);
    
    return client;
  }

  static Future<bool> test() async{

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
    debugPrint("Http Health Check OK");
    return true;
  }
  else
  {
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

  static Future<void> sendToServer() async{
    
  }
}