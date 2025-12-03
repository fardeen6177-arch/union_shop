// lib/services/collection_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/collection.dart';

class CollectionService {
  List<Collection>? _cachedCollections;

  /// Load all collections from local JSON
  Future<List<Collection>> getCollections() async {
    if (_cachedCollections != null) {
      return _cachedCollections!;
    }

    try {
      final String response = await rootBundle.loadString('assets/data/collections.json');
      final List<dynamic> data = json.decode(response);
      _cachedCollections = data.map((json) => Collection.fromJson(json)).toList();
      return _cachedCollections!;
    } catch (e) {
      throw Exception('Failed to load collections: $e');
    }
  }

  /// Get single collection by ID
  Future<Collection?> getCollectionById(String id) async {
    final collections = await getCollections();
    try {
      return collections.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get single collection by slug
  Future<Collection?> getCollectionBySlug(String slug) async {
    final collections = await getCollections();
    try {
      return collections.firstWhere((c) => c.slug == slug);
    } catch (e) {
      return null;
    }
  }

  /// Clear cache (useful for testing)
  void clearCache() {
    _cachedCollections = null;
  }
}
