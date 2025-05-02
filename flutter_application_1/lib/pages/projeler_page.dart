import 'package:flutter/material.dart';
// Gerekli paketleri ve sabitleri import edin
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/constants/app_constants.dart'; // Proje adınız farklıysa düzeltin

class ProjelerPage extends StatelessWidget {
  const ProjelerPage({super.key}); // use_super_parameters lint uyarısı için güncellendi

  // Proje verilerini daha detaylı tutalım (resim, seviye, link ekledik)
  final List<Map<String, dynamic>> _projects = const [
    {
      'title': 'Çizgi İzleyen Robot',
      'description': 'Belirlenen siyah çizgiyi otonom olarak takip eden Arduino tabanlı robot.',
      'imagePath': AppConstants.lineFollowerImageUrl, // Sabit kullanıldı
      'level': 'Başlangıç',
      'detailsUrl': AppConstants.lineFollowerDetailsUrl, // Sabit kullanıldı
    },
    {
      'title': 'Engelden Kaçan Robot',
      'description': 'Ultrasonik sensör kullanarak önüne çıkan engellerden kaçan mobil robot.',
      'imagePath': AppConstants.obstacleAvoidingImageUrl, // Sabit kullanıldı
      'level': 'Orta',
      'detailsUrl': AppConstants.obstacleAvoidingDetailsUrl, // Sabit kullanıldı
    },
    {
      'title': 'Robotik Kol',
      'description': 'Servo motorlar ile kontrol edilen, basit nesneleri kavrayabilen robotik kol projesi.',
      'imagePath': AppConstants.roboticArmImageUrl, // Sabit kullanıldı
      'level': 'İleri',
      'detailsUrl': AppConstants.roboticArmDetailsUrl, // Sabit kullanıldı
    },
     {
      'title': 'IoT Hava İstasyonu',
      'description': 'Sensörlerden aldığı sıcaklık ve nem verilerini internete gönderen Raspberry Pi projesi.',
      'imagePath': AppConstants.iotWeatherStationImageUrl, // Sabit kullanıldı
      'level': 'İleri',
      'detailsUrl': AppConstants.iotWeatherStationDetailsUrl, // Sabit kullanıldı
    },
  ];

  // URL açma fonksiyonu (DerslerPage'den alındı ve uyarlandı)
   Future<void> _launchUrl(BuildContext context, String urlString) async {
    if (urlString.isEmpty) {
       print('Hata: URL dizesi boş.');
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Proje detay linki bulunamadı.'),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link formatı geçersiz: $urlString'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    // await öncesi context kontrolü (lint uyarısı için)
    if (!context.mounted) return;

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // await sonrası context kontrolü
        if (!context.mounted) return;
        print('Link açılamadı: $urlString');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bu link açılamadı: $urlString'), backgroundColor: Colors.redAccent),
        );
      }
    } catch (e, stackTrace) {
      // await sonrası context kontrolü
      if (!context.mounted) return;
      print('Link açılırken HATA OLUŞTU: $e\nStack: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Link açılırken bir hata oluştu.'), backgroundColor: Colors.redAccent),
       );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Sayfanın bir Scaffold içinde gösterildiğini varsayıyoruz.
    // Eğer bu sayfa tek başına çalışacaksa, bir Scaffold widget'ı eklemelisiniz.
    // Örneğin: return Scaffold(appBar: AppBar(title: Text(AppConstants.projelerPageTitle)), body: _buildProjectList());
    return _buildProjectList(context);
  }

  // Proje listesini oluşturan metot
  Widget _buildProjectList(BuildContext context){
     return ListView.builder(
        // Kenar boşluklarını SingleChildScrollView yerine buraya alabiliriz
        padding: const EdgeInsets.all(AppConstants.paddingMedium / 2), // Daha az padding
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          // Her proje için özelleştirilmiş kart oluşturan metodu çağır
          return _buildProjectCard(context, project);
        },
      );
  }

  // Tek bir proje kartı oluşturan metot (DerslerPage'deki _buildCourseCard'dan uyarlandı)
  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    // Veri eksikse varsayılan değerler kullanalım
    final String title = project['title'] ?? 'Başlıksız Proje';
    final String description = project['description'] ?? 'Açıklama yok.';
    final String imagePath = project['imagePath'] ?? ''; // Boş string hata vermez ama resim göstermez
    final String level = project['level'] ?? 'Bilinmiyor';
    final String detailsUrl = project['detailsUrl'] ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium / 2, // Daha az yatay boşluk
          vertical: AppConstants.paddingSmall,      // Daha az dikey boşluk
      ),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias, // Resmin Card sınırlarını aşmasını engeller
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resim ve seviye etiketi
          Stack(
            children: [
              // Resim (Eğer imagePath boşsa gri bir alan göster)
              imagePath.isNotEmpty
                  ? Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 160, // Yüksekliği biraz azalttık
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print("Proje resmi yüklenemedi: '$imagePath'. Hata: $error");
                        return Container(
                          width: double.infinity,
                          height: 160,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Icon(
                              Icons.construction_rounded, // Daha uygun bir ikon
                              color: Colors.grey.shade600,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    )
                  : Container( // Resim yoksa gösterilecek alan
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Icon(
                          Icons.construction_rounded,
                          color: Colors.grey.shade600,
                          size: 40,
                        ),
                      ),
                    ),
              // Seviye Etiketi
              Positioned(
                top: AppConstants.paddingSmall, // Daha küçük boşluk
                left: AppConstants.paddingSmall,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // Seviyeye göre renk de verebiliriz (opsiyonel)
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Proje bilgileri
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18, // Biraz daha küçük başlık
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall),
                // Açıklama
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  maxLines: 3, // Çok uzun açıklamaları sınırla
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                // Projeyi İncele butonu (Eğer detailsUrl varsa)
                if (detailsUrl.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Butonu sağa yasla
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: const Text('Projeyi İncele'),
                        onPressed: () {
                          _launchUrl(context, detailsUrl);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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