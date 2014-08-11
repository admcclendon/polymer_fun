import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('form-register')
class FormRegister extends FormElement with Polymer, Observable
{
  @observable Map data = toObservable({"email": "", "password": ""});
  
  InputElement email, password;
  RegExp r = new RegExp(r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$");
  
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
    
    if (validate_email())
      print(data.toString());
    else
      print("Validation failed!");
  }
  
  void email_textbox_change(Event e)
  {
    if (validate_email())
      email.style.borderColor = 'green';
    else
      email.style.borderColor = 'red';
  }
  
  bool validate_email()
  {
    return r.hasMatch(data["email"]);
  }
}