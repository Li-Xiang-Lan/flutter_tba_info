import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:flutter_tba_info/flutter_tba_info_platform_interface.dart';
import 'package:flutter_tba_info/flutter_tba_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTbaInfoPlatform
    with MockPlatformInterfaceMixin
    implements FlutterTbaInfoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterTbaInfoPlatform initialPlatform = FlutterTbaInfoPlatform.instance;

  test('$MethodChannelFlutterTbaInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTbaInfo>());
  });

  test('getPlatformVersion', () async {
    FlutterTbaInfo flutterTbaInfoPlugin = FlutterTbaInfo();
    MockFlutterTbaInfoPlatform fakePlatform = MockFlutterTbaInfoPlatform();
    FlutterTbaInfoPlatform.instance = fakePlatform;

    expect(await flutterTbaInfoPlugin.getPlatformVersion(), '42');
  });
}
