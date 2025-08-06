import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Service for preloading assets to improve app performance
class AssetPreloader {
  static final AssetPreloader _instance = AssetPreloader._internal();
  factory AssetPreloader() => _instance;
  AssetPreloader._internal();

  bool _criticalAssetsLoaded = false;
  bool _allAssetsLoaded = false;

  /// Preload critical assets needed for login/startup
  Future<void> preloadCriticalAssets() async {
    if (_criticalAssetsLoaded) return;

    try {
      // Preload critical images
      await Future.wait([
        _preloadAsset('assets/logo/corp_logo.png'),
        // Add other critical assets here
      ], eagerError: false);

      _criticalAssetsLoaded = true;
    } catch (e) {
      print('Warning: Some critical assets failed to preload: $e');
      _criticalAssetsLoaded = true; // Don't block the app
    }
  }

  /// Preload additional assets after login
  Future<void> preloadAdditionalAssets(BuildContext context) async {
    if (_allAssetsLoaded) return;

    try {
      // Preload dashboard-specific assets
      await Future.wait([
        _preloadImage(context, 'assets/images/profile_placeholder.png'),
        _preloadImage(context, 'assets/images/corp_background.png'),
        _preloadImage(context, 'assets/icons/influence_icon.png'),
        _preloadImage(context, 'assets/icons/tribute_icon.png'),
        _preloadImage(context, 'assets/icons/structure_icon.png'),
        _preloadImage(context, 'assets/icons/admin_icon.png'),
        // Add other dashboard assets here
      ], eagerError: false);

      _allAssetsLoaded = true;
    } catch (e) {
      print('Warning: Some additional assets failed to preload: $e');
      _allAssetsLoaded = true; // Don't block the app
    }
  }

  /// Preload a single asset
  Future<void> _preloadAsset(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
    } catch (e) {
      print('Failed to preload asset: $assetPath - $e');
    }
  }

  /// Preload an image with context for better caching
  Future<void> _preloadImage(BuildContext context, String assetPath) async {
    try {
      await precacheImage(AssetImage(assetPath), context);
    } catch (e) {
      print('Failed to preload image: $assetPath - $e');
    }
  }

  /// Check if critical assets are loaded
  bool get criticalAssetsLoaded => _criticalAssetsLoaded;

  /// Check if all assets are loaded
  bool get allAssetsLoaded => _allAssetsLoaded;

  /// Reset preloader state
  void reset() {
    _criticalAssetsLoaded = false;
    _allAssetsLoaded = false;
  }
}
