import 'package:shared_preferences/shared_preferences.dart';

final int maxClicks_PerMinute = 1;
final int lock_Duration = 2;

Future<bool> handle_Button_Click(String button_Name) async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now().millisecondsSinceEpoch;

  // Check if the button is locked
  int? lockTimestamp = prefs.getInt('lock_$button_Name');
  if (lockTimestamp != null && now < lockTimestamp) {
    return false;
  }

  // Load the list of timestamps from shared preferences for all the clicks
  List<String>? timestampStrings = prefs.getStringList('clicks_$button_Name');
  List<int> timestamps =
      timestampStrings?.map((str) => int.parse(str)).toList() ?? [];

  // Filter out timestamps older than 1 minute
  timestamps =
      timestamps.where((timestamp) => now - timestamp <= 1000).toList();

  if (timestamps.length >= maxClicks_PerMinute) {
    // User has exceeded the click limit
    // Lock the button
    prefs.setInt('lock_$button_Name', now + lock_Duration * 1000);
    return false;
  }

  // Add the current timestamp to the list and return true
  timestamps.add(now);
  prefs.setStringList('clicks_$button_Name',
      timestamps.map((timestamp) => timestamp.toString()).toList());
  return true;
}
