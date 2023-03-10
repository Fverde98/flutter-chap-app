import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widget/boton_azul.dart';
import 'package:chat_app/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/lables.dart';
import '../widget/logo.dart';


class RegisterPage extends StatelessWidget {

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
              Logo(titulo:'Registro'),
              _Form(),
              Labels(ruta:'login',
              titulo: 'Ya tienes una cuenta',
              subtitulo: 'Ingresa  ahora!',),
              Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auhtService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
        CustomInput(
          icon: Icons.perm_identity,
          placeholder: 'Nombre',
          keyboardType: TextInputType.text,
          texController: nameCtrl,
         ),
         CustomInput(
          icon: Icons.mail_outline,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          texController: emailCtrl,
         ),
         CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contrase??a',
          texController: passCtrl,
          isPassword: true,
         ),
          BotonAzul(text: 'Crear cuenta', 
          onPressed: auhtService.autenticando  ? () => {} 
              : () async {
            print(nameCtrl.text);
            print(emailCtrl.text);
            print(passCtrl.text);
            final registerOK = await auhtService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
            if(registerOK == true){
              Navigator.pushReplacementNamed(context,'usuarios');
            }else{
              mostrarAlerta(context, 'Registro incorrecto', registerOK);
            }
          },
          )
        ]),
    );
  }
}


