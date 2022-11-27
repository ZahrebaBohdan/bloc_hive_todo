import 'package:bloc_hive_todo/presentation/screens/todos/todos.dart';
import 'package:bloc_hive_todo/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController usernameFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: BlocProvider(
                create: (context) => HomeBloc(
                    RepositoryProvider.of<AuthenticationService>(context),
                    RepositoryProvider.of(context))
                  ..add(RegisterServicesEvent()),
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is SuccessfulLoginState) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            TodosPage(username: state.username),
                      ));
                    }
                    if (state is HomeInitial) {
                      if (state.error != null) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(title: Text(state.error!)),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is HomeInitial) {
                      return SafeArea(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  controller: usernameFieldController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  obscuringCharacter: '*',
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  controller: passwordFieldController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    kPrimaryColor)),
                                        onPressed: () =>
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(
                                          LoginEvent(
                                            usernameFieldController.text,
                                            passwordFieldController.text,
                                          ),
                                        ),
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(
                                        RegisterAccountEvent(
                                          usernameFieldController.text,
                                          passwordFieldController.text,
                                        ),
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 18, color: kTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
