import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widget/boton_azul.dart';
import 'package:chat_app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/helpers/mostrar_alerta.dart';
import '../widget/lables.dart';
import '../widget/logo.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: Color(0xfffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
              Logo(titulo:'Messenger'),
              _Form(),
              Labels(ruta:'register',
              titulo: 'No tienes cuentas?',
              subtitulo: 'Crea una ahora!',),
              Text('Terminos y  condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
             ],
               ),
          ),
        ),
      ),
   );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}
class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
         CustomInput(
          icon: Icons.mail_outline,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          texController: emailCtrl,
         ),
         CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contraseña',
          texController: passCtrl,
          isPassword: true,
         ),
          BotonAzul(
            text: 'Ingrese', 
            onPressed: authService.autenticando   ? () => {} 
              : () async {
              
              FocusScope.of(context).unfocus();

              final loginOK = await authService.login(emailCtrl.text, passCtrl.text.trim());
              if(loginOK){
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else{
                mostrarAlerta(context,'Login incorrecto','Revisar sus credenciales');
              }
          },
          )
        ]
        ),
    );
  }
}


