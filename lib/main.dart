import 'package:flutter/material.dart';
import 'package:learning_bloc2/apis/login_api.dart';
import 'package:learning_bloc2/apis/notes_api.dart';
import 'package:learning_bloc2/bloc/actions.dart';
import 'package:learning_bloc2/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc2/bloc/app_state.dart';
import 'package:learning_bloc2/dialogs/generic_dialog.dart';
import 'package:learning_bloc2/dialogs/loading_screen.dart';
import 'package:learning_bloc2/models.dart';
import 'package:learning_bloc2/strings.dart';
import 'package:learning_bloc2/views/iterable_list_view.dart';
import 'package:learning_bloc2/views/login_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(homePage),
          ),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          /// [listener] : Side effect(s) part => Overlay
          /// (which is a loading screen) is not the part of the Widget Tree.
          listener: (context, appState) {
            // Loading Screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            //Display possible errors
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionsBuilder: () => {ok: true},
              );
            }

            // If we are logged in, but we have no fetched notes, fetch them now.
            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(const LoadNotesAction());
            }
          },

          /// [builder] : What needs to be
          /// displayed on the screen inside the Widget Tree such as Login-, ListView.
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
