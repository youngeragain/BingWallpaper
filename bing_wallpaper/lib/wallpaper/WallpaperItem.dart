abstract class WallpaperItem {
  abstract String? startdate;
  abstract String? enddate;
  abstract String? title;
  abstract String? url;
  abstract String? copyright;
  abstract String? quiz;

  String getFullUrl();
}
