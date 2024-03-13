import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tap1Page extends StatefulWidget {
  const Tap1Page({super.key});

  @override
  State<Tap1Page> createState() => _Tap1PageState();
}

//? Se le agrega el mixin AutomaticKeepAliveClientMixin para mantener el estado
//? de la app, es decir que si se hace scroll de la noticia se conserve en el lugar en el que estaba

class _Tap1PageState extends State<Tap1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headlines = Provider.of<NewsService>(context).headlines;
    // newsService.headlines
    // body: NewsList(newsService.headlines),
    return Scaffold(
      body: (headlines.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : NewsList(headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
