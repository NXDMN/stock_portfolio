import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:stock_portfolio/models/company_income_statement.dart';
import 'package:stock_portfolio/models/company_listing_status.dart';

class PortfolioService {
  //Put in your api key here
  static final _apiKey = "";

  static Future<dynamic> getCompanyListingStatus() async {
    try {
      String uri =
          'https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=${_apiKey}';

      var response;
      List<CompanyListingStatus> companyList = [];
      List<List<dynamic>> rowsAsListOfValues = [];

      var file = await DefaultCacheManager().getSingleFile(uri);
      if (await file.exists()) {
        response = await file.readAsString();
        rowsAsListOfValues =
            const CsvToListConverter().convert(response.toString());
      } else {
        response = await http.get(
          Uri.parse(uri),
        );

        rowsAsListOfValues =
            const CsvToListConverter().convert(response.body.toString());
      }

      for (int i = 1; i < rowsAsListOfValues.length; i++) {
        companyList.add(CompanyListingStatus(
            symbol: rowsAsListOfValues[i][0],
            name: rowsAsListOfValues[i][1],
            exchange: rowsAsListOfValues[i][2],
            assetType: rowsAsListOfValues[i][3],
            ipoDate: rowsAsListOfValues[i][4],
            delistingDate: rowsAsListOfValues[i][5],
            status: rowsAsListOfValues[i][6]));
      }

      return companyList;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<dynamic> getCompanyIncomeStatement(String symbol) async {
    try {
      String uri =
          'https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=${symbol}&apikey=${_apiKey}';

      var response;
      CompanyIncomeStatement incomeStatement;

      var file = await DefaultCacheManager().getSingleFile(uri);
      if (await file.exists()) {
        response = await file.readAsString();
        incomeStatement = CompanyIncomeStatement.fromJson(
            jsonDecode(response) as Map<String, dynamic>);
      } else {
        response = await http.get(
          Uri.parse(uri),
        );

        incomeStatement = CompanyIncomeStatement.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }

      return incomeStatement;
    } catch (e) {
      print(e.toString());
    }
  }
}
