import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';

// Bu sayfa MainScaffold içindeki ortak AppBar'ı kullanır.
class DerslerPage extends StatelessWidget {
  const DerslerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppBar MainScaffold tarafından sağlanıyor.
    return const Center(
      child: Text('${AppConstants.derslerPageTitle} Sayfası İçeriği'),
    );
  }
}