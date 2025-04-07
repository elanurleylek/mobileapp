import 'package:flutter/material.dart';

class ProjelerPage extends StatelessWidget {
  const ProjelerPage({super.key});

  final List<Map<String, String>> _projects = const [
    {'title': 'Mobil Uygulama', 'description': 'Flutter ile geliştirilmiş bir mobil uygulama'},
    {'title': 'Web Sitesi', 'description': 'HTML, CSS, JS kullanılarak yapılmış bir web projesi'},
    {'title': 'Yapay Zeka Projesi', 'description': 'Python ile makine öğrenimi uygulaması'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.code, color: Colors.deepPurple),
              title: Text(
                project['title'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(project['description'] ?? ''),
              onTap: () {
                // İstersen burada detay sayfasına yönlendirme yapabilirsin
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${project['title']} açılıyor...')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
