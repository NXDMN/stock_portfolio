import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:stock_portfolio/models/company_income_statement.dart';
import 'package:stock_portfolio/models/company_listing_status.dart';
import 'package:stock_portfolio/portfolio_service.dart';
import 'package:stock_portfolio/screens/favorite_screen.dart';
import 'package:stock_portfolio/watchlist_storage.dart';

class CompanyPortfolioScreen extends StatefulWidget {
  final CompanyListingStatus company;

  CompanyPortfolioScreen({required this.company});

  @override
  State<CompanyPortfolioScreen> createState() => _CompanyPortfolioScreenState();
}

class _CompanyPortfolioScreenState extends State<CompanyPortfolioScreen> {
  bool _isLoading = false;
  bool _isFavorite = false;
  final WatchlistStorage _watchlistStorage = WatchlistStorage();
  late CompanyIncomeStatement _incomeStatement;
  List<FinancialReport> _annualReports = [];
  List<FinancialReport> _quarterlyReports = [];
  final List<String> _rowsName = [
    'Fiscal Date Ending',
    'Reported Currency',
    'Gross Profit',
    'Total Revenue',
    'Cost Of Revenue',
    'Cost Of Goods And Services Sold',
    'Operating Income',
    'Selling General And Administrative',
    'Research And Development',
    'Operating Expense',
    'Investment Income Net',
    'Net Interest Income',
    'Interest Income',
    'Interest Expense',
    'Non Interest Income',
    'Other Non Operating Income',
    'Depreciation',
    'Depreciation And Amortization',
    'Income Before Tax',
    'Income Tax Expense',
    'Interest And Debt Expense',
    'Net Income From Continuing Operations',
    'Comprehensive Income Net Of Tax',
    'Ebit',
    'Ebitda',
    'Net Income',
  ];

  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCompanyIncomeStatement();
  }

  getCompanyIncomeStatement() async {
    setState(() {
      _isLoading = true;
    });
    _incomeStatement =
        await PortfolioService.getCompanyIncomeStatement(widget.company.symbol);
    _annualReports = _incomeStatement.annualReports;
    _quarterlyReports = _incomeStatement.quarterlyReports;
    _isFavorite = await _watchlistStorage.isInWatchlist(widget.company);
    setState(() {
      _isLoading = false;
    });
  }

  List<DataColumn2> _getColumns() {
    return [
      const DataColumn2(
        label: Text(''),
        size: ColumnSize.S,
      ),
      ..._annualReports
          .map((annualReport) => DataColumn2(
              label: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 70.0),
                child: Text(
                  annualReport.fiscalDateEnding.substring(0, 4),
                  style: const TextStyle(
                    shadows: [
                      Shadow(color: Colors.deepPurple, offset: Offset(0, -10))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepPurple,
                    decorationThickness: 4,
                  ),
                ),
              ),
              size: ColumnSize.S,
              numeric: true))
          .toList(),
    ];
  }

  DataRow _getRow(int index) {
    assert(index >= 0);
    if (index >= _rowsName.length) throw 'index > _rowsName.length';
    final rowName = _rowsName[index];
    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Container(
          width: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            rowName,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        )),
        ..._annualReports.map((element) => DataCell(
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  element.toJson().entries.toList()[index].value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              if (_isFavorite) {
                _watchlistStorage.writeWatchlist(widget.company);
              } else {
                _watchlistStorage.removeFromWatchlist(widget.company);
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: DataTable2(
                        scrollController: _controller,
                        dataRowHeight: 70,
                        columnSpacing: 0,
                        horizontalMargin: 0,
                        bottomMargin: 30,
                        dividerThickness: 0,
                        minWidth: 1000,
                        fixedTopRows: 1,
                        fixedLeftColumns: 1,
                        columns: _getColumns(),
                        rows: List<DataRow>.generate(
                            _rowsName.length, (index) => _getRow(index))),
                  ),
                ],
              ),
            ),
    );
  }
}
