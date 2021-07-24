import 'package:flutter/material.dart';
import 'package:ukrpay_exam/model/reg-model.dart';
import 'package:ukrpay_exam/widgets/widgets_factory.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
     ChangeNotifierProvider(
      create: (context) => RegistrationModel(),
      child: UkrPayExamApp(),
    )
  );

}

class UkrPayExamApp extends StatelessWidget {
  const UkrPayExamApp({Key? key}) : super(key: key);
  static const String _title = 'UKR PAY EXAM';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const UkrPayExamStatefulWidget(),
      ),
    );
  }
}


class UkrPayExamStatefulWidget extends StatefulWidget {
  const UkrPayExamStatefulWidget({Key? key}) : super(key: key);

  @override
  State<UkrPayExamStatefulWidget> createState() => _UkrPayExamStatefulWidgetState();
}

class _UkrPayExamStatefulWidgetState extends State<UkrPayExamStatefulWidget> {

 var _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: Column(
              children:[
                Expanded(flex:100,
                   child:Container(
                     alignment: Alignment.topCenter,
                      padding:EdgeInsets.only(left:size.width*.30, right:size.width*.30, top:100),
                      child: Consumer<RegistrationModel>(
                          builder: (context, regModel, child) {
                               return WidgetsFactory.buildCheckCodeResult(regModel);
                           }
                      ),
                   )
                ),
                Container(
                       alignment:Alignment.bottomLeft,
                       child: TextField(
                          onChanged: (value ){
                            _handleKeyboard(value);
                          },
                          controller: _controller,
                          showCursor: false,
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                          autofocus: true,
                          style: TextStyle(color: Colors.transparent),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                          ),
                        )
                   ),
              ]
            )
      );
  }

  void _handleKeyboard(String value){
      var currCode =  context.read<RegistrationModel>().inpCode = value;
      if(currCode.length > 3){
        context.read<RegistrationModel>().status = RegistrationModel.WAITNG_STATUS;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context,) {
              return Center(child: CircularProgressIndicator(),);
            });

        Future.delayed(Duration(seconds:3)).then((value) {
          Navigator.pop(context);
          var status = currCode == context.read<RegistrationModel>().verifyCode?
           RegistrationModel.CORRECT_STATUS:
          RegistrationModel.INCORRECT_STATUS;
          context.read<RegistrationModel>().status = status;
          if(status == RegistrationModel.INCORRECT_STATUS)
            context.read<RegistrationModel>().inpCode = "";
          _controller.clear();
        });
     }
  }
}
