import 'package:chat_app/pages/login_pages.dart';
import 'package:chat_app/pages/usuarios_pages.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context,  snapshot) { 
          return Center(
          child: Text('Espere...'),
          );
        },
      ),
      );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context,listen: false );
    final autenticando = await authService.isLoggedIn();
    if(autenticando){
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
      context,
      PageRouteBuilder<dynamic>(
        pageBuilder: ( _, __, ___ ) => UsuariosPage(),
        transitionDuration: Duration(milliseconds: 0)
          )
        );
    }else{
      Navigator.pushReplacement(
      context,
      PageRouteBuilder<dynamic>(
        pageBuilder: ( _, __, ___ ) => LoginPage(),
        transitionDuration: Duration(milliseconds: 0)
          )
        );
    }
  }

}