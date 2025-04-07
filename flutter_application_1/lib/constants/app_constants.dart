// lib/constants/app_constants.dart

import 'package:flutter/material.dart'; // Belki ileride Color sabitleri için gerekebilir

class AppConstants {
  // ---- KULLANICIDAN GELEN MEVCUT SABİTLER ----

  // Genel Padding Değerleri
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Sayfa Başlıkları (Mevcut)
  static const String loginPageTitle = "Giriş Yap";
  static const String registerPageTitle = "Kayıt Ol";

  // Form Etiketleri
  static const String emailLabel = "E-posta";
  static const String passwordLabel = "Şifre";
  static const String confirmPasswordLabel = "Şifreyi Onayla";

  // Buton Metinleri
  static const String loginButtonText = "Giriş Yap";
  static const String registerButtonText = "Kayıt Ol";

  // Form Hata Mesajları
  static const String emailEmptyError = "E-posta alanı boş olamaz";
  static const String emailInvalidError = "Geçerli bir e-posta adresi girin";
  static const String passwordEmptyError = "Şifre alanı boş olamaz";
  static const String passwordLengthError = "Şifre en az 6 karakter olmalıdır";
  static const String confirmPasswordEmptyError =
      "Şifre onaylama alanı boş olamaz";
  static const String passwordsDoNotMatchError = "Şifreler eşleşmiyor";

  // Bilgi ve Hata Mesajları
  static const String loginFailedError =
      "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.";
  static const String registerFailedError =
      "Kayıt başarısız. Lütfen daha sonra tekrar deneyin."; // Yazım hatası düzeltildi: registrationFailedError -> registerFailedError
  static const String registerSuccessMessage =
      "Kayıt başarılı! Giriş yapabilirsiniz.";

  // Diğer Metinler (Mevcut)
  static const String noAccountText = "Hesabınız yok mu?";
  static const String alreadyHaveAccountText = "Zaten hesabınız var mı?";

  // ---- EKSİK OLAN VE EKLENEN SABİTLER ----

  // Genel
  static const String appName =
      'Robotik Okulu'; // <-- EKLENDİ (main.dart için gerekli)

  // Sayfa Başlıkları (Eklenenler)
  // homePageTitle'ı eklemeye gerek yok, çünkü HomePage kendi AppBar'ını kullanıyor ve orada direkt 'Robotik Okulu' yazıyor.
  // İsterseniz ekleyebilirsiniz: static const String homePageTitle = 'Ana Sayfa';
  static const String derslerPageTitle =
      'Dersler'; // <-- EKLENDİ (main_scaffold.dart için gerekli)
  static const String projelerPageTitle =
      'Projeler'; // <-- EKLENDİ (main_scaffold.dart için gerekli)
  static const String yarismaPageTitle =
      'Yarışmalar'; // <-- EKLENDİ (main_scaffold.dart için gerekli)
  static const String profilPageTitle =
      'Profil'; // <-- EKLENDİ (main_scaffold.dart için gerekli)

  // URL'ler
  static const String heroBannerImageUrl =
      'https://picsum.photos/800/400'; // <-- EKLENDİ (home_page.dart için gerekli)

  // Diğer Metinler (Eklenenler) - HomePage içeriği için örnekler
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

  static const String homePageTitle = 'Ana Sayfa';
}
