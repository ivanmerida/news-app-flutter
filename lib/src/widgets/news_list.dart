import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _New(new_: news[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article new_;
  final int index;
  const _New({required this.new_, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TargetTopBar(new_: new_, index: index),
        _TargetTitle(new_),
        _TargetImage(new_),
        _TargetBody(new_),
        const _TargetButtons(),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _TargetButtons extends StatelessWidget {
  const _TargetButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.colorScheme.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _TargetBody extends StatelessWidget {
  final Article new_;
  const _TargetBody(this.new_);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((new_.description != null) ? new_.description : ''),
    );
  }
}

class _TargetImage extends StatelessWidget {
  final Article new_;
  const _TargetImage(this.new_);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (new_.urlToImage != null)
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(new_.urlToImage),
                  )
                : const Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _TargetTitle extends StatelessWidget {
  final Article new_;

  const _TargetTitle(this.new_);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        new_.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TargetTopBar extends StatelessWidget {
  final Article new_;
  final int index;
  const _TargetTopBar({
    required this.new_,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ',
              style: TextStyle(color: myTheme.colorScheme.secondary)),
          Text('${new_.source.name}. ',
              style: TextStyle(color: myTheme.colorScheme.secondary))
        ],
      ),
    );
  }
}
