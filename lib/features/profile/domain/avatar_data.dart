import 'package:flutter/material.dart';

/// Avatar verisi.
class AvatarData {
  final int id;
  final String name;
  final IconData icon;
  final Color backgroundColor;

  const AvatarData({
    required this.id,
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });
}

/// Önceden tanımlı avatar listesi.
const List<AvatarData> predefinedAvatars = [
  AvatarData(
    id: 0,
    name: 'Varsayılan',
    icon: Icons.person,
    backgroundColor: Color(0xFF6B7280),
  ),
  AvatarData(
    id: 1,
    name: 'Kitap',
    icon: Icons.menu_book,
    backgroundColor: Color(0xFF3B82F6),
  ),
  AvatarData(
    id: 2,
    name: 'Hesap',
    icon: Icons.calculate,
    backgroundColor: Color(0xFF10B981),
  ),
  AvatarData(
    id: 3,
    name: 'Yıldız',
    icon: Icons.star,
    backgroundColor: Color(0xFFF59E0B),
  ),
  AvatarData(
    id: 4,
    name: 'Kupa',
    icon: Icons.emoji_events,
    backgroundColor: Color(0xFFD4AF37),
  ),
  AvatarData(
    id: 5,
    name: 'Alev',
    icon: Icons.local_fire_department,
    backgroundColor: Color(0xFFEF4444),
  ),
  AvatarData(
    id: 6,
    name: 'Elmas',
    icon: Icons.diamond,
    backgroundColor: Color(0xFF8B5CF6),
  ),
  AvatarData(
    id: 7,
    name: 'Kalp',
    icon: Icons.favorite,
    backgroundColor: Color(0xFFEC4899),
  ),
  AvatarData(
    id: 8,
    name: 'Madalya',
    icon: Icons.military_tech,
    backgroundColor: Color(0xFFB45309),
  ),
  AvatarData(
    id: 9,
    name: 'Profesör',
    icon: Icons.school,
    backgroundColor: Color(0xFF1D4ED8),
  ),
  AvatarData(
    id: 10,
    name: 'Şimşek',
    icon: Icons.bolt,
    backgroundColor: Color(0xFFEAB308),
  ),
  AvatarData(
    id: 11,
    name: 'Robot',
    icon: Icons.smart_toy,
    backgroundColor: Color(0xFF06B6D4),
  ),
];

/// ID'ye göre avatar getir.
AvatarData getAvatarById(int id) {
  return predefinedAvatars.firstWhere(
    (a) => a.id == id,
    orElse: () => predefinedAvatars[0],
  );
}
