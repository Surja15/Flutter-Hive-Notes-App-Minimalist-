import 'package:flutter/material.dart';
import 'package:notepadsss/data/hive_database.dart';
import 'package:notepadsss/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteData extends ChangeNotifier {
  // Hive database
  final db = HiveDatabase();

  // Overall list of notes
  List<Note> allNotes = [];

  // Constructor
  NoteData() {
    initializeNotes();
  }

 // Initialize list
void initializeNotes() {
  // Load notes from Hive
  List<Note> loadedNotes = db.loadNotes();

  // Check if the list is empty, add a default note, and save it
  if (loadedNotes.isEmpty) {
    loadedNotes.add(Note(id: 0, text: 'First Note'));
    db.saveNotes(loadedNotes);
  }

  // Update the allNotes list after the initialization
  allNotes = loadedNotes;

  // Notify listeners after initialization
  Future.microtask(() {
    notifyListeners();
  });
}


  // Get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // Add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    db.saveNotes(allNotes);
    notifyListeners();
  }

  // Update note
  void updateNote(Note note, String text) {
    // Go through and find relevant note
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }

    // Save updated notes to Hive
    db.saveNotes(allNotes);
    notifyListeners();
  }

  // Delete note
  void deleteNote(Note note) {
    allNotes.remove(note);

    // Save updated notes to Hive
    db.saveNotes(allNotes);
    notifyListeners();
  }
}
