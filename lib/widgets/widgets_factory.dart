
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ukrpay_exam/model/reg-model.dart';

class WidgetsFactory {

  static Widget buildDigitCode(String digit, [Color color =Colors.black]){

    return Container(
      alignment: Alignment.center,
      width: 20,
      height: 30,
      margin: EdgeInsets.only(left:5, right:5, bottom:10, top:10),
      child: Text(
        digit,
        style: TextStyle(
           color:color,
           fontSize:24,
           fontWeight: FontWeight.bold
        )
      ),
    );
  }

  static Widget buildCheckCodeResult(RegistrationModel model){

    var helperText = 'Request code';
    var color = Colors.black;
    var code = model.inpCode;
    if(model.status == RegistrationModel.WAITNG_STATUS)
        helperText = 'Waiting ...';
      else if(model.status == RegistrationModel.CORRECT_STATUS)
        helperText = 'Congratulation!';
      else if(model.status == RegistrationModel.INCORRECT_STATUS){
        color = Colors.red;
        helperText = 'Incorrect code';
      }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Text(
              'Enter the code sent to +32 (0) 10 80 01 00',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              )
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                WidgetsFactory.buildDigitCode(code.isNotEmpty?code[0]:'\u25CF'),
                WidgetsFactory.buildDigitCode(code.length>1?code[1]:'\u25CF'),
                WidgetsFactory.buildDigitCode(code.length>2?code[2]:'\u25CF'),
                WidgetsFactory.buildDigitCode(code.length>3?code[3]:'\u25CF'),
              ]
          ),
          Text(
              helperText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color
              )
          )
        ]
    );
  }
}