// lib/widgets/collection_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/collection.dart';
import '../config/theme.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;

  const CollectionCard({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/collection/${collection.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Collection Image
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: Image.asset(
                  collection.image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.collections, size: 48, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            // Collection Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name,
                    style: AppTheme.heading2.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    collection.description,
                    style: AppTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
