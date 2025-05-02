import 'package:flutter/material.dart';
// url_launcher paketini import edin
import 'package:url_launcher/url_launcher.dart';
// AppConstants dosyasını import edin
import 'package:flutter_application_1/constants/app_constants.dart'; // Proje adınız farklıysa düzeltin

class DerslerPage extends StatelessWidget {
  const DerslerPage({Key? key}) : super(key: key);

  // URL açma işlemini yapacak yardımcı fonksiyon (Değişiklik Yok)
  Future<void> _launchCourseUrl(BuildContext context, String urlString) async {
    // String boş veya null mu kontrolü
    if (urlString.isEmpty) {
      print('Hata: URL dizesi boş.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link bilgisi bulunamadı.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    Uri? url;
    try {
      url = Uri.parse(urlString);
    } catch (e) {
      print('URL Parse Hatası: $e');
      print('Geçersiz URL Dizesi: $urlString');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Link formatı geçersiz: $urlString'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        print('Link açılamadı (canLaunchUrl false döndü): $urlString');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bu link açılamadı: $urlString'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e, stackTrace) {
      print('Link açılırken HATA OLUŞTU: $e');
      print('Stack Trace:\n$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Link açılırken bir hata oluştu. Konsolu kontrol edin.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        AppConstants.paddingMedium,
      ), // Sabit kullanımı
      child: Column(
        children: [
          // --- Mevcut Kart 1 ---
          _buildCourseCard(
            context: context,
            level: 'Başlangıç',
            duration: '8 Hafta',
            title: 'Arduino ile Robotik Temelleri',
            description:
                'Arduino platformu üzerinde robotik programlamanın temellerini öğrenin.',
            // Boşluksuz ismi kullandığımızı varsayalım
            imagePath: AppConstants.arduinoCircuitImageUrl,
            courseUrl: AppConstants.arduinoCourseLink,
          ),
          const SizedBox(height: AppConstants.paddingMedium),

          // --- Mevcut Kart 2 ---
          _buildCourseCard(
            context: context,
            level: 'Orta',
            duration: '6 Hafta',
            title: 'Flutter ile Mobil Arayüzler', // Konuyu değiştirdim
            description:
                'Flutter framework ile etkileşimli mobil arayüzler geliştirin.', // Konuyu değiştirdim
            imagePath: AppConstants.codeImageUrl,
            courseUrl: AppConstants.codingCourseLink,
          ),
          const SizedBox(height: AppConstants.paddingMedium),

          // --- YENİ KART 3 (Raspberry Pi) ---
          _buildCourseCard(
            context: context,
            level: 'İleri', // Seviyeyi değiştirebilirsiniz
            duration: '10 Hafta', // Süreyi değiştirebilirsiniz
            title: 'Raspberry Pi ile IoT Projeleri', // Başlığı değiştirin
            description:
                'Raspberry Pi kullanarak internete bağlı akıllı cihazlar geliştirin.', // Açıklamayı değiştirin
            imagePath: AppConstants.raspberryPiImageUrl, // Yeni sabit
            courseUrl: AppConstants.raspberryPiCourseLink, // Yeni sabit
          ),
          const SizedBox(
            height: AppConstants.paddingMedium,
          ), // Kartlar arası boşluk
          // --- YENİ KART 4 (Sensörler) ---
          _buildCourseCard(
            context: context,
            level: 'Başlangıç', // Seviyeyi değiştirebilirsiniz
            duration: '4 Hafta', // Süreyi değiştirebilirsiniz
            title: 'Robotlar için Sensör Kullanımı', // Başlığı değiştirin
            description:
                'Ultrasonik, kızılötesi gibi çeşitli sensörleri Arduino ile kullanmayı öğrenin.', // Açıklamayı değiştirin
            imagePath: AppConstants.sensorKitImageUrl, // Yeni sabit
            courseUrl: AppConstants.sensorsCourseLink, // Yeni sabit
          ),
          // Başka kartlar eklemek isterseniz buraya ekleyebilirsiniz...
          // const SizedBox(height: AppConstants.paddingMedium),
          // _buildCourseCard(...),
        ],
      ),
    );
  }

  // _buildCourseCard fonksiyonu aynı kalır (Değişiklik Yok)
  Widget _buildCourseCard({
    required BuildContext context,
    required String level,
    required String duration,
    required String title,
    required String description,
    required String imagePath,
    required String courseUrl,
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resim ve seviye etiketi
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Hata mesajını daha detaylı yazdırabiliriz
                    print(
                      "Resim yüklenemedi: '$imagePath'. Hata: $error \nStack: $stackTrace",
                    );
                    return Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              color: Colors.grey,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Resim Yok',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: AppConstants.paddingMedium,
                left: AppConstants.paddingMedium,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Kurs bilgileri
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (duration.isNotEmpty)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              AppConstants.paddingSmall,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppConstants.paddingSmall),
                          Text(
                            duration,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Öne Çıkan',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                if (title.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.paddingMedium),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (description.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                ],
                const SizedBox(height: AppConstants.paddingMedium),
                // Eğitime Katıl butonu
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _launchCourseUrl(context, courseUrl);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Eğitime Katıl',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
