import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';
import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/services/auth_service.dart'; // Gerçek çıkış için

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); // super.key kullanımı

  // Gerçek uygulamada kullanıcı bilgileri state management ile alınmalı
  final String _userName = "Ayşe Yıldız";
  final String _userEmail = "ayse.yildiz@example.com";
  // Örnek URL, kendi URL'nizle veya null ile değiştirin
  final String? _profileImageUrl =
      'https://i.pravatar.cc/150?img=32'; // Rastgele kadın avatarı
  // final String? _profileImageUrl = null; // Profil resmi yoksa
  final int _completedCourses = 7;
  final int _completedProjects = 4;

  void _showLogoutConfirmationDialog(BuildContext pageContext) {
    // build metodunun context'i
    showDialog(
      context: pageContext, // pageContext kullanılıyor
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
          ),
          title: const Text('Çıkış Yap'),
          content: const Text(
            'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Dialogu kapat

                // --- GERÇEK ÇIKIŞ İŞLEMİ ---
                // print("Çıkış yapılıyor...");
                // await Future.delayed(const Duration(seconds: 1)); // Örnek gecikme
                // final authService = AuthService();
                // await authService.logout();

                if (pageContext.mounted) {
                  // Ana context'in geçerliliğini kontrol et
                  Navigator.of(pageContext).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      // Profil sayfası kendi Scaffold'una sahip olabilir
      // AppBar'ı burada veya MainScaffold'da tanımlayabilirsiniz
      // appBar: AppBar(
      //   title: const Text(AppConstants.profilPageTitle),
      //   elevation: 0, // Daha modern bir görünüm için
      //   backgroundColor: theme.scaffoldBackgroundColor, // Arka planla aynı
      //   foregroundColor: theme.textTheme.bodyLarge?.color, // İkonlar için
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: AppConstants.paddingLarge * 1.5,
              ), // Üstten daha fazla boşluk
              // --- Profil Resmi ---
              CircleAvatar(
                radius: 70.0,
                backgroundColor: theme.colorScheme.primaryContainer.withOpacity(
                  0.5,
                ),
                backgroundImage:
                    _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : null,
                onBackgroundImageError:
                    _profileImageUrl != null
                        ? (exception, stackTrace) {
                          print(
                            "Profil resmi yüklenemedi: $_profileImageUrl, Hata: $exception",
                          );
                          // Hata durumunda bir şey göstermeyebilir veya varsayılan ikonu child'da bırakabiliriz
                        }
                        : null,
                child:
                    _profileImageUrl == null
                        ? Icon(
                          Icons.person_outline,
                          size: 80,
                          color: theme.colorScheme.primary,
                        )
                        : null,
              ),
              const SizedBox(height: AppConstants.paddingMedium),

              // --- Kullanıcı Adı ve Email ---
              Text(
                _userName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingSmall / 2),
              Text(
                _userEmail,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingLarge),

              // --- İstatistikler ---
              _buildStatsSection(theme),
              const SizedBox(height: AppConstants.paddingLarge),

              // --- Eylem Listesi ---
              Card(
                // Eylemleri bir kart içinde gruplandırma
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.paddingMedium,
                  ),
                ),
                child: Column(
                  children: [
                    _buildProfileActionTile(
                      context: context,
                      icon: Icons.edit_outlined,
                      title: 'Profili Düzenle',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profili Düzenle özelliği yakında!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildProfileActionTile(
                      context: context,
                      icon: Icons.settings_outlined,
                      title: 'Ayarlar',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ayarlar özelliği yakında!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildProfileActionTile(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: 'Bildirimler',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bildirimler özelliği yakında!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildProfileActionTile(
                      context: context,
                      icon: Icons.security_outlined,
                      title: 'Gizlilik ve Güvenlik',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Gizlilik ayarları yakında!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildProfileActionTile(
                      context: context,
                      icon: Icons.help_outline,
                      title: 'Yardım ve Destek',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Yardım merkezi yakında!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.paddingLarge),

              // --- Çıkış Yap Butonu ---
              ElevatedButton.icon(
                icon: const Icon(Icons.logout, size: 20),
                label: const Text('Çıkış Yap'),
                onPressed: () => _showLogoutConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.paddingMedium,
                    ),
                  ),
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onError,
                  ),
                ),
              ),
              const SizedBox(
                height: AppConstants.paddingLarge,
              ), // En altta boşluk
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildStatCard(
          theme,
          Icons.menu_book_outlined,
          _completedCourses,
          'Dersler',
        ),
        _buildStatCard(
          theme,
          Icons.emoji_objects_outlined,
          _completedProjects,
          'Projeler',
        ),
        // İsterseniz başka bir istatistik ekleyebilirsiniz
        // _buildStatCard(theme, Icons.star_border_outlined, 12, 'Puan'),
      ],
    );
  }

  Widget _buildStatCard(
    ThemeData theme,
    IconData icon,
    int count,
    String label,
  ) {
    return Expanded(
      // Kartların eşit yer kaplaması için
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSmall / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(height: AppConstants.paddingSmall / 2),
              Text(
                count.toString(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    VoidCallback? onTap, // Opsiyonel onTap
  }) {
    final ThemeData theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleMedium),
      trailing:
          onTap != null
              ? const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              )
              : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
    );
  }
}
