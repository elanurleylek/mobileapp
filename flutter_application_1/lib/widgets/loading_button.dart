import 'package:flutter/material.dart';

// Tekrar kullanılabilir, yükleme durumunu gösteren buton widget'ı
class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed; // null ise buton devre dışı olur
  final Widget child; // Butonun normal durumdaki içeriği (örn. Text)
  final ButtonStyle? style; // Opsiyonel olarak dışarıdan stil almak için

  const LoadingButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style, // Dışarıdan gelen stili veya tema stilini kullanır
      // isLoading true ise veya onPressed null ise buton devre dışı
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox( // Indicator boyutunu kontrol etmek için SizedBox
              height: 24, // Buton içindeki indicator yüksekliği
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5, // Çizgi kalınlığı
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Indicator rengi
              ),
            )
          : child, // Yüklenmiyorsa normal içeriği göster
    );
  }
}