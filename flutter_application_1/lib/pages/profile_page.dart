import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/pages/login_page.dart'; // Çıkış yapınca yönlendirmek için
// import 'package:flutter_application_1/services/auth_service.dart'; // Gerçek çıkış için lazım olacak

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  // Gerçek uygulamada kullanıcı bilgileri dışarıdan (state management ile) alınmalı
  final String _userName = "Ayşe Yıldız"; // Placeholder
  final String _userEmail = "ayse.yildiz@example.com"; // Placeholder
  final String? _profileImageUrl = null; // Placeholder (null veya URL olabilir)
  // final String? _profileImageUrl = 'https://via.placeholder.com/150'; // Örnek URL

  // Çıkış yapma onayı dialogunu gösteren fonksiyon
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Dialog için ayrı context
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text('Hesabınızdan çıkış yapmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Sadece dialogu kapat
              },
            ),
            TextButton(
              child: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
              onPressed: () async { // async yaptık çünkü logout işlemi sürebilir
                Navigator.of(dialogContext).pop(); // Önce dialogu kapat

                // --- GERÇEK ÇIKIŞ İŞLEMİ BURADA YAPILACAK ---
                try {
                  // print("Çıkış yapılıyor...");
                  // Örnek: AuthService kullanarak çıkış yap
                  // final authService = AuthService(); // Servis örneği alınmalı (Provider/Riverpod ile daha iyi)
                  // await authService.logout();

                  // Çıkış başarılı olduktan sonra Login sayfasına yönlendir ve geri gelmeyi engelle
                  // 'context' burada build metodunun context'i olmalı.
                   if (context.mounted) { // Widget hala ağaçta mı kontrolü
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false, // Tüm önceki sayfaları kaldır
                      );
                   }
                } catch (e) {
                   print("Çıkış sırasında hata: $e");
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Çıkış sırasında bir hata oluştu: ${e.toString()}'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                   }
                }
                // --- GERÇEK ÇIKIŞ İŞLEMİ SONU ---
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // AppBar'ın MainScaffold tarafından sağlandığını varsayıyoruz.
    return SingleChildScrollView( // İçerik taşabilir, kaydırılabilir olmalı
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium), // Genel padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Ortala
          children: <Widget>[
            const SizedBox(height: AppConstants.paddingLarge), // Üst boşluk

            // Profil Resmi (Avatar)
            CircleAvatar(
              radius: 60.0, // Avatar boyutu
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1), // Hafif tema rengi arka plan
              backgroundImage: _profileImageUrl != null
                  ? NetworkImage(_profileImageUrl!) // URL varsa NetworkImage kullan
                  : null, // URL yoksa null
              child: _profileImageUrl == null
                  ? Icon( // URL yoksa ikon göster
                      Icons.person,
                      size: 70,
                      color: Theme.of(context).primaryColor,
                    )
                  : null, // URL varsa ikon gösterme
            ),
            const SizedBox(height: AppConstants.paddingMedium),

            // Kullanıcı Adı
            Text(
              _userName, // Gerçek veri ile değiştirilecek
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingSmall),

            // Kullanıcı E-postası
            Text(
              _userEmail, // Gerçek veri ile değiştirilecek
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge * 1.5), // Daha fazla boşluk

            // Ayırıcı Çizgi
            const Divider(),
            const SizedBox(height: AppConstants.paddingMedium),

            // Eylem Butonları (ListTile ile)
            _buildProfileActionTile(
              context: context,
              icon: Icons.edit_outlined,
              title: 'Profili Düzenle',
              onTap: () {
                // TODO: Profili Düzenle sayfasına yönlendirme veya işlem
                print('Profili Düzenle tıklandı');
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Profili Düzenle özelliği yakında!')),
                 );
              },
            ),
            _buildProfileActionTile(
              context: context,
              icon: Icons.settings_outlined,
              title: 'Ayarlar',
              onTap: () {
                // TODO: Ayarlar sayfasına yönlendirme veya işlem
                print('Ayarlar tıklandı');
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Ayarlar özelliği yakında!')),
                 );
              },
            ),
            _buildProfileActionTile(
              context: context,
              icon: Icons.help_outline,
              title: 'Yardım ve Destek',
              onTap: () {
                // TODO: Yardım sayfasına yönlendirme veya işlem
                print('Yardım tıklandı');
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Yardım özelliği yakında!')),
                 );
              },
            ),

            const Divider(), // Alt ayırıcı

            // Çıkış Yap Butonu
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                _showLogoutConfirmationDialog(context); // Onay al
              },
            ),

             const SizedBox(height: AppConstants.paddingLarge), // Alt boşluk
          ],
        ),
      ),
    );
  }

  // Tekrar kullanılabilir ListTile oluşturan yardımcı fonksiyon
  Widget _buildProfileActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}