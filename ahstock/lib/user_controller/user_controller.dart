
import 'package:stock_api/responses/profile_response.dart';


class UserController {
  UserController._privateConstructor();
  static final UserController userController =
      UserController._privateConstructor();
  // UserController._privateConstructor();

  factory UserController() {
    return userController;
  }

  var mainapplicationPath;
  var mainbaseUrl;
  var imagebasurl;
  String region = "";
  String appVersion = "";
  String userName = "";
  // String userShortName = "";
  String userId = "";
  bool userstat = false;
  // String usersubtype = "";
  // String tfa = "";
  // String password = "";
  String currentTheme = "";
  String usertoken = "";
  // bool itemedited = false;
  // bool itemadded = false;
  // bool itemquantityupdated = false;
  // bool itemreplaced = false;
  // bool orderstatusupdated = false;
  // bool orderstatusupdatedlistitem = true;
  // bool firsttime = true;
  // String devicetoken = "";
  // bool notified = false;
  // bool isgranted = false;
  // int selectedindex = 0;
  // int selectedprevselectindex = 0;
  // bool isloading = true;
  // bool scanselection = true;
  // List<CustomDetailsItem> customerslist = [];
  // List<ShippingAssignmentItem> shipitems = [];
  // List<Categories> categorylist = [];
  // List<Map<String, dynamic>> catlist = [];
  // List<OrderResponseItem> orderitem = [];
  // List<OrdersModel> postorderslist = [];
  // List<Sectionitem> sectionitems = [];
  // List<String> newaddeditemsku = [];
  // List<ItemSizeResponse> itemresplist = [];
  // List<ItemColorResponse> itemcolorresplist = [];
  // String locationlongitude = "51.50413815416897";
  // String locationlatitude = "25.22131574418503";
  // int dutyval = -1;
  // Duration? timeval = Duration(minutes: 30);
  // List<Driver> driverlist = [];
  // List<Driver> pickerlist = [];
  // List<OrderModelReport> searchreportbacks = [];
  // bool alloworderRequest = true;
  // NewOrderResponse? newOrderResponse;
  // List<int> itemcancellist = [];
  // List<int> itempicklist = [];
  // List<String> lpklist = [];
  // List<Map<String, dynamic>> quantityupdatelist = [];
  // List<NewOrderResponseItem> orderslist = [];
  // List<NewOrderResponseItem> mainlist = [];
  // List<NewOrdersModel> modellist = [];
  // DateTime grocday = DateTime.now();
  // List<int> indexlist = [];
  // List<Map<String, dynamic>> distancemap = [];

  ProfileResponce profileResponce = ProfileResponce(success: 0, user: [
    User(
        id: "",
        empId: "",
        name: "",
        status: "",
        approveStatus: "",
        email: "",
        mobileNumber: "",
        vehicleNumber: "",
        availabilityStatus: "",
        vehicleType: "",
        password: "",
        address: "",
        role: "",
        regularShiftTime: "",
        fridayShiftTime: "",
        offDay: "",
        latitude: "",
        longitude: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        rpToken: "",
        rpTokenCreatedAt: DateTime.now())
  ]);

  dispose() {
    // userName = "";
    // userShortName = "";
    // userId = "";
    // usersubtype = "";
    // tfa = "";
    // password = "";
    // currentTheme = "";
    // usertoken = "";
  }
}
