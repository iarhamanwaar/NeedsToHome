import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/pages/languages.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;
// ignore: must_be_immutable
class ProfileProcessChecking extends StatefulWidget {
  final Function onCLick;

  ProfileProcessChecking({Key key, this.onCLick}) : super(key: key);
  bool state;
 @override
  _ProfileProcessCheckingState createState() => _ProfileProcessCheckingState();
}

class _ProfileProcessCheckingState extends State<ProfileProcessChecking> with SingleTickerProviderStateMixin  {




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        height: size.height,width:double.infinity,
        decoration:  !GetPlatform.isMobile?BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Profilebg.png'),
              fit: BoxFit.fill,
            )
        ):BoxDecoration(),
      child:Stack(
          children:[
            !GetPlatform.isMobile?Positioned(
             top:size.height * 0.35,
             left: size.width * 0.1,
             child:Transform.rotate(
               angle: -math.pi / 87,
               child:Text('Get Start Your Business',
                   style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700)
               ),
             ),
           ):Container(),

            !GetPlatform.isMobile? Positioned(
                top:size.height * 0.52,
                left: size.width * 0.3,
                child:Transform.rotate(
                  angle: -math.pi / 87,
                    child:Text('Now !',
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,color:Theme.of(context).primaryColorLight)
                    )
                ),

            ):Container(),
            Container(
                padding: EdgeInsets.only(left:size.width > 769 ?30:20,right:size.width > 769 ?30:20,top:size.width > 769 ? 0:30),
                child: Column(
                  children: [
                Expanded(
                    child:Container(
                        padding: EdgeInsets.only(left:size.width > 769 ?20:0,),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: size.width > 769 ? MainAxisAlignment.center :MainAxisAlignment.start,
                            children:[
                              Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                                children:[
                                  Expanded(
                                      child:Container(
                                          child:Text(
                                            currentUser.value.profileComplete=='5'?'Waiting for approval':S.of(context).please_complete_your_profile,
                                            style: size.width > 769 ? Theme.of(context).textTheme.headline4 : Theme.of(context).textTheme.bodyText1,
                                          ))
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Wrap(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Image(image: setting.value.language=='English'?
                                        AssetImage('assets/img/united-states-of-america.png'): setting.value.language=='العربية'?AssetImage('assets/img/united-arab-emirates.png'):
                                        setting.value.language=='Français - France'?AssetImage('assets/img/france.png'):
                                        setting.value.language=='Spana'?AssetImage('assets/img/spain.png'):
                                        setting.value.language=='germen - Canadien'?AssetImage('assets/img/germany.png'):
                                        setting.value.language=='Malay'?AssetImage('assets/img/malay.png'):
                                        setting.value.language=='Korean'?AssetImage('assets/img/united-states-of-america.png'):
                                        setting.value.language=='Chinese'?AssetImage('assets/img/china.png'):
                                        AssetImage('assets/img/united-states-of-america.png'), height: 20, width: 20),
                                      ),

                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguagesWidget()));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 3, left: 5),
                                          child: Text(setting.value.language, style: Theme.of(context).textTheme.bodyText2),
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down,color:Colors.grey),
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    logout().then((value) {
                                      // ignore: deprecated_member_use
                                      VRouter.of(context).pushReplacement('/login');
                                    });
                                  }, icon: Icon(Icons.power_settings_new_sharp,color: Colors.red,))
                                ]
                              ),
                              SizedBox(height:20),
                              Wrap(

                                  children:[
                                    Div(
                                        colS:12,
                                        colM:12,
                                        colL:12,
                                        child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: size.width > 769 ? MainAxisAlignment.center :MainAxisAlignment.start,
                                            children:[
                                              Container(
                                                  margin: EdgeInsets.only(left:size.width > 769 ? 20 : 10,
                                                      right:size.width > 769 ? 30 : 0, bottom: 20),
                                                  child:Wrap(
                                                      runSpacing: 20,
                                                      children:[
                                                        Div(
                                                            colS:12,
                                                            colM:12,
                                                            colL:6,
                                                            child:Center(
                                                                child:Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: size.width > 769 ? MainAxisAlignment.center :MainAxisAlignment.start,
                                                                    children:[

                                                                    ]
                                                                ))
                                                        ),
                                                        Div(
                                                            colS:12,
                                                            colM:12,
                                                            colL:6,
                                                            child:Container(
                                                                margin: EdgeInsets.only(top:size.width > 769 ? 0 :5),
                                                                child:Center(
                                                                    child:Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children:[

                                                                          CircularPercentIndicator(
                                                                            radius: size.width > 769 ? size.height * 0.2 :size.height * 0.2,
                                                                            lineWidth: 10.0,
                                                                            percent: currentUser.value.profileComplete=='5'?1:0,
                                                                            reverse: true,
                                                                            center: Center(child:Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children:[
                                                                                  Text(currentUser.value.profileComplete=='5'?'100 %':'0 %',
                                                                                    style: TextStyle(fontSize: size.width > 769 ? 40 :25,),
                                                                                  ),

                                                                                  Text(currentUser.value.profileComplete=='5'?S.of(context).completed:S.of(context).pending,
                                                                                      style: size.width > 769 ?


                                                                                      Theme.of(context).textTheme.headline5.merge(TextStyle(color:Theme.of(context).colorScheme.secondary)) :
                                                                                      Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).colorScheme.secondary))
                                                                                  )
                                                                                ]
                                                                            ),),
                                                                            progressColor: Colors.green,
                                                                          ),
                                                                          SizedBox(height: 20,),
                                                                          // ignore: deprecated_member_use
                                                                          currentUser.value.profileComplete=='5'?FlatButton(
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              logout().then((value) {
                                                                                // Toast.show('${S.of(context).logout} ${S.of(context).successfully}', context, duration: Toast.BOTTOM, gravity: Toast.LENGTH_SHORT ,);
                                                                                // ignore: deprecated_member_use
                                                                                VRouter.of(context).pushReplacement('/login');
                                                                              });
                                                                            },
                                                                            padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                                            shape: StadiumBorder(),
                                                                            child: Text(
                                                                              S.of(context).logout,
                                                                              style: Theme.of(context).textTheme.headline6.merge(
                                                                                  TextStyle(
                                                                                      color: Theme.of(context)
                                                                                          .primaryColorLight)),
                                                                            ),
                                                                            // ignore: deprecated_member_use
                                                                          ):FlatButton(
                                                                            onPressed: () {
                                                                              widget.onCLick();
                                                                            },
                                                                            padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                                            shape: StadiumBorder(),
                                                                            child: Text(
                                                                              S.of(context).get_start,
                                                                              style: Theme.of(context).textTheme.headline6.merge(
                                                                                  TextStyle(
                                                                                      color: Theme.of(context)
                                                                                          .primaryColorLight)),
                                                                            ),
                                                                          ),
                                                                        ]
                                                                    )))
                                                        )

                                                      ]
                                                  )
                                              ),

                                            ]
                                        )
                                    ),
                                  ]
                              )
                            ]
                        )
                    )
                ),
                Align(
                    child: Container(
                        child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                            ])))
              ])
            )
          ]
      ),
    );


  }

}
