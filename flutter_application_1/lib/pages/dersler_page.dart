import 'package:flutter/material.dart';
// AppConstants dosyasını import ettiğinizden emin olun (yolun doğru olduğunu varsayıyoruz)
import 'package:flutter_application_1/constants/app_constants.dart';

class DerslerPage extends StatelessWidget {
  const DerslerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // --- ÖNEMLİ KONTROLLER (Kodun çalışması için bunlar gereklidir) ---
    // 1. AppConstants.dart dosyasında sabitler tanımlı mı? Örnek:
    //    static const String arduinoCircuitImageUrl = 'assets/images/arduino_circuit.jpeg';
    //    static const String codeImageUrl = 'assets/images/Code.jpeg';
    //
    // 2. pubspec.yaml dosyasında assets klasörü ve resimler tanımlı mı? Örnek:
    //    flutter:
    //      uses-material-design: true
    //      assets:
    //        - assets/images/ # Bu satır klasördeki tüm dosyaları dahil eder VEYA
    //        # - assets/images/arduino_circuit.jpeg # Tek tek de ekleyebilirsiniz
    //        # - assets/images/Code.jpeg
    //
    // 3. Projenizde gerçekten 'assets/images/' klasörü ve içinde
    //    'arduino_circuit.jpeg' ve 'Code.jpeg' dosyaları var mı?
    // ---------------------------------------------------------------------

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCourseCard(
            context: context,
            level: 'Başlangıç',
            duration: '8 Hafta',
            title: 'Arduino ile Robotik Temelleri',
            description:
                'Arduino platformu üzerinde robotik programlamanın temellerini öğrenin.',
            // Sabiti kullanıyoruz
            imagePath: AppConstants.arduinoCircuitImageUrl,
          ),
          const SizedBox(height: 16.0),
          _buildCourseCard(
            context: context,
            level: 'Orta',
            duration: '', // Tasarımınızda varsa süre ekleyin
            title: '', // Tasarımınızda varsa başlık ekleyin
            description: '', // Tasarımınızda varsa açıklama ekleyin
            // Sabiti kullanıyoruz
            imagePath: AppConstants.codeImageUrl,
          ),
          // Başka kartlar eklemek isterseniz, benzer şekilde AppConstants kullanın
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required BuildContext context,
    required String level,
    required String duration,
    required String title,
    required String description,
    required String
    imagePath, // Buraya artık AppConstants'dan gelen değer gelecek
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
                  imagePath, // Sabitten gelen yolu kullanıyor
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  // Hata durumunda ne olacağını belirleyelim (Önerilir)
                  errorBuilder: (context, error, stackTrace) {
                    print("Resim yüklenemedi: $imagePath Hata: $error");
                    // Hata durumunda boş bir alan veya ikon gösterebilirsiniz
                    return Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Süre (eğer duration boş değilse göster)
                    if (duration.isNotEmpty)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
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
                          const SizedBox(width: 8),
                          Text(
                            duration,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      const SizedBox(), // duration boşsa boşluk bırak ki hizalama bozulmasın
                    // Öne Çıkan etiketi
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
                // Başlık (eğer title boş değilse göster)
                if (title.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                // Açıklama (eğer description boş değilse göster)
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 16),
                // Eğitime Katıl butonu
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Buraya tıklama eylemi eklenebilir (Navigasyon vb.)
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // İç boşluğu sıfırla
                        tapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap, // Dokunma alanını küçült
                      ),
                      child: const Row(
                        // Buton içeriğini const yapabiliriz
                        mainAxisSize:
                            MainAxisSize.min, // İçerik kadar yer kapla
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
