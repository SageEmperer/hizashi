import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final title;
  final coverUrl;

  // onTap: () {

  final VoidCallback? onTap;

  const BookCard({
    super.key,
    required this.title,
    required this.coverUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                coverUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(
                    color: Colors.black12,
                    child: Center(child: Icon(Icons.book_outlined)),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "$title",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
