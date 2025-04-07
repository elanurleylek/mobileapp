import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart'; // Başlangıç sayfası olarak Login Page
import 'package:flutter_application_1/constants/app_constants.dart';

void main() {
  runApp(const MyApp()); // MyApp'in kendisi const olabilir, sorun yok.
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName, // Sabit kullanıldı
      debugShowCheckedModeBanner: false,
      // ThemeData'nın başındaki 'const' kaldırıldı!
      theme: ThemeData(
        primarySwatch: Colors.blue, // Colors.blue const, sorun yok
        fontFamily: 'Roboto', // Fontun pubspec.yaml'da tanımlı olduğundan emin ol

        // InputDecorationTheme'in const constructor'ı VAR, bu nedenle const kalabilir.
        // Ancak emin değilseniz veya içindeki bir şey const olamıyorsa, bunu da kaldırabilirsiniz.
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder( // OutlineInputBorder'ın da const constructor'ı var.
            // borderRadius vb. const değerler alıyorsa const kalabilir.
            borderRadius: BorderRadius.all(Radius.circular(8.0)), // BorderRadius.all const
          ),
          // Diğer genel input stilleri...
        ),

        // ElevatedButtonThemeData'nın const constructor'ı YOKTUR.
        // Bu nedenle başındaki 'const' kaldırılmalıdır.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // ElevatedButton.styleFrom() const DEĞİLDİR.
            backgroundColor: Colors.blue, // Renkler const olabilir
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), // EdgeInsets const olabilir
            shape: RoundedRectangleBorder( // Bu da const olabilir
              borderRadius: BorderRadius.circular(12), // BorderRadius.circular const DEĞİL, ama styleFrom içinde sorun olmaz.
            ),
            textStyle: const TextStyle( // TextStyle const olabilir
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Diğer tema ayarları (TextButtonTheme, AppBarTheme vb. için de
        // const constructor'ları olup olmadığını kontrol edin veya const'ı kaldırın)
        textButtonTheme: TextButtonThemeData( // const yok
           style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Tema rengini kullan
           )
        ),
        appBarTheme: const AppBarTheme( // AppBarTheme'in const constructor'ı var
            elevation: 1, // Varsayılan elevation
            backgroundColor: Colors.white, // Varsayılan AppBar rengi
            foregroundColor: Colors.black, // İkon ve yazı rengi
            titleTextStyle: TextStyle( // const olabilir
               color: Colors.black,
               fontSize: 18,
               fontWeight: FontWeight.bold,
            )
        )

      ),
      home: const LoginPage(), // LoginPage'in const constructor'ı varsa const kalabilir.
                              // Eğer yoksa (ki stateful olduğu için muhtemelen yok), const'ı kaldırın.
                              // Hata vermiyorsa const kalması performans için iyidir.
                              // Eğer stateful ise 'const' kaldırılmalı: home: LoginPage(),
                              // Ancak kodda `const LoginPage()` olarak bıraktım,
                              // stateful widget'lar için constructor'lar da const olabilir
                              // eğer tüm parametreleri final ise. Hata verirse kaldırın.
    );
  }
}