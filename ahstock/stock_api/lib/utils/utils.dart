import 'dart:developer';

import 'package:flutter/foundation.dart';

const int VENUE_CASH = 0;
const int VENUE_FO = 1;
const int VENUE_CD = 2;
const int VENUE_COM = 3; // Commodity
const int VENUE_MF = 4;
const int VENUE_DEBT = 5;
const int TYPE_EQUITY = 1;
const int TYPE_OPTSTK = 2;
const int TYPE_OPTIDX = 3;
const int TYPE_FUTSTK = 4;
const int TYPE_FUTIDX = 5;
const int TYPE_FUTCUR = 6;
const int TYPE_FUTIRD = 7;
const int TYPE_FUTCOM = 8;
const int TYPE_OPTCUR = 9;
const int TYPE_MF = 10;
const int TYPE_FUTIVX = 11;
const int TYPE_FUTIRC = 13; // NEWLY Adedd by 11/03/15
const int TYPE_MARKET_INDEX = 15;
const int TYPE_COMDTY = 16;
const int TYPE_OPTFUT = 17;
const int TYPE_OPTCOM = 18;

const int BUY = 1;
const int SELL = 2;
const int CANCEL = 3;

const String STORAGENAME = "FlipBio";

const List<int> VENUE_TYPES = [
  VENUE_CASH,
  VENUE_CASH,
  VENUE_FO,
  VENUE_CD,
  VENUE_FO,
  VENUE_COM,
  VENUE_COM,
  VENUE_COM,
  VENUE_COM,
  VENUE_MF,
  VENUE_CD,
  VENUE_CASH,
  VENUE_FO,
  VENUE_CASH,
  VENUE_DEBT,
  VENUE_CD,
  VENUE_MF
];

Map<int, String> VENUE_MAP = {
  2: "BSE",
  15: "BSECD",
  18: "BSECOM",
  11: "BSEFO",
  16: "BSEMFD",
  19: "ICEX",
  6: "MCX",
  8: "MCXSX",
  12: "MCXSXCM",
  13: "MCXSXFO",
  5: "NCDEX",
  4: "NMCE",
  1: "NSE",
  7: "NSECD",
  17: "NSECOM",
  14: "NSEDEBT",
  3: "NSEFO",
  9: "NSEMF",
};

const List<int> VENUE_INDEX = [
  2,
  15,
  18,
  11,
  16,
  19,
  6,
  8,
  12,
  13,
  5,
  4,
  1,
  7,
  17,
  14,
  3,
  9,
];
const List<String> VENUE_CODE = [
  "BSE",
  "BSECD",
  "BSECOM",
  "BSEFO",
  "BSEMFD",
  "ICEX",
  "MCX",
  "MCXSX",
  "MCXSXCM",
  "MCXSXFO",
  "NCDEX",
  "NMCE",
  "NSE",
  "NSECD",
  "NSECOM",
  "NSEDEBT",
  "NSEFO",
  "NSEMF",
];

// const List<String> VENUES = ["NSE", "BSE", "NSEFO", "NSECD",
// "BSEFO", "NMCE", "NCDEX", "MCX", "DGCX", "NSEMF", "MCXSX",
// "MCXSXCM", "MCXSXFO", "MSM", "NSEDEBT", "NSECOM"];

// const List<String> VENUE_CODES = ["1", "2", "3", "7", "11", "4",
// "5", "6", "30", "9", "8", "12", "13", "20", "14", "17"];

int getVenueIndex(String venueCode) {
  if (VENUE_CODE.contains(venueCode)) {
    return VENUE_INDEX[VENUE_CODE.indexOf(venueCode)];
  }
  return 0;
}

String getVenueCode(int venueIndex) {
  if (VENUE_INDEX.contains(venueIndex)) {
    return VENUE_CODE[VENUE_INDEX.indexOf(venueIndex)];
  }
  return "INDEX";
}

int getPrecision(int venueIndex) {
  return venueIndex == 7 ? 4 : 2;
}

List<String> symbolkeys = [
  "AMCCODE",
  "CALLPUT",
  "CATEGORYCODE",
  "EXPIRATIONDATE",
  "INSTRUMENTTYPE",
  "ISIN",
  "MARKETLOT",
  "MINSUBSCRADDL",
  "MINSUBSCRFRESH",
  "MISC9",
  "SECURITYCODE",
  "SERIES",
  "STRIKEPRICE",
  "SYMBOLNAME",
  "UNDERLYINGSCRIPCODE",
  "VENUECODE",
  "VENUESCRIPCODE",
  "MISC1",
  "MISC3",
  "MISC4",
  "MISC5",
  "FREQAMOUNT",
  "NAV",
  "NAVDATE",
  "REMARKS",
  "OTHERSCRIPCODE",
  "OTHERSERIES"
];
List<bool> VENUE_IN_QTY = [
  true,
  true,
  true,
  false,
  true,
  false,
  true,
  false,
  true,
  true,
  false,
  true,
  true,
  true,
  true,
  false,
  true,
  false,
  false
];
List<String> VENUES_ORDER = [
  "NSE",
  "BSE",
  "NSEFO",
  "NSECD",
  "BSEFO",
  "ICEX",
  "NCDEX",
  "MCX",
  "DGCX",
  "NSEMF",
  "MCXSX",
  "MCXSXCM",
  "MCXSXFO",
  "MSM",
  "NSEDEBT",
  "BSECD",
  "BSEMFD"
];

Map<int, List<Map<String, dynamic>>> PRODUCT_TYPES_DISPLAY = {
  1: [
    {
      "name": "Cash",
      "description": "For delivery-based equity trades.",
    },
    {
      "name": "Intraday",
      "description":
          "For intraday trades in equity (with leverage).(Auto square off @ 3:15 p.m.)",
    },
    {
      "name": "BTST",
      "description": "For delivery-based equity trades (with leverage).",
    },
    {
      "name": "MTF",
      "description":
          "For delivery-based equity trades (with leverage for up to 365 days).",
    },
  ],
  2: [
    {
      "name": "Cash",
      "description": "For delivery-based equity trades.",
    },
    {
      "name": "Intraday",
      "description":
          "For intraday trades in equity (with leverage).(Auto square off @ 3:15 p.m.)",
    },
  ],
  3: [
    {
      "name": "Cash",
      "description": "For overnight F&O trades.",
    },
    {
      "name": "Intraday",
      "description": "For intraday trades in F&O.(Auto square off @ 3:15 p.m.)",
    },
  ],
  6: [
    {
      "name": "Cash",
      "description": "For overnight F&O trades.",
    },
    {
      "name": "Intraday",
      "description": "For intraday trades in F&O.(Auto square off @ 3:15 p.m.)",
    },
  ],
  5: [
    {
      "name": "Cash",
      "description": "For overnight F&O trades.",
    },
    {
      "name": "Intraday",
      "description": "For intraday trades in F&O.(Auto square off @ 3:15 p.m.)",
    },
  ],
  7: [
    {
      "name": "Cash",
      "description": "For overnight F&O trades.",
    },
  ],
};
Map<int, List<Map<String, dynamic>>> PRODUCT_TYPES = {
  1: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "Intraday",
      "description": "Buy and Sellstocks on the same day",
    },
    {
      "name": "BTST",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "MTF",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
  ],
  2: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "Intraday",
      "description": "Buy and Sellstocks on the same day",
    },
  ],
  3: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "FAO_INTRADAY",
      "description": "Buy and Sellstocks on the same day",
    },
  ],
  7: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
  ],
  6: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "COMMINTRADAY",
      "description": "Buy and Sellstocks on the same day",
    },
  ],
  5: [
    {
      "name": "Cash",
      "description": "Lorem ipsum dolor sit amet, consectetur",
    },
    {
      "name": "COMMINTRADAY",
      "description": "Buy and Sellstocks on the same day",
    },
  ],
};

List<Map<String, dynamic>> ocoPriceConditionChart = [
  {
    "name": "Market",
    "description":
        "A market order is sent to the exchange when the trigger price is hit",
  },
  {
    "name": "Limit",
    "description":
        "A limit order is sent to the exchange when the trigger price is hit"
  },
  // {
  //   "name": "STL",
  //   "description": "Stop Loss Limit",
  // },
  // {
  //   "name": "STLM",
  //   "description": "Stop Loss Market",
  // },
];

List<Map<String, dynamic>> ocoProductTypeChart = [
  {
    "name": "Cash",
    "description": "For delivery-based equity trades",
  },
];

int timeconditionDispkaylistindex(String timeC) {
  switch (timeC) {
    case "Day":
      return 0;
    case "IOC":
      return 1;
    case "Conditional": //"Conditional"
      return 2;
    case "GTD":
      return 2; //3
    default:
      return 0;
  }
}

int getProductTypeId(String product) {
  switch (product.toUpperCase()) {
    case "CASH":
    case "FAO":
    case "COMMODITY":
      return 1;
    case "INTRADAY":
      return 2;
    case "BTST":
      return 5;
    case "COMMINTRADAY":
      return 10;
    case "FAO_INTRADAY":
    case "FAOINTRADAY":
      return 8;
    case "MTF":
      return 6;
    case "FOFUTURRES":
      return 11;
    case "FOOPTIONS":
      return 12;
    case "CDFUTURES":
      return 13;
    case "CDOPTIONS":
      return 14;
    case "SMARTPLUS":
      return 15;
    case "CO":
      return 22;
    case "BO":
      return 17;
    case "TSL":
      return 38;
    case "SMARTFOLIO":
      return 24;

    default:
      return 0;
  }
}

String getProductDisplayType(int product) {
  switch (product) {
    case 1:
      return "Cash";
    case 2:
      return "Intraday";
    case 5:
      return "BTST";
    case 10:
      return "COMMINTRADAY";
    case 8:
      return "FAO_INTRADAY";
    case 6:
      return "MTF";
    case 11:
      return "FOFutures";
    // case 12:
    //   return "FOOptions";
    // case "CDFutures":
    //   return 13;
    // case "CDOptions":
    //   return 14;
    // case "SmartPlus":
    //   return 15;
    // case "CO":
    //   return 22;
    case 17:
      return "Intraday";
    // case "TSL":
    //   return 38;
    // case "SMARTFOLIO":
    //   return 24;

    default:
      return "Cash";
  }
}

String getOrderPriceCondition(String product) {
  switch (product) {
    case "MKT":
      return "Market";
    case "LMT":
      return "Limit";
    case "STL":
      return "Stop Loss Limit";
    case "STLM":
      return "Stop Loss Market";

    default:
      return "";
  }
}

int getProductListIndex(String product, int venueindex) {
  for (int i = 0; i < PRODUCT_TYPES[venueindex]!.length; i++) {
    if (PRODUCT_TYPES[venueindex]![i]["name"].toString().toUpperCase() ==
        product.toUpperCase()) {
      return i;
    }
  }
  return -1;
}

String getsentiments(int value) {
  switch (value) {
    case 0:
      return "NUETRAL";
    case 1:
      return "POSITIVE";
    default:
      return "NEGATIVE";
  }
}

String getInstrumentTypeasString(int iType) {
  switch (iType) {
    case TYPE_EQUITY:
      return "CM";
    default:
      return "FUTSTK";
  }
}

int getPriceCondition(String pCondition) {
  switch (pCondition) {
    case "Market":
      return 1;
    case "Limit":
      return 2;
    case "Stop Loss Limit":
      return 3;
    case "Stop Loss Market":
      return 4;
    default:
      return 0;
  }
}

String getPriceConditionbyId(int pCondition) {
  switch (pCondition) {
    case 1:
      return "Market";
    case 2:
      return "Limit";
    case 3:
      return "Stop Loss Limit";
    case 4:
      return "Stop Loss Market";
    default:
      return "";
  }
}

String changeDateFormat(String date) {
  if (date.contains("/")) {
    List<String> dates = date.split("/");
    return "${dates.elementAt(2)}-${dates.elementAt(1)}-${dates.elementAt(0)}";
  }
  return "";
}

bool validateticksize(double val, double ticksize) {
  int aa = (val * 10000).toInt();
  int bb = (ticksize * 10000).toInt();
  return bb != 0 && aa % bb == 0;
}

serviceSend(String name) {
  if (kDebugMode) {
    log("ServiceSend $name");
  }
}

serviceSendError(String name) {
  if (kDebugMode) {
    log("ServiceSendError $name", error: "name");
  }
}

doDateConversion(String contractDate) {
  //01072022--input
  //2022-07-01--output
  if (contractDate.isEmpty) {
    return "";
  }
  if (contractDate == "00:00:00") {
    return "";
  }
  return "${contractDate.substring(4, 8)}-${contractDate.substring(2, 4)}-${contractDate.substring(0, 2)}";
}

String ocoPricecondition(int pCondition) {
  switch (pCondition) {
    case 1:
      return "Market";
    case 2:
      return "Limit";
    case 3:
      return "SL-Lmt";
    case 4:
      return "SL-Mk";
    default:
      return "";
  }
}
