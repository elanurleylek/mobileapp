import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate; // Navigasyon için callback

  const HomePage({
    Key? key,
    required this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bu sayfanın kendine özel AppBar'ı var
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingSmall), // Sabit
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // Tema rengi
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.smart_toy_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.paddingSmall), // Sabit
            const Text(
              AppConstants.appName, // Sabit
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // TODO: Menü (Drawer?) işlevselliği eklenecek
              Scaffold.of(context).openEndDrawer(); // Veya farklı bir menü
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Banner
            _buildHeroBanner(context),

            const SizedBox(height: AppConstants.paddingMedium), // Sabit

            // Robotik Platformu Badge
            _buildPlatformBadge(context),

            // Main Title
            const Padding(
              padding: EdgeInsets.all(AppConstants.paddingMedium), // Sabit
              child: Text(
                'Robotik Dünyasını Keşfet', // Belki bu da sabit olabilir
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium), // Sabit
              child: Text(
                'Eğitim içerikleri, projeler, yarışmalar ve daha fazlası ile robotik alanında kendini geliştir.', // Sabit olabilir
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: AppConstants.paddingLarge), // Sabit

            // CTA Button
            _buildCallToActionButton(context),

            const SizedBox(height: AppConstants.paddingLarge), // Alt boşluk
          ],
        ),
      ),
      // İstersen buraya bir Drawer ekleyebilirsin (AppBar'daki menü butonu için)
      // endDrawer: Drawer(...),
    );
  }

  // Hero Banner'ı oluşturan özel fonksiyon (widget'a da dönüştürülebilir)
  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium), // Sabit
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(AppConstants.heroBannerImageUrl), // Sabit
          fit: BoxFit.cover,
        ),
        boxShadow: [ // Hafif bir gölge efekti
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ]
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
          // Text content
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge), // Sabit
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Başlangıç Robotik Projelerinizi Keşfedin', // Sabit olabilir
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: AppConstants.paddingSmall), // Sabit
                Text(
                  'Arduino, Raspberry Pi ve daha fazlası', // Sabit olabilir
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Platform badge'ini oluşturan özel fonksiyon
  Widget _buildPlatformBadge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium), // Sabit
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // Tema rengi
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall), // Sabit
          Text(
            'Türkiye\'nin En Kapsamlı Robotik Platformu', // Sabit olabilir
            style: TextStyle(
              color: Theme.of(context).primaryColor, // Tema rengi
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // CTA (Call to Action) butonunu oluşturan özel fonksiyon
  Widget _buildCallToActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium), // Sabit
      child: ElevatedButton(
        onPressed: () {
          // Dersler sayfasına git (index 1)
          onNavigate(1);
        },
        // Stil ElevatedButtonTheme'dan geliyor ama istersen override edebilirsin
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Ücretsiz Başla'), // Sabit olabilir
            SizedBox(width: AppConstants.paddingSmall), // Sabit
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}