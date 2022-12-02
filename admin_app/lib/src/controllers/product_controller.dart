import 'package:flutter/cupertino.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import 'package:vrouter/vrouter.dart';
import '../models/addon.dart';
import '../models/product.dart';
import '../models/product_details2.dart';
import '../models/product_model.dart';
import '../models/variant.dart';
import '../repository/product_repository.dart' as repository;
import '../repository/settings_repository.dart';

class ProductController extends ControllerMVC {
  GlobalKey<FormState> categoryFormKey;
  GlobalKey<FormState> subcategoryFormKey;
  GlobalKey<FormState> productFormKey;
  List<ProductDetails2> productSearchList = <ProductDetails2>[];
  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<DropDownModel> subDropDownList = <DropDownModel>[];
  List<Product> categoryProducts = <Product>[];
  List<variantModel> variantList = <variantModel>[];
  List<AddonModel> addonList = <AddonModel>[];
  variantModel variantData = new variantModel();
  ProductDetails2 productDetails2=new ProductDetails2();
  ProductModel productData = new ProductModel();
  TextEditingController saleController;
  TextEditingController strickPriceController;
  TextEditingController discountController;
  List<DropDownModel> dropDownnoList = <DropDownModel>[];
  AddonModel addonData = new AddonModel();
  GlobalKey<FormState> addonFormKey;
  // ignore: non_constant_identifier_names

  OverlayEntry loader;
  ProductController() {
    strickPriceController = TextEditingController();
    loader = Helper.overlayLoader(context);
    subcategoryFormKey =  new GlobalKey<FormState>();
    discountController =  TextEditingController();
    productFormKey = new GlobalKey<FormState>();
    categoryFormKey = new GlobalKey<FormState>();
    saleController = TextEditingController();
    addonFormKey = new GlobalKey<FormState>();
  }












  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> listenForSubDropdown(table, select, column, para1) async {
    subDropDownList.clear();

    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => subDropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }




  productStatus(productId,status){

      repository.updateProductStatus(productId,status).then((value) {
        showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      });
  }

  void listenForProductsByCategory(listType, shopId) async {
    setState((){
      categoryProducts.clear();
      productSearchList.clear();
    });
    final Stream<Product> stream = await getProducts(listType, shopId);
    stream.listen((Product _product) {
      setState(() {
        categoryProducts.add(_product);
        productSearchList.addAll(_product.productdetails);
      });

    }, onError: (a) {
      /** scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).verify_your_internet_connection),
          )); */
    }, onDone: () {});
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  void showToastPopup(String msg, context,  {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  Future<void> listenForVariant(id, variantPop, pageType) async {
    Overlay.of(context).insert(loader);
    variantList.clear();
    final Stream<variantModel> stream = await getVariantData(id,pageType);
    stream.listen((variantModel _list) {
      setState(() => variantList.add(_list));

    }, onError: (a) {
      loader.remove();
      print(a);
    }, onDone: () {
      Helper.hideLoader(loader);
      variantPop(variantList);
    });
  }

  Future<void> listenForAddon(id, variantPop, ) async {
    Overlay.of(context).insert(loader);
    addonList.clear();
    final Stream<AddonModel> stream = await getAddonData(id);
    stream.listen((AddonModel _list) {
      print(_list.toMap());
      setState(() => addonList.add(_list));

    }, onError: (a) {
      loader.remove();
      print(a);
    }, onDone: () {
      Helper.hideLoader(loader);

      variantPop(addonList);

    });
  }

  delete(table, id){
    if(table=='product'){
    //  listenForProductsByCategory('product');
    } else if(table=='Itemproduct'){
     // listenForProductsByCategory('Itemproduct');
    }
    repository.globalDelete(table, id).then((value) {

      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);

    });
  }

  todayDealStatus(productId,status,type, function){
    showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    repository.updateTodaydeals(productId,status, type, function).then((value) {
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use

    });
  }

  editAvailableTime(id){
    Overlay.of(context).insert(loader);
    repository.editProductAvailableTime(productDetails2, 'editAT', id).then((value) {
      showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
    }).whenComplete(() {
      Helper.hideLoader(loader);
      Navigator.pop(context);
      VRouter.of(context).toNamed('itemlist');
     // listenForProductsByCategory('Itemproduct');
    });
  }

  calculateDiscount(){
    double strickPrice = double.parse(strickPriceController.text);
    print('distance${discountController.text}');
    double discount = double.parse(discountController.text);
    double discountAmount =  (strickPrice*discount)/100;
    double netAmount = strickPrice -  discountAmount;
    saleController.text = num.parse(netAmount.toStringAsFixed(setting.value.currencyDecimalDigits)).toString();
  }

  variantCE(pageType, productId, context,functionType){
    if (productFormKey.currentState.validate()) {
      productFormKey.currentState.save();

      if ( variantData.uploadImage!=null) {
        Overlay.of(context).insert(loader);
        if (pageType == 'variant_edit') {
          variantData.variant_id = productId;
        }

        repository.productVariant(variantData, pageType, productId,functionType).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);

          setState(() => variantList.clear());
          Navigator.pop(context);
          Navigator.of(context).pop();
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  addonUpdate(context, pageType, id) {
    if (addonFormKey.currentState.validate()) {
      addonFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.addEdAddon(addonData, pageType, id).then((value) {
        showToastPopup("Update Successfully",context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      }).catchError((e) {
        print(e);
      }).whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context);
        Helper.hideLoader(loader);


      });
    }

  }

  Future<void> listenForNoDropdown(table, select) async {
    dropDownnoList.clear();
    final Stream<DropDownModel> stream = await getDropdownData(table, select,);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownnoList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  addEditProductItem(context, shopType, shopId){
    if (productFormKey.currentState.validate()) {
      productFormKey.currentState.save();
      if (productData.uploadImage != null) {
        Overlay.of(context).insert(loader);
        repository.productItemData(productData, 'add', shopType, shopId).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          Navigator.pop(context);
        });
      }else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  addEditProduct(context, shopType, shopId){
    if (productFormKey.currentState.validate()) {
      productFormKey.currentState.save();
      if (productData.uploadImage != null) {
        Overlay.of(context).insert(loader);
        repository.productData(productData, 'add', shopType, shopId).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          VRouter.of(context).toNamed('productlist');
        });
      }else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
  }
}