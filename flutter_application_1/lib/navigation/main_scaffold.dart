import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Saat formatlama için eklendi

// Sayfa importları (Kendi proje yapınıza göre yolları kontrol edin)
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
  late final List<String> _pageTitles;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageTitles = [
      AppConstants.homePageTitle,
      AppConstants.derslerPageTitle,
      AppConstants.projelerPageTitle,
      AppConstants.yarismaPageTitle,
      AppConstants.profilPageTitle,
    ];
    // Sayfa listesi - Index'leri aklınızda tutun:
    // 0: HomePage, 1: DerslerPage, 2: ProjelerPage, 3: YarismaPage, 4: ProfilePage
    _pages = [
      HomePage(onNavigate: _onItemTapped), // 0
      const DerslerPage(), // 1
      const ProjelerPage(), // 2
      const YarismaPage(), // 3
      const ProfilePage(), // 4
    ];
  }

  void _onItemTapped(int index) {
    if (index < 0 || index >= _pages.length) return;
    // Eğer drawer açıksa, önce onu kapat
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      // Kısa bir gecikme vererek drawer kapanış animasyonunun bitmesini bekle
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) {
          setState(() {
            _selectedIndex = index;
          });
        }
      });
    } else {
      // Drawer kapalıysa doğrudan setState yap
      if (mounted) {
        setState(() {
          _selectedIndex = index;
        });
      }
    }
  }

  // Chatbot'tan gelen istekle sayfaya yönlendirme fonksiyonu
  void _navigateToPageFromChat(int index) {
    _onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    final bool showMainAppBar = _selectedIndex != 0;

    return Scaffold(
      key: _scaffoldKey,
      appBar:
          showMainAppBar
              ? AppBar(
                title: Text(
                  _pageTitles[_selectedIndex],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
              )
              : null,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        tooltip: 'Yardımcı Asistan',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        elevation: 2.0,
      ),
      endDrawer: ChatbotDrawer(
        onNavigate: _navigateToPageFromChat,
      ), // Callback'i geçir
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
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

//-----------------------------------------------------------------------------
// Chatbot Drawer Widget'ı (Stateful)
//-----------------------------------------------------------------------------
class ChatbotDrawer extends StatefulWidget {
  // Navigasyon callback fonksiyonu
  final Function(int index) onNavigate;

  const ChatbotDrawer({
    super.key,
    required this.onNavigate, // Constructor'a eklendi
  });

  @override
  State<ChatbotDrawer> createState() => _ChatbotDrawerState();
}

class _ChatbotDrawerState extends State<ChatbotDrawer> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isBotTyping = false;

  // Mesaj gönderme fonksiyonu
  void _handleSubmitted(String text) {
    final messageText = text.trim();
    _textController.clear();
    if (messageText.isEmpty || !mounted) return;

    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: messageText,
          type: ChatMessageType.user,
          timestamp: DateTime.now(),
        ),
      );
      _isBotTyping = true;
    });

    _scrollToBottom();

    // Duration önündeki const kaldırıldı
    Future.delayed(
      Duration(milliseconds: 1000 + (messageText.length * 50)),
      () {
        if (mounted) _handleBotResponse(messageText);
      },
    );
  }

  // Basit bot cevabı fonksiyonu - DÜZELTİLMİŞ
  void _handleBotResponse(String userMessage) {
    String response;
    String lowerCaseMessage = userMessage.toLowerCase();
    int? targetIndex; // Yönlendirilecek sayfa index'i (nullable olarak tanımlı)

    // Mesajı analiz et ve cevap/yönlendirme belirle
    if (lowerCaseMessage.contains("merhaba") ||
        lowerCaseMessage.contains("selam")) {
      response = "Merhaba! Size nasıl yardımcı olabilirim?";
    } else if (lowerCaseMessage.contains("dersler") ||
        lowerCaseMessage.contains("kurslar")) {
      response = "Dersler sayfasına yönlendiriyorum...";
      targetIndex = 1;
    } else if (lowerCaseMessage.contains("proje")) {
      response = "Projeler sayfasına yönlendiriyorum...";
      targetIndex = 2;
    } else if (lowerCaseMessage.contains("profil") ||
        lowerCaseMessage.contains("hesabım")) {
      response = "Profil sayfasına yönlendiriyorum...";
      targetIndex = 4;
    } else if (lowerCaseMessage.contains("ana sayfa") ||
        lowerCaseMessage.contains("anasayfa")) {
      response = "Ana sayfaya dönüyorum...";
      targetIndex = 0;
    }
    // --- Diğer komutlar veya cevaplar ---
    else if (lowerCaseMessage.contains("yarışma") ||
        lowerCaseMessage.contains("etkinlik")) {
      response =
          "Yaklaşan yarışmalar ve etkinlikler için Yarışma sayfamızı kontrol edebilirsiniz.";
    } else if (lowerCaseMessage.contains("kayıt") ||
        lowerCaseMessage.contains("giriş")) {
      response =
          "Giriş yapmak veya yeni hesap oluşturmak için Profil sayfasını ziyaret edebilirsiniz.";
    } else if (lowerCaseMessage.contains("teşekkür")) {
      response = "Rica ederim! Yardımcı olabileceğim başka bir konu var mı?";
    } else {
      response = "Anlayamadım. Farklı bir şekilde ifade edebilir misiniz?";
    }

    // Widget ağaçta değilse devam etme
    if (!mounted) return;

    // Botun cevabını (metin olarak) ekle
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: response,
          type: ChatMessageType.bot,
          timestamp: DateTime.now(),
        ),
      );
      _isBotTyping = false; // Yazmayı bitirdi
    });
    _scrollToBottom(); // Mesajı göster

    // Eğer yönlendirme yapılacaksa (targetIndex null değilse), callback'i çağır
    if (targetIndex != null) {
      // ---->>> DÜZELTME: Null olmayan yeni değişkene ata <<<----
      final int navigationIndex =
          targetIndex; // targetIndex null olamaz burada.
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) {
          // ---->>> DÜZELTME: Yeni değişkeni kullan <<<----
          widget.onNavigate(navigationIndex);
        }
      });
    }
  }

  // Listenin en altına kaydırma fonksiyonu
  void _scrollToBottom() {
    if (_scrollController.hasClients && _messages.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.of(context).size.width * 0.85;

    return Drawer(
      width: drawerWidth,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Yardımcı Asistan'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Kapat',
                onPressed: () {
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: _messages.length,
                    itemBuilder:
                        (_, int index) => _buildMessageItem(_messages[index]),
                  ),
                ),
                if (_isBotTyping)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        _buildAvatar(ChatMessageType.bot),
                        const SizedBox(width: 8),
                        const Text(
                          "Yazıyor...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onSubmitted: _handleSubmitted,
                      textInputAction: TextInputAction.send,
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () => _handleSubmitted(_textController.text),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    elevation: 1.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Avatar oluşturma yardımcı fonksiyonu
  Widget _buildAvatar(ChatMessageType type) {
    return CircleAvatar(
      radius: 15,
      backgroundColor:
          type == ChatMessageType.user
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey.shade400,
      child: Icon(
        type == ChatMessageType.user
            ? Icons.person_outline
            : Icons.support_agent,
        size: 18,
        color: Colors.white,
      ),
    );
  }

  // Tek bir mesaj baloncuğunu oluşturan widget
  Widget _buildMessageItem(ChatMessage message) {
    final alignment =
        message.type == ChatMessageType.user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start;
    final color =
        message.type == ChatMessageType.user
            ? Theme.of(context).primaryColor.withOpacity(0.9)
            : Colors.white;
    final textColor =
        message.type == ChatMessageType.user ? Colors.white : Colors.black87;
    final borderRadius =
        message.type == ChatMessageType.user
            ? const BorderRadius.only(
              topLeft: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
              topRight: Radius.circular(4),
            )
            : const BorderRadius.only(
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(18),
              topLeft: Radius.circular(18),
            );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            message.type == ChatMessageType.user
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.type == ChatMessageType.bot) ...[
            _buildAvatar(message.type),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment:
                message.type == ChatMessageType.user
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 1.0,
                color: color,
                borderRadius: borderRadius,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 5.0, right: 5.0),
                child: Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ),
            ],
          ),
          if (message.type == ChatMessageType.user) ...[
            const SizedBox(width: 8),
            _buildAvatar(message.type),
          ],
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Mesaj Veri Modeli
//-----------------------------------------------------------------------------
enum ChatMessageType { user, bot }

class ChatMessage {
  final String text;
  final ChatMessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.type,
    required this.timestamp,
  });
}
