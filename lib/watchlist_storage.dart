import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:stock_portfolio/models/company_listing_status.dart';

class WatchlistStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/watchlist4.json');
  }

  Future<dynamic> readWatchlist() async {
    try {
      final file = await _localFile;
      List<CompanyListingStatus> companyList = [];

      if (await file.exists()) {
        final contents = await file.readAsString();
        final jsonResponse = jsonDecode(contents);

        (jsonResponse as List).forEach((element) {
          companyList.add(CompanyListingStatus.fromJson(element));
        });
      }

      return companyList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> writeWatchlist(CompanyListingStatus company) async {
    final file = await _localFile;

    List<CompanyListingStatus> companyList = [];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);

      (jsonResponse as List).forEach((element) {
        companyList.add(CompanyListingStatus.fromJson(element));
      });
    }

    if (!await isInWatchlist(company)) {
      companyList.add(company);
      List<dynamic> jsonCompanyList = companyList
          .map(
            (e) => e.toJson(),
          )
          .toList();
      file.writeAsString(json.encode(jsonCompanyList));
    }
  }

  Future<void> removeFromWatchlist(CompanyListingStatus company) async {
    final file = await _localFile;

    List<CompanyListingStatus> companyList = [];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);

      (jsonResponse as List).forEach((element) {
        companyList.add(CompanyListingStatus.fromJson(element));
      });
    }

    companyList.removeWhere((element) => element.name.contains(company.name));
    List<dynamic> jsonCompanyList = companyList
        .map(
          (e) => e.toJson(),
        )
        .toList();
    file.writeAsString(json.encode(jsonCompanyList));
  }

  Future<bool> isInWatchlist(CompanyListingStatus company) async {
    final file = await _localFile;

    List<CompanyListingStatus> companyList = [];

    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonResponse = jsonDecode(contents);

      (jsonResponse as List).forEach((element) {
        companyList.add(CompanyListingStatus.fromJson(element));
      });
    }
    bool found = false;

    for (CompanyListingStatus element in companyList) {
      if (element.name.contains(company.name)) {
        found = true;
      }
    }
    return found;
  }
}
