import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('form-register')
class FormRegister extends FormElement with Polymer, Observable
{
  @observable Map data = toObservable({"email": "", "password": ""});
  
  InputElement email, password;
  
  FormRegister.created() : super.created()
  {
    polymerCreated();
  }
  
  @override
  void attached()
  {
    super.attached();
    
    email = $['email_textbox'];
    password = $['password_textbox'];
  }
  
  void register_button_click(Event e, var detail, Node target)
  {
    // Register button was clicked.
    e.preventDefault();
    
    print(data.toString());
    email.style.borderColor = 'red';
  }
}