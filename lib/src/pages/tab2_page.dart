import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tap2Page extends StatelessWidget {
  const Tap2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoriesList(),
            Expanded(
                child: !newsService.isLoading
                    ? NewsList(newsService.getArticlesSelectedCategory)
                    : const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 85,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final selectedCategory = Provider.of<NewsService>(context).selectedCategory;
    return GestureDetector(
      onTap: () {
        // print('${category.name}');
        final newService = Provider.of<NewsService>(context,
            listen: false); //? en un evento tap va en listen false
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(category.icon,
            color: (category.name != selectedCategory)
                ? Colors.black12
                : myTheme.colorScheme.secondary),
      ),
    );
  }
}
