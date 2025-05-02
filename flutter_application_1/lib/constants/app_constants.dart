// lib/constants/app_constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  // --- Genel Sabitler (Mevcut olanlar doğru) ---
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const String loginPageTitle = "Giriş Yap";
  static const String registerPageTitle = "Kayıt Ol";
  static const String appName = 'Robotik Okulu';
  static const String derslerPageTitle = 'Dersler';
  static const String projelerPageTitle = 'Projeler';
  static const String yarismaPageTitle = 'Yarışmalar';
  static const String profilPageTitle = 'Profil';
  static const String homePageTitle =
      'Ana Sayfa'; // <-- Bu önemli, hatalarda vardı

  static const String emailLabel = "E-posta";
  static const String passwordLabel = "Şifre";
  static const String confirmPasswordLabel = "Şifreyi Onayla";
  static const String loginButtonText = "Giriş Yap";
  static const String registerButtonText = "Kayıt Ol";
  static const String emailEmptyError = "E-posta alanı boş olamaz";
  static const String emailInvalidError = "Geçerli bir e-posta adresi girin";
  static const String passwordEmptyError = "Şifre alanı boş olamaz";
  static const String passwordLengthError = "Şifre en az 6 karakter olmalıdır";
  static const String confirmPasswordEmptyError =
      "Şifre onaylama alanı boş olamaz";
  static const String passwordsDoNotMatchError = "Şifreler eşleşmiyor";
  static const String loginFailedError =
      "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.";
  static const String registerFailedError =
      "Kayıt başarısız. Lütfen daha sonra tekrar deneyin.";
  static const String registerSuccessMessage =
      "Kayıt başarılı! Giriş yapabilirsiniz.";
  static const String noAccountText = "Hesabınız yok mu?";
  static const String alreadyHaveAccountText = "Zaten hesabınız var mı?";

  // --- URL'ler / Asset Yolları (Genel) ---
  static const String heroBannerImageUrl = 'https://picsum.photos/800/400';

  // --- DerslerPage İçin Gerekli Resim Yolları ---
  // DİKKAT: 'arduino _circuit.jpeg' dosya adında boşluk var!
  // Mümkünse dosyayı 'arduino_circuit.jpeg' olarak yeniden adlandırıp
  // aşağıdaki sabiti de 'assets/images/arduino_circuit.jpeg' olarak değiştirin.
  static const String arduinoCircuitImageUrl =
      'assets/images/arduinocircuit.jpeg'; // <-- Dosya adını kontrol edin!

  // DİKKAT: Dosya adının büyük/küçük harf duyarlılığına dikkat edin!
  static const String codeImageUrl = 'assets/images/Code.jpeg';

  // --- YENİ EKLENEN KARTLAR İÇİN RESİM YOLLARI ---
  // Bu dosyaların assets/images altında olduğundan emin olun!
  static const String raspberryPiImageUrl =
      'assets/images/raspberrypi.jpeg'; // <-- EKLENDİ
  static const String sensorKitImageUrl =
      'assets/images/sensorkit.jpeg'; // <-- EKLENDİ
  static const String lineFollowerImageUrl =
      'assets/images/line_follower_robot.jpeg'; // Örnek
  static const String obstacleAvoidingImageUrl =
      'assets/images/obstacle_avoiding_robot.jpeg'; // Örnek
  static const String roboticArmImageUrl =
      'assets/images/roboticarm.jpeg'; // Örnek
  static const String iotWeatherStationImageUrl =
      'assets/images/iot_weather_station.jpeg';
  static const String homeHeroTitle =
      'Başlangıç Robotik Projelerinizi Keşfedin';
  static const String homeHeroSubtitle =
      'Arduino, Raspberry Pi ve daha fazlası';
  static const String homePlatformBadge =
      'Türkiye\'nin En Kapsamlı Robotik Platformu';
  static const String homeMainTitle = 'Robotik Dünyasını Keşfet';
  static const String homeDescription =
      'Eğitim içerikleri, projeler, yarışmalar ve daha fazlası ile robotik alanında kendini geliştir.';
  static const String homeStartButtonText = 'Ücretsiz Başla';

  // --- DERS LİNKLERİ ---
  static const String arduinoCourseLink =
      'https://devreokulu.com/ArduinoDers1.html';
  static const String codingCourseLink =
      'https://kodlamavakti.com/ucretsiz-kodlama-dersleri/';

  // --- YENİ EKLENEN KARTLAR İÇİN LİNKLER ---
  // Gerçek linklerle değiştirin!
  static const String raspberryPiCourseLink =
      'https://www.raspberrypi.org/documentation/'; // <-- EKLENDİ
  static const String sensorsCourseLink =
      'https://randomnerdtutorials.com/arduino-sensor-kits-guide/'; // <-- EKLENDİ (Hatanın sebebi buydu)
  static const String lineFollowerDetailsUrl =
      'https://github.com/example/line-follower'; // Örnek
  static const String obstacleAvoidingDetailsUrl =
      'https://github.com/example/obstacle-avoider'; // Örnek
  static const String roboticArmDetailsUrl =
      'https://github.com/example/robotic-arm'; // Örnek
  static const String iotWeatherStationDetailsUrl =
      'https://github.com/example/iot-weather';
}
