import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hizashi/common/widgets/cards/source_card.dart';
import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/navigation/app_route_names.dart';

class NovelSourceTab extends StatelessWidget {
  const NovelSourceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final sources = NovelSourcesConstants.list;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        final source = sources[index];
        return SourceCard(
            title: source.sourceName,
            subtitle: source.sourceUrl,
            imageUrlPath: source.sourceImagePath,
            onTap: () {
                context.pushNamed(AppRouteNames.sourceNovelScreen, pathParameters: {
                  "sourceId": source.sourceId.name,
                });
                
            }
        );
      },
    );
  }
}