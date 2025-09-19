class Subscription {
  int? id;
  int? userId;
  Data? data;
  String? type;
  String? startAt;
  String? endAt;
  List<String>? weekday;
  String? scheduleTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Subscription(
      {this.id,
        this.userId,
        this.data,
        this.type,
        this.startAt,
        this.endAt,
        this.weekday,
        this.scheduleTime,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.product});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    type = json['type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    weekday = json['weekday'].cast<String>();
    scheduleTime = json['schedule_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = this.type;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['weekday'] = this.weekday;
    data['schedule_time'] = this.scheduleTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Data {
  List<Cart>? cart;
  int? couponDiscountAmount;
  int? orderAmount;
  String? orderType;
  String? paymentMethod;
  int? storeId;
  double? distance;
  int? discountAmount;
  int? taxAmount;
  String? address;
  double? latitude;
  double? longitude;
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressType;
  Null? road;
  Null? house;
  Null? floor;
  int? dmTips;
  Null? unavailableItemNote;
  Null? deliveryInstruction;
  int? cutlery;
  int? partialPayment;
  int? isBuyNow;
  int? extraPackagingAmount;
  int? createNewUser;
  Null? password;
  bool? isPrescription;
  bool? isSubscription;
  SubscriptionData? subscriptionData;
  Null? subscriptionType;
  User? user;

  Data(
      {this.cart,
        this.couponDiscountAmount,
        this.orderAmount,
        this.orderType,
        this.paymentMethod,
        this.storeId,
        this.distance,
        this.discountAmount,
        this.taxAmount,
        this.address,
        this.latitude,
        this.longitude,
        this.contactPersonName,
        this.contactPersonNumber,
        this.addressType,
        this.road,
        this.house,
        this.floor,
        this.dmTips,
        this.unavailableItemNote,
        this.deliveryInstruction,
        this.cutlery,
        this.partialPayment,
        this.isBuyNow,
        this.extraPackagingAmount,
        this.createNewUser,
        this.password,
        this.isPrescription,
        this.isSubscription,
        this.subscriptionData,
        this.subscriptionType,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    couponDiscountAmount = json['coupon_discount_amount'];
    orderAmount = json['order_amount'];
    orderType = json['order_type'];
    paymentMethod = json['payment_method'];
    storeId = json['store_id'];
    distance = json['distance'];
    discountAmount = json['discount_amount'];
    taxAmount = json['tax_amount'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressType = json['address_type'];
    road = json['road'];
    house = json['house'];
    floor = json['floor'];
    dmTips = json['dm_tips'];
    unavailableItemNote = json['unavailable_item_note'];
    deliveryInstruction = json['delivery_instruction'];
    cutlery = json['cutlery'];
    partialPayment = json['partial_payment'];
    isBuyNow = json['is_buy_now'];
    extraPackagingAmount = json['extra_packaging_amount'];
    createNewUser = json['create_new_user'];
    password = json['password'];
    isPrescription = json['is_prescription'];
    isSubscription = json['is_subscription'];
    subscriptionData = json['subscription_data'] != null
        ? new SubscriptionData.fromJson(json['subscription_data'])
        : null;
    subscriptionType = json['subscriptionType'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['order_amount'] = this.orderAmount;
    data['order_type'] = this.orderType;
    data['payment_method'] = this.paymentMethod;
    data['store_id'] = this.storeId;
    data['distance'] = this.distance;
    data['discount_amount'] = this.discountAmount;
    data['tax_amount'] = this.taxAmount;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address_type'] = this.addressType;
    data['road'] = this.road;
    data['house'] = this.house;
    data['floor'] = this.floor;
    data['dm_tips'] = this.dmTips;
    data['unavailable_item_note'] = this.unavailableItemNote;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['cutlery'] = this.cutlery;
    data['partial_payment'] = this.partialPayment;
    data['is_buy_now'] = this.isBuyNow;
    data['extra_packaging_amount'] = this.extraPackagingAmount;
    data['create_new_user'] = this.createNewUser;
    data['password'] = this.password;
    data['is_prescription'] = this.isPrescription;
    data['is_subscription'] = this.isSubscription;
    if (this.subscriptionData != null) {
      data['subscription_data'] = this.subscriptionData!.toJson();
    }
    data['subscriptionType'] = this.subscriptionType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Cart {
  int? itemId;
  int? cartId;
  Null? itemCampaignId;
  String? price;
  String? variant;
  List<Null>? variation;
  int? quantity;
  List<Null>? addOnIds;
  List<Null>? addOns;
  List<Null>? addOnQtys;
  String? model;
  String? itemType;

  Cart(
      {this.itemId,
        this.cartId,
        this.itemCampaignId,
        this.price,
        this.variant,
        this.variation,
        this.quantity,
        this.addOnIds,
        this.addOns,
        this.addOnQtys,
        this.model,
        this.itemType});

  Cart.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    cartId = json['cart_id'];
    itemCampaignId = json['item_campaign_id'];
    price = json['price'];
    variant = json['variant'];

    quantity = json['quantity'];



    model = json['model'];
    itemType = json['item_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['cart_id'] = this.cartId;
    data['item_campaign_id'] = this.itemCampaignId;
    data['price'] = this.price;
    data['variant'] = this.variant;

    data['model'] = this.model;
    data['item_type'] = this.itemType;
    return data;
  }
}

class SubscriptionData {
  String? type;
  String? startDate;
  String? endDate;
  List<String>? selectedDays;
  Null? pauseDate;
  Null? pauseDay;
  String? scheduleTime;

  SubscriptionData(
      {this.type,
        this.startDate,
        this.endDate,
        this.selectedDays,
        this.pauseDate,
        this.pauseDay,
        this.scheduleTime});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    selectedDays = json['selected_days'].cast<String>();
    pauseDate = json['pause_date'];
    pauseDay = json['pause_day'];
    scheduleTime = json['schedule_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['selected_days'] = this.selectedDays;
    data['pause_date'] = this.pauseDate;
    data['pause_day'] = this.pauseDay;
    data['schedule_time'] = this.scheduleTime;
    return data;
  }
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  Null? image;
  int? isPhoneVerified;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? cmFirebaseToken;
  int? status;
  int? orderCount;
  Null? loginMedium;
  Null? socialId;
  int? zoneId;
  int? walletBalance;
  int? loyaltyPoint;
  String? refCode;
  String? currentLanguageKey;
  Null? refBy;
  Null? tempToken;
  Null? moduleIds;
  int? isEmailVerified;
  int? isFromPos;
  Null? imageFullUrl;
  List<Null>? storage;

  User(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.isPhoneVerified,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.cmFirebaseToken,
        this.status,
        this.orderCount,
        this.loginMedium,
        this.socialId,
        this.zoneId,
        this.walletBalance,
        this.loyaltyPoint,
        this.refCode,
        this.currentLanguageKey,
        this.refBy,
        this.tempToken,
        this.moduleIds,
        this.isEmailVerified,
        this.isFromPos,
        this.imageFullUrl,
        this.storage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cmFirebaseToken = json['cm_firebase_token'];
    status = json['status'];
    orderCount = json['order_count'];
    socialId = json['social_id'];
    zoneId = json['zone_id'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    refCode = json['ref_code'];
    currentLanguageKey = json['current_language_key'];
    refBy = json['ref_by'];
    tempToken = json['temp_token'];
    moduleIds = json['module_ids'];
    isEmailVerified = json['is_email_verified'];
    isFromPos = json['is_from_pos'];
    imageFullUrl = json['image_full_url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['status'] = this.status;
    data['order_count'] = this.orderCount;
    data['login_medium'] = this.loginMedium;
    data['social_id'] = this.socialId;
    data['zone_id'] = this.zoneId;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['ref_code'] = this.refCode;
    data['current_language_key'] = this.currentLanguageKey;
    data['ref_by'] = this.refBy;
    data['temp_token'] = this.tempToken;
    data['module_ids'] = this.moduleIds;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_from_pos'] = this.isFromPos;
    data['image_full_url'] = this.imageFullUrl;

    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? image;
  int? categoryId;
  String? categoryIds;
  String? variations;
  String? addOns;
  String? attributes;
  String? choiceOptions;
  int? price;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? veg;
  int? status;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  int? avgRating;
  int? ratingCount;
  Null? rating;
  int? moduleId;
  int? stock;
  int? unitId;
  List<Images>? images;
  String? foodVariations;
  String? slug;
  int? recommended;
  int? organic;
  Null? maximumCartQuantity;
  int? isApproved;
  int? isHalal;
  String? unitType;
  String? imageFullUrl;
  List<String>? imagesFullUrl;
  List<Translations>? translations;
  List<Storage>? storage;
  Unit? unit;

  Product(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.categoryId,
        this.categoryIds,
        this.variations,
        this.addOns,
        this.attributes,
        this.choiceOptions,
        this.price,
        this.tax,
        this.taxType,
        this.discount,
        this.discountType,
        this.availableTimeStarts,
        this.availableTimeEnds,
        this.veg,
        this.status,
        this.storeId,
        this.createdAt,
        this.updatedAt,
        this.orderCount,
        this.avgRating,
        this.ratingCount,
        this.rating,
        this.moduleId,
        this.stock,
        this.unitId,
        this.images,
        this.foodVariations,
        this.slug,
        this.recommended,
        this.organic,
        this.maximumCartQuantity,
        this.isApproved,
        this.isHalal,
        this.unitType,
        this.imageFullUrl,
        this.imagesFullUrl,
        this.translations,
        this.storage,
        this.unit});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    categoryIds = json['category_ids'];
    variations = json['variations'];
    addOns = json['add_ons'];
    attributes = json['attributes'];
    choiceOptions = json['choice_options'];
    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    veg = json['veg'];
    status = json['status'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    moduleId = json['module_id'];
    stock = json['stock'];
    unitId = json['unit_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    foodVariations = json['food_variations'];
    slug = json['slug'];
    recommended = json['recommended'];
    organic = json['organic'];
    isApproved = json['is_approved'];
    isHalal = json['is_halal'];
    unitType = json['unit_type'];
    imageFullUrl = json['image_full_url'];
    imagesFullUrl = json['images_full_url'].cast<String>();
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
    if (json['storage'] != null) {
      storage = <Storage>[];
      json['storage'].forEach((v) {
        storage!.add(new Storage.fromJson(v));
      });
    }
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['category_ids'] = this.categoryIds;
    data['variations'] = this.variations;
    data['add_ons'] = this.addOns;
    data['attributes'] = this.attributes;
    data['choice_options'] = this.choiceOptions;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['veg'] = this.veg;
    data['status'] = this.status;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_count'] = this.orderCount;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['rating'] = this.rating;
    data['module_id'] = this.moduleId;
    data['stock'] = this.stock;
    data['unit_id'] = this.unitId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['food_variations'] = this.foodVariations;
    data['slug'] = this.slug;
    data['recommended'] = this.recommended;
    data['organic'] = this.organic;
    data['maximum_cart_quantity'] = this.maximumCartQuantity;
    data['is_approved'] = this.isApproved;
    data['is_halal'] = this.isHalal;
    data['unit_type'] = this.unitType;
    data['image_full_url'] = this.imageFullUrl;
    data['images_full_url'] = this.imagesFullUrl;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    if (this.storage != null) {
      data['storage'] = this.storage!.map((v) => v.toJson()).toList();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    return data;
  }
}

class Images {
  String? img;
  String? storage;

  Images({this.img, this.storage});

  Images.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    storage = json['storage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['storage'] = this.storage;
    return data;
  }
}

class Translations {
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  Null? createdAt;
  Null? updatedAt;

  Translations(
      {this.id,
        this.translationableType,
        this.translationableId,
        this.locale,
        this.key,
        this.value,
        this.createdAt,
        this.updatedAt});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translationableType = json['translationable_type'];
    translationableId = json['translationable_id'];
    locale = json['locale'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['translationable_type'] = this.translationableType;
    data['translationable_id'] = this.translationableId;
    data['locale'] = this.locale;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Storage {
  int? id;
  String? dataType;
  String? dataId;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Storage(
      {this.id,
        this.dataType,
        this.dataId,
        this.key,
        this.value,
        this.createdAt,
        this.updatedAt});

  Storage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataType = json['data_type'];
    dataId = json['data_id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['data_id'] = this.dataId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Unit {
  int? id;
  String? unit;
  String? createdAt;
  String? updatedAt;
  List<Translations>? translations;

  Unit({this.id, this.unit, this.createdAt, this.updatedAt, this.translations});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit = json['unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
