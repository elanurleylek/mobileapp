// Bu dosya, kimlik doğrulama işlemlerini (login, register, logout vb.)
// yöneten servis sınıfını içerir.
// GERÇEK UYGULAMADA BURASI FIREBASE AUTH, KENDİ API'NIZ VB. İLE İLETİŞİM KURAR.

class AuthService {
  // Giriş Yapma Fonksiyonu (Simülasyon)
  Future<bool> login(String email, String password) async {
    print('AuthService: Login deneniyor - Email: $email');
    // Simülasyon: 2 saniye bekle
    await Future.delayed(const Duration(seconds: 2));

    // Simülasyon: Basit bir kontrol (gerçekte backend cevabı olacak)
    if (email.contains('@') && password.length >= 6) {
      print('AuthService: Login başarılı.');
      return true; // Başarılı giriş
    } else {
      print('AuthService: Login başarısız.');
      // Gerçek uygulamada burada spesifik hata fırlatılabilir
      // throw Exception('Kullanıcı adı veya şifre hatalı');
      return false; // Başarısız giriş
    }
  }

  // Kayıt Olma Fonksiyonu (Simülasyon)
  Future<bool> register(String email, String password) async {
    print('AuthService: Register deneniyor - Email: $email');
    // Simülasyon: 2 saniye bekle
    await Future.delayed(const Duration(seconds: 2));

    // Simülasyon: Basit bir kontrol (gerçekte backend cevabı olacak)
    if (email.contains('@') && password.length >= 6) {
       // Rastgele bir hata oluşturma ihtimali (test için)
      // final bool shouldFail = Random().nextBool();
      // if (shouldFail) {
      //   print('AuthService: Register rastgele başarısız oldu.');
      //   throw Exception('Sunucu tarafında rastgele bir hata oluştu.');
      // }
      print('AuthService: Register başarılı.');
      return true; // Başarılı kayıt
    } else {
      print('AuthService: Register başarısız (geçersiz input).');
      // Gerçek uygulamada burada spesifik hata fırlatılabilir
      // throw Exception('Geçersiz e-posta veya şifre formatı.');
      return false; // Başarısız kayıt
    }
  }

  // Çıkış Yapma Fonksiyonu (Simülasyon)
  Future<void> logout() async {
    print('AuthService: Logout yapılıyor...');
    await Future.delayed(const Duration(milliseconds: 500));
    print('AuthService: Logout başarılı.');
    // Gerçek uygulamada token silme, state temizleme vb. işlemler yapılır.
  }
}