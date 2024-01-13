import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class HiveDatabase {
  // Reference our hive box
  final _myBox = Hive.box('note_database');

  // Load notes
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    try {
      // If there exist notes, return them; otherwise, return an empty list.
      if (_myBox.containsKey("ALL_NOTES")) {
        List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
        for (int i = 0; i < savedNotes.length; i++) {
          // Create an individual note
          Note individualNote = Note(id: savedNotes[i][0], text: savedNotes[i][1]);

          // Add to the list
          savedNotesFormatted.add(individualNote);
        }
      }
    } catch (e) {
      // Handle exceptions (e.g., HiveError)
      print('Error loading notes: $e');
    }

    return savedNotesFormatted;
  }

  // Save notes
  void saveNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    // Then store into Hive
    try {
      _myBox.put("ALL_NOTES", allNotesFormatted);
    } catch (e) {
      // Handle exceptions (e.g., HiveError)
      print('Error saving notes: $e');
    }
  }
}
