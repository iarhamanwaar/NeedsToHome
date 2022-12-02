
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/addon.dart';
import 'package:login_and_signup_web/src/models/category_List.dart';
import 'package:login_and_signup_web/src/models/category.dart';
import 'package:login_and_signup_web/src/models/product.dart';
import 'package:login_and_signup_web/src/models/product_details2.dart';
import 'package:login_and_signup_web/src/models/product_model.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';
import 'package:login_and_signup_web/src/models/variant.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import 'package:vrouter/vrouter.dart';
import '../repository/product_repository.dart' as repository;
class ProductController extends ControllerMVC {
  GlobalKey<FormState> categoryFormKey;
  GlobalKey<FormState> subcategoryFormKey;
  GlobalKey<ScaffoldState> scaffoldKeyState = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> productFormKey;
  CategoryModel categoryData = new CategoryModel();
  variantModel variantData = new variantModel();
  SubCategoryListModel subcategoryData = new SubCategoryListModel();
  ProductModel productData = new ProductModel();
  ProductDetails2 productDetails2=new ProductDetails2();
  List<CategoryListModel> categoryList = <CategoryListModel>[];
  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<DropDownModel> subDropDownList = <DropDownModel>[];
  List<ProductDetails2> productSearchList = <ProductDetails2>[];
  List<variantModel> variantList = <variantModel>[];
  List<AddonModel> addonList = <AddonModel>[];
  List<DropDownModel> dropDownnoList = <DropDownModel>[];
  AddonModel addonData = new AddonModel();
  TextEditingController strickPriceController;
  TextEditingController discountController;
  TextEditingController saleController;
  GlobalKey<FormState> addonFormKey;
  // ignore: non_constant_identifier_names
  List<Product> category_products = <Product>[];
  List<SubCategoryListModel> subcategoryList = <SubCategoryListModel>[];
  OverlayEntry loader;
  ProductController() {
    strickPriceController = TextEditingController();
    discountController =  TextEditingController();
    saleController = TextEditingController();
    loader = Helper.overlayLoader(context);
    subcategoryFormKey =  new GlobalKey<FormState>();
    productFormKey = new GlobalKey<FormState>();
    categoryFormKey = new GlobalKey<FormState>();
    addonFormKey = new GlobalKey<FormState>();
  }


  // ignore: missing_return
  Future<bool>  addEditCategory(paraType, id,context) async{

    if (categoryFormKey.currentState.validate()) {
      categoryFormKey.currentState.save();
      if(categoryData.uploadImage!=null) {
        Overlay.of(context).insert(loader);
        await repository.addCategory(categoryData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          PaintingBinding.instance.imageCache.clear();
          Helper.hideLoader(loader);
          listenForCategories();

          Navigator.pop(context);

          return true;
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }

  }


  void evictImage() {

  }


  Future<bool> addEditSubCategory(paraType, id, context) async {




    if (subcategoryFormKey.currentState.validate()) {
      subcategoryFormKey.currentState.save();

      if(subcategoryData.uploadImage!=null) {
        Overlay.of(context).insert(loader);

        await repository.addSubCategory(subcategoryData, paraType, id).then((value) {
          showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
          setState(() => subcategoryList.clear());
          listenForSubCategories();
          Navigator.pop(context);
        });
      } else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT, );
      }
    }

    return true;
  }

  calculateDiscount(){
     double strickPrice = double.parse(strickPriceController.text);
     print('distance${discountController.text}');
     double discount = double.parse(discountController.text);
     double discountAmount =  (strickPrice*discount)/100;
     double netAmount = strickPrice -  discountAmount;
     saleController.text = num.parse(netAmount.toStringAsFixed(setting.value.currencyDecimalDigits)).toString();
  }




  Future<void> listenForCategories() async {
    setState(() => categoryList.clear());
    final Stream<CategoryListModel> stream = await getCategory();
    stream.listen((CategoryListModel _category) {
      setState(() => categoryList.add(_category));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
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


  Future<void> listenForSubCategories() async {
    setState(() => subcategoryList.clear());

    final Stream<SubCategoryListModel> stream = await getSubCategory();
    stream.listen((SubCategoryListModel _category) {
      setState(() => subcategoryList.add(_category));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
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
      listenForProductsByCategory('Itemproduct');
    });
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

  Future<void> listenForNoDropdown(table, select) async {
    dropDownnoList.clear();
    final Stream<DropDownModel> stream = await getDropdownData(table, select,);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownnoList.add(_list));

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
  delete(table, id){
    if(table=='product'){
      listenForProductsByCategory('product');
    } else if(table=='Itemproduct'){
      listenForProductsByCategory('Itemproduct');
    }
    repository.globalDelete(table, id).then((value) {

      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
      if(table=='category') {
        listenForCategories();
      }else if(table=='subcategory'){
        listenForSubCategories();
      }
    });
  }


  deleteSearch(table, id, context, list){

    repository.globalDelete(table, id).then((value) {

      showToast("Delete Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }).catchError((e) {
      // loader.remove();
      // ignore: deprecated_member_use

    }).whenComplete(() {
      // Helper.hideLoader(loader);
      if(table=='category') {

        listenForCategories();
      }else if(table=='subcategory'){
        listenForSubCategories();
      }else if(table=='varient_2'){

      }


    });
  }

  addEditProduct(context){
    if (productFormKey.currentState.validate()) {
      productFormKey.currentState.save();
      if (productData.uploadImage != null) {
        Overlay.of(context).insert(loader);
        repository.productData(productData, 'add', currentUser.value.shopTypeId).then((value) {
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


  addEditProductItem(context){
    if (productFormKey.currentState.validate()) {
      productFormKey.currentState.save();
      if (productData.uploadImage != null) {
        Overlay.of(context).insert(loader);
        repository.productItemData(productData, 'add', currentUser.value.shopTypeId).then((value) {
          showToastPopup("Update Successfully", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use

        }).whenComplete(() {
          Helper.hideLoader(loader);
         VRouter.of(context).toNamed('itemlist');
        });
      }else {
        showToastPopup("Upload your image", context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    }
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

  productStatus(productId,status){
    showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      repository.updateProductStatus(productId,status).then((value) {

      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use

      });
  }


  todayDealStatus(productId,status,type){
    showToast("Update Successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    repository.updateTodaydeals(productId,status).then((value) {
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use

    });
  }

  void listenForProductsByCategory(listType) async {
    setState((){
      category_products.clear();
      productSearchList.clear();
    });
    final Stream<Product> stream = await getProducts(listType);
    stream.listen((Product _product) {
      setState(() {
        category_products.add(_product);
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

}