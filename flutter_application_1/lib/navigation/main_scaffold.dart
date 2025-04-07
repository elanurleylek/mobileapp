import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/dersler_page.dart';
import 'package:flutter_application_1/pages/projeler_page.dart';
import 'package:flutter_application_1/pages/yarisma_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/constants/app_constants.dart'; // Sayfa başlıkları için

// Bu widget, alt navigasyon barını ve ana sayfa içeriğini yönetir.
class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  late final List<String> _pageTitles; // AppBar başlıkları için

  @override
  void initState() {
    super.initState();
    _pageTitles = [
      AppConstants.homePageTitle, // Ana sayfa başlığı AppBar'da gösterilmeyecek (kendi AppBar'ı var)
      AppConstants.derslerPageTitle,
      AppConstants.projelerPageTitle,
      AppConstants.yarismaPageTitle,
      AppConstants.profilPageTitle,
    ];
    _pages = [
      // HomePage'e navigasyon fonksiyonunu iletiyoruz
      HomePage(onNavigate: _onItemTapped),
      const DerslerPage(),
      const ProjelerPage(),
      const YarismaPage(),
      const ProfilPage(),
    ];
  }

  void _onItemTapped(int index) {
    if (index < 0 || index >= _pages.length) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ana sayfa (index 0) kendi AppBar'ını kullanıyor, diğerleri ortak AppBar kullanabilir.
    final bool showMainAppBar = _selectedIndex != 0;

    return Scaffold(
      // AppBar'ı sadece gerekli sayfalarda göster
      appBar: showMainAppBar
          ? AppBar(
              title: Text(
                _pageTitles[_selectedIndex], // Seçili sayfanın başlığını göster
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              elevation: 1, // Hafif bir gölge
              // İstersen buraya ortak action butonları ekleyebilirsin
            )
          : null, // Ana sayfada AppBar'ı bu Scaffold'da gösterme
      body: IndexedStack( // Sayfalar arası geçişte state'i korumak için IndexedStack
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor, // Temadan renk al
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: AppConstants.derslerPageTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_outlined),
            activeIcon: Icon(Icons.build),
            label: AppConstants.projelerPageTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: AppConstants.yarismaPageTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppConstants.profilPageTitle,
          ),
        ],
      ),
    );
  }
}