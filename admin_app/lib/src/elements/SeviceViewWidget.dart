import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/bookingstatusmanage.dart';
import 'package:login_and_signup_web/src/models/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../controllers/hservice_controller.dart';
import '../helpers/helper.dart';
import '../models/providerdata_model.dart';
class ServiceViewWidget extends StatefulWidget {
  final ProviderModel providerDetails;
  const ServiceViewWidget({Key key,this.providerDetails}) : super(key: key);

  @override
  _ServiceViewWidgetState createState() => _ServiceViewWidgetState();
}

class _ServiceViewWidgetState extends StateMVC<ServiceViewWidget> {
  HServiceController _con;
  _ServiceViewWidgetState() : super(HServiceController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.listenForProviderService(widget.providerDetails.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,

        child: Div(
          colS: 12,
          colM: 8,
          colL: 7,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service details',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear),
                            iconSize: 25,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(widget.providerDetails.username)],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      height: 20,
                      thickness: 1,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Category'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Sub Category'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Experience'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Type'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Price'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('quick Pitch'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(color: Colors.black54)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Action'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _con.providerServiceList.isEmpty?SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      ),
                    ):Wrap(
                      children: List.generate(_con.providerServiceList.length, (index) {
                        ProviderServiceDataModel _providerServiceData  =_con.providerServiceList.elementAt(index);



                        return Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_providerServiceData.categoryName),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(_providerServiceData.subcategoryName),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(_providerServiceData.experience),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(_providerServiceData.type),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(Helper.pricePrint(_providerServiceData.chargePreHrs)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(color: Colors.black54)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(_providerServiceData.quickPitch),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 75,
                                  height: 25,
                                  child:
                                  // ignore: deprecated_member_use
                                  FlatButton(onPressed: (){
                                    return  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(S.of(context).confirm),
                                          content: Text("Are you sure to delete?",maxLines: 5,),
                                          actions: <Widget>[
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  _con.delete('provider_databook',_providerServiceData.id);

                                                },
                                                child: Text(S.of(context).delete)
                                            ),
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(S.of(context).cancel),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  },
                                      color: Colors.red,
                                      shape: StadiumBorder(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          S.of(context).delete,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.caption.merge(
                                              TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight)),
                                        ),
                                      )
                                  )
                              )
                            ],
                          ),
                        );
                      }),
                    ),

                  ],
                )),
          ),
        ));
  }
}
