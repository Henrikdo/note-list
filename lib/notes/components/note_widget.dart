import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teladelogin/notes/controller/note_controller.dart';

class Note extends StatelessWidget {
  Note({super.key, required this.noteController, required this.index});

  final NoteController noteController;
  final int index;

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.005,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4 ,
                  child: Text(
                noteController.strings[index],
                overflow: TextOverflow.fade,
                softWrap: false,
              )),
              const Spacer(),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () async {
                    _controller.text = noteController.strings[index];

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Editar nota'),
                          content: TextFormField(
                            controller: _controller,
                            decoration: const InputDecoration(hintText: 'Editar'),
                            onFieldSubmitted: (value) {
                              noteController.editString(index, value);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: const Text('Deletar nota?'),
                            content: _deleteConfirmButton(
                              context,
                              index,
                            ));
                      },
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: Colors.red,
                  )),
            ]),
          ),
        ),
        const Divider(
            height: 1,
            thickness: 1,
            indent: 8,
            endIndent: 10,
            color: Colors.grey),
      ],
    );
  }

  Widget _deleteConfirmButton(context, index) {
    return FilledButton(
      onPressed: () => {
        noteController.removeString(noteController.strings[index]),
        Navigator.pop(context)
      },
      style: FilledButton.styleFrom(
          backgroundColor: const Color.fromRGBO(90, 190, 125, 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.11),
        child: Text(
          'Sim',
          style: GoogleFonts.ptSans(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: const Color.fromRGBO(206, 229, 227, 1),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
