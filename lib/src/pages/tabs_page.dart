import 'package:flutter/material.dart';
import 'package:news_app/src/pages/pages.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (value) => navigationModel.currentPage = value,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      // Para que el usuario no pueda hacer scroll
      // physics: BouncingScrollPhysics //? Esto para referencia de cuanto si se puede hacer scroll
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tap1Page(),
        Tap2Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  static int _currentPage = 0;
  static final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int page) {
    _currentPage = page;
    _pageController.animateToPage(page,
        duration: const Duration(microseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
