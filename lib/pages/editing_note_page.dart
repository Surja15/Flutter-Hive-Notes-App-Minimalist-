import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepadsss/models/note.dart';
import 'package:notepadsss/models/note_data.dart';
import 'package:provider/provider.dart';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;

  EditingNotePage({Key? key, required this.isNewNote, required this.note})
      : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  // Load existing note
  void loadExistingNote() {
    _textController.text = widget.note.text;
  }

  // Retrieve data from the text field
  String getNoteText() {
    return _textController.text;
  }

  // Add new note
  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = getNoteText();
    Provider.of<NoteData>(context, listen: false).addNewNote(
      Note(id: id, text: text),
    );
  }

  // Update existing note
  void updateNote() {
    String text = getNoteText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.save, color: Colors.black, ),
          
          onPressed: () {
            if (widget.isNewNote && !_textController.text.isEmpty) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
          color: CupertinoColors.systemBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
        child: Column(
          children: [
            // Text input
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Start typing...',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
