import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('form-register')
class FormRegister extends FormElement with Polymer, Observable
{
  @observable Map data = toObservable({"email": "", "password": ""});
  
  InputElement email, password;
//  RegExp r = new RegExp(r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$");
  RegExp r = new RegExp(r"^[A-Za-z0-9_.-]+$");
  
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
    
    validate_email();
  }
  
  void register_button_click(Event e, var detail, Node target)
  {
    // Register button was clicked.
    e.preventDefault();
    
    if (validate_email())
    {
      print(data.toString());
      this.fire("login", detail: data["email"]);
    }
    else
      print("Validation failed!");
  }
  
  void send_button_click(Event e, var detail, Node target)
  {
    e.preventDefault();
    
    this.fire("message", detail: data["password"]);
  }
  
  void email_textbox_change(Event e)
  {
    validate_email();
  }
  
  bool validate_email()
  {
    bool result = r.hasMatch(data["email"]);
    if (result)
      email.style.borderColor = 'lightgreen';
    else
      email.style.borderColor = 'red';
    return result;
  }
}