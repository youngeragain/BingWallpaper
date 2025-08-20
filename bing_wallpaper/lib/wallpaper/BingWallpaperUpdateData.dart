
import 'BingWallpaperSource.dart';
import 'WallpaperItem.dart';
import 'WallpaperSourceData.dart';

class BingWallpaperUpdateData extends WallpaperSourceData<UpdateImageData> {
  BingWallpaperUpdateData({List<UpdateImageData>? images, Tooltips? tooltips}) {
    _images = images;
    _tooltips = tooltips;
  }

  BingWallpaperUpdateData.fromJson(dynamic json) {
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(UpdateImageData.fromJson(v));
      });
    }
    _tooltips = json['tooltips'] != null
        ? Tooltips.fromJson(json['tooltips'])
        : null;
  }

  List<UpdateImageData>? _images;
  Tooltips? _tooltips;

  BingWallpaperUpdateData copyWith({List<UpdateImageData>? images, Tooltips? tooltips}) =>
      BingWallpaperUpdateData(
        images: images ?? _images,
        tooltips: tooltips ?? _tooltips,
      );

  List<UpdateImageData>? get images => _images;

  Tooltips? get tooltips => _tooltips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_tooltips != null) {
      map['tooltips'] = _tooltips?.toJson();
    }
    return map;
  }

  @override
  List<UpdateImageData>? items() {
    return images;
  }

  @override
  int getItemIndex(UpdateImageData? item) {
    if (item == null) {
      return -1;
    }
    return images?.indexOf(item) ?? -1;
  }

  @override
  UpdateImageData? getItemByIndex(int index) {
    var temp = images;
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

class Tooltips {
  Tooltips({
    String? loading,
    String? previous,
    String? next,
    String? walle,
    String? walls,
  }) {
    _loading = loading;
    _previous = previous;
    _next = next;
    _walle = walle;
    _walls = walls;
  }

  Tooltips.fromJson(dynamic json) {
    _loading = json['loading'];
    _previous = json['previous'];
    _next = json['next'];
    _walle = json['walle'];
    _walls = json['walls'];
  }

  String? _loading;
  String? _previous;
  String? _next;
  String? _walle;
  String? _walls;

  Tooltips copyWith({
    String? loading,
    String? previous,
    String? next,
    String? walle,
    String? walls,
  }) => Tooltips(
    loading: loading ?? _loading,
    previous: previous ?? _previous,
    next: next ?? _next,
    walle: walle ?? _walle,
    walls: walls ?? _walls,
  );

  String? get loading => _loading;

  String? get previous => _previous;

  String? get next => _next;

  String? get walle => _walle;

  String? get walls => _walls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loading'] = _loading;
    map['previous'] = _previous;
    map['next'] = _next;
    map['walle'] = _walle;
    map['walls'] = _walls;
    return map;
  }
}

class UpdateImageData implements WallpaperItem {
  UpdateImageData({
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

  UpdateImageData.fromJson(dynamic json) {
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

  UpdateImageData copyWith({
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
  }) => UpdateImageData(
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
