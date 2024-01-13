import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:notepadsss/models/note.dart";
import "package:notepadsss/models/note_data.dart";
import "package:notepadsss/pages/editing_note_page.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState()
  {
    super.initState();
    Provider.of<NoteData>(context, listen:false).getAllNotes().length;
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }
//createnewNote
void createNewNote(){
  //create a new ID
  int id=Provider.of<NoteData>(context, listen:false).getAllNotes().length;
//create a blank note

Note newNote = Note(
  id: id, 
  text: '');

  //go to edit the note
 goToNotePage(newNote, true);
}

//function to go to edit the notes page
void goToNotePage(Note note,  bool isNewNote){
  Navigator.push(context,
   MaterialPageRoute(builder:(context) => EditingNotePage(note: note, isNewNote: isNewNote),));
}

//delete note function
void deleteNote(Note note)
{
  Provider.of<NoteData>(context, listen:false).deleteNote(note);
}
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, value, child) => Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      floatingActionButton: FloatingActionButton(onPressed: createNewNote,
      backgroundColor: Colors.grey,
      child: Icon(Icons.add, color:Colors.yellow),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            //Heading
        
           Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 65),
                child: RichText( // Change to RichText for styling
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Notes', // Separate the "Notes" part
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      TextSpan(
                        text: '    by Surja', // Add "by Surja" in a different style
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            //list of notes
            value.getAllNotes().length==0 ? 
            Padding(
              padding: const EdgeInsets.only(top:25.0),
              child:
            Center(
              child:
             Text('Start your creative journey here....')
              ),
              )
              : 
             CupertinoListSection.insetGrouped( children: 
              
                List.generate(value.getAllNotes().length,
                 (index) => CupertinoListTile(
                  title: Text(value.getAllNotes()[index].text),
                  onTap: ()=> goToNotePage(value.getAllNotes()[index], false ),
                  trailing: IconButton(icon: Icon(Icons.delete),
                  onPressed:() => deleteNote(value.getAllNotes()[index]),),
                  ),
                 ),
            
            ),
          ],
        ),
      ),
      
    ),
    );
  }
}