class CompanyIncomeStatement {
  final String symbol;
  final List<FinancialReport> annualReports;
  final List<FinancialReport> quarterlyReports;

  CompanyIncomeStatement({
    required this.symbol,
    required this.annualReports,
    required this.quarterlyReports,
  });

  CompanyIncomeStatement.fromJson(Map<String, dynamic> data)
      : symbol = data['symbol'],
        annualReports = data['annualReports']
            .map<FinancialReport>((e) => FinancialReport.fromJson(e))
            .toList(),
        quarterlyReports = data['quarterlyReports']
            .map<FinancialReport>((e) => FinancialReport.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'annualReports': annualReports.map((e) => e.toJson()).toList(),
        'quarterlyReports': quarterlyReports.map((e) => e.toJson()).toList(),
      };
}

class FinancialReport {
  final String fiscalDateEnding;
  final String reportedCurrency;
  final String grossProfit;
  final String totalRevenue;
  final String costOfRevenue;
  final String costofGoodsAndServicesSold;
  final String operatingIncome;
  final String sellingGeneralAndAdministrative;
  final String researchAndDevelopment;
  final String operatingExpenses;
  final String investmentIncomeNet;
  final String netInterestIncome;
  final String interestIncome;
  final String interestExpense;
  final String nonInterestIncome;
  final String otherNonOperatingIncome;
  final String depreciation;
  final String depreciationAndAmortization;
  final String incomeBeforeTax;
  final String incomeTaxExpense;
  final String interestAndDebtExpense;
  final String netIncomeFromContinuingOperations;
  final String comprehensiveIncomeNetOfTax;
  final String ebit;
  final String ebitda;
  final String netIncome;

  FinancialReport({
    required this.fiscalDateEnding,
    required this.reportedCurrency,
    required this.grossProfit,
    required this.totalRevenue,
    required this.costOfRevenue,
    required this.costofGoodsAndServicesSold,
    required this.operatingIncome,
    required this.sellingGeneralAndAdministrative,
    required this.researchAndDevelopment,
    required this.operatingExpenses,
    required this.investmentIncomeNet,
    required this.netInterestIncome,
    required this.interestIncome,
    required this.interestExpense,
    required this.nonInterestIncome,
    required this.otherNonOperatingIncome,
    required this.depreciation,
    required this.depreciationAndAmortization,
    required this.incomeBeforeTax,
    required this.incomeTaxExpense,
    required this.interestAndDebtExpense,
    required this.netIncomeFromContinuingOperations,
    required this.comprehensiveIncomeNetOfTax,
    required this.ebit,
    required this.ebitda,
    required this.netIncome,
  });

  FinancialReport.fromJson(Map<String, dynamic> data)
      : fiscalDateEnding = data['fiscalDateEnding'],
        reportedCurrency = data['reportedCurrency'],
        grossProfit = data['grossProfit'],
        totalRevenue = data['totalRevenue'],
        costOfRevenue = data['costOfRevenue'],
        costofGoodsAndServicesSold = data['costofGoodsAndServicesSold'],
        operatingIncome = data['operatingIncome'],
        sellingGeneralAndAdministrative =
            data['sellingGeneralAndAdministrative'],
        researchAndDevelopment = data['researchAndDevelopment'],
        operatingExpenses = data['operatingExpenses'],
        investmentIncomeNet = data['investmentIncomeNet'],
        netInterestIncome = data['netInterestIncome'],
        interestIncome = data['interestIncome'],
        interestExpense = data['interestExpense'],
        nonInterestIncome = data['nonInterestIncome'],
        otherNonOperatingIncome = data['otherNonOperatingIncome'],
        depreciation = data['depreciation'],
        depreciationAndAmortization = data['depreciationAndAmortization'],
        incomeBeforeTax = data['incomeBeforeTax'],
        incomeTaxExpense = data['incomeTaxExpense'],
        interestAndDebtExpense = data['interestAndDebtExpense'],
        netIncomeFromContinuingOperations =
            data['netIncomeFromContinuingOperations'],
        comprehensiveIncomeNetOfTax = data['comprehensiveIncomeNetOfTax'],
        ebit = data['ebit'],
        ebitda = data['ebitda'],
        netIncome = data['netIncome'];

  Map<String, dynamic> toJson() => {
        'fiscalDateEnding': fiscalDateEnding,
        'reportedCurrency': reportedCurrency,
        'grossProfit': grossProfit,
        'totalRevenue': totalRevenue,
        'costOfRevenue': costOfRevenue,
        'costofGoodsAndServicesSold': costofGoodsAndServicesSold,
        'operatingIncome': operatingIncome,
        'sellingGeneralAndAdministrative': sellingGeneralAndAdministrative,
        'researchAndDevelopment': researchAndDevelopment,
        'operatingExpenses': operatingExpenses,
        'investmentIncomeNet': investmentIncomeNet,
        'netInterestIncome': netInterestIncome,
        'interestIncome': interestIncome,
        'interestExpense': interestExpense,
        'nonInterestIncome': nonInterestIncome,
        'otherNonOperatingIncome': otherNonOperatingIncome,
        'depreciation': depreciation,
        'depreciationAndAmortization': depreciationAndAmortization,
        'incomeBeforeTax': incomeBeforeTax,
        'incomeTaxExpense': incomeTaxExpense,
        'interestAndDebtExpense': interestAndDebtExpense,
        'netIncomeFromContinuingOperations': netIncomeFromContinuingOperations,
        'comprehensiveIncomeNetOfTax': comprehensiveIncomeNetOfTax,
        'ebit': ebit,
        'ebitda': ebitda,
        'netIncome': netIncome,
      };
}
