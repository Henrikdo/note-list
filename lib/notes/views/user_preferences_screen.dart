import 'package:flutter/material.dart';
import 'package:teladelogin/core/components/export_components.dart';
import 'package:teladelogin/notes/controller/note_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teladelogin/notes/components/expor_components.dart';
class UserPreferences extends StatelessWidget {
  UserPreferences({super.key});
  final NoteController _noteController = NoteController();

  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(child: _body(context)),
    ));
  }

  Widget _body(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        top: MediaQuery.of(context).size.height * 0.15,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              
              height: MediaQuery.of(context).size.height * 0.38,
              decoration:  BoxDecoration(
                color: Colors.white,
                
                borderRadius: BorderRadius.circular(10),
              ),
              child: _noteList(),
            ),
            Focus(
              autofocus: true,
              child: CustomTextField(
                hintText: 'Digite seu texto.',
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Campo vazio';
                    }
                    return null;
                  }
                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    _noteController.saveString(value);
                  }
                },
                focusNode: _focusNode,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: PrivacyPolicy()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noteList() {
    return Observer(builder: (context) {
      //Carrega os dados.
      _noteController.loadStrings();
      return ListView.builder(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _noteController.strings.length,
        itemBuilder: (context, index) {
          return Note(noteController: _noteController,index: index,);
        },
      );
    });
  }

}
