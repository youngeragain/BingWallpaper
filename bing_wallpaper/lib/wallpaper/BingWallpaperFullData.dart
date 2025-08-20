import 'BingWallpaperSource.dart';
import 'WallpaperItem.dart';
import 'WallpaperSourceData.dart';

class BingWallpaperFullData extends WallpaperSourceData<FullImageData> {
  BingWallpaperFullData({
    String? lastUpdate,
    num? total,
    String? language,
    String? message,
    bool? status,
    bool? success,
    String? info,
    List<FullImageData>? data,
  }) {
    _lastUpdate = lastUpdate;
    _total = total;
    _language = language;
    _message = message;
    _status = status;
    _success = success;
    _info = info;
    _data = data;
  }

  BingWallpaperFullData.fromJson(dynamic json) {
    _lastUpdate = json['LastUpdate'];
    _total = json['Total'];
    _language = json['Language'];
    _message = json['message'];
    _status = json['status'];
    _success = json['success'];
    _info = json['info'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FullImageData.fromJson(v));
      });
    }
  }

  String? _lastUpdate;
  num? _total;
  String? _language;
  String? _message;
  bool? _status;
  bool? _success;
  String? _info;
  List<FullImageData>? _data;

  BingWallpaperFullData copyWith({
    String? lastUpdate,
    num? total,
    String? language,
    String? message,
    bool? status,
    bool? success,
    String? info,
    List<FullImageData>? data,
  }) => BingWallpaperFullData(
    lastUpdate: lastUpdate ?? _lastUpdate,
    total: total ?? _total,
    language: language ?? _language,
    message: message ?? _message,
    status: status ?? _status,
    success: success ?? _success,
    info: info ?? _info,
    data: data ?? _data,
  );

  String? get lastUpdate => _lastUpdate;

  num? get total => _total;

  String? get language => _language;

  String? get message => _message;

  bool? get status => _status;

  bool? get success => _success;

  String? get info => _info;

  List<FullImageData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LastUpdate'] = _lastUpdate;
    map['Total'] = _total;
    map['Language'] = _language;
    map['message'] = _message;
    map['status'] = _status;
    map['success'] = _success;
    map['info'] = _info;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<FullImageData>? items() {
    return data;
  }

  @override
  int getItemIndex(FullImageData? item) {
    if (item == null) {
      return -1;
    }
    return data?.indexOf(item) ?? -1;
  }

  @override
  FullImageData? getItemByIndex(int index) {
    var temp = data;
    if (temp == null) {
      return null;
    }
    for (var i = 0; i < temp.length; i++) {
      if (i == index) {
        return temp[i];
      }
    }
    return null;
  }
}

class FullImageData implements WallpaperItem {
  FullImageData({
    String? startdate,
    String? fullstartdate,
    String? enddate,
    String? url,
    String? urlbase,
    String? copyright,
    String? copyrightlink,
    String? title,
    String? quiz,
    bool? wp,
    String? hsh,
    num? drk,
    num? top,
    num? bot,
    List<String>? hs,
  }) {
    _startdate = startdate;
    _fullstartdate = fullstartdate;
    _enddate = enddate;
    _url = url;
    _urlbase = urlbase;
    _copyright = copyright;
    _copyrightlink = copyrightlink;
    _title = title;
    _quiz = quiz;
    _wp = wp;
    _hsh = hsh;
    _drk = drk;
    _top = top;
    _bot = bot;
    _hs = hs;
  }

  FullImageData.fromJson(dynamic json) {
    _startdate = json['startdate'];
    _fullstartdate = json['fullstartdate'];
    _enddate = json['enddate'];
    _url = json['url'];
    _urlbase = json['urlbase'];
    _copyright = json['copyright'];
    _copyrightlink = json['copyrightlink'];
    _title = json['title'];
    _quiz = json['quiz'];
    _wp = json['wp'];
    _hsh = json['hsh'];
    _drk = json['drk'];
    _top = json['top'];
    _bot = json['bot'];
    if (json['hs'] != null) {
      _hs = [];
      json['hs'].forEach((v) {
        _hs?.add(v);
      });
    }
  }

  String? _startdate;
  String? _fullstartdate;
  String? _enddate;
  String? _url;
  String? _urlbase;
  String? _copyright;
  String? _copyrightlink;
  String? _title;
  String? _quiz;
  bool? _wp;
  String? _hsh;
  num? _drk;
  num? _top;
  num? _bot;
  List<String>? _hs;

  FullImageData copyWith({
    String? startdate,
    String? fullstartdate,
    String? enddate,
    String? url,
    String? urlbase,
    String? copyright,
    String? copyrightlink,
    String? title,
    String? quiz,
    bool? wp,
    String? hsh,
    num? drk,
    num? top,
    num? bot,
    List<String>? hs,
  }) => FullImageData(
    startdate: startdate ?? _startdate,
    fullstartdate: fullstartdate ?? _fullstartdate,
    enddate: enddate ?? _enddate,
    url: url ?? _url,
    urlbase: urlbase ?? _urlbase,
    copyright: copyright ?? _copyright,
    copyrightlink: copyrightlink ?? _copyrightlink,
    title: title ?? _title,
    quiz: quiz ?? _quiz,
    wp: wp ?? _wp,
    hsh: hsh ?? _hsh,
    drk: drk ?? _drk,
    top: top ?? _top,
    bot: bot ?? _bot,
    hs: hs ?? _hs,
  );

  @override
  String? get startdate => _startdate;

  @override
  set startdate(String? startdate) {
    _startdate = startdate;
  }

  String? get fullstartdate => _fullstartdate;

  @override
  String? get enddate => _enddate;

  @override
  set enddate(String? enddate) {
    _enddate = enddate;
  }

  @override
  String? get url => _url;

  @override
  set url(String? url) {
    _url = url;
  }

  String? get urlbase => _urlbase;

  @override
  String? get copyright => _copyright;

  @override
  set copyright(String? copyright) {
    _copyright = copyright;
  }

  String? get copyrightlink => _copyrightlink;

  @override
  String? get title => _title;

  @override
  set title(String? title) {
    _title = title;
  }

  @override
  String? get quiz => _quiz;

  @override
  set quiz(String? quiz) {
    _quiz = quiz;
  }

  bool? get wp => _wp;

  String? get hsh => _hsh;

  num? get drk => _drk;

  num? get top => _top;

  num? get bot => _bot;

  List<dynamic>? get hs => _hs;

  @override
  String getFullUrl() {
    return BingWallpaperSource.buildFullUrl(url);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startdate'] = _startdate;
    map['fullstartdate'] = _fullstartdate;
    map['enddate'] = _enddate;
    map['url'] = _url;
    map['urlbase'] = _urlbase;
    map['copyright'] = _copyright;
    map['copyrightlink'] = _copyrightlink;
    map['title'] = _title;
    map['quiz'] = _quiz;
    map['wp'] = _wp;
    map['hsh'] = _hsh;
    map['drk'] = _drk;
    map['top'] = _top;
    map['bot'] = _bot;
    if (_hs != null) {
      map['hs'] = _hs?.map((v) => v).toList();
    }
    return map;
  }
}
