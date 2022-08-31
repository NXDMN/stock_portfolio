class CompanyListingStatus {
  final String symbol;
  final String name;
  final String exchange;
  final String assetType;
  final String ipoDate;
  final String delistingDate;
  final String status;

  CompanyListingStatus({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.assetType,
    required this.ipoDate,
    required this.delistingDate,
    required this.status,
  });

  CompanyListingStatus.fromJson(Map<String, dynamic> data)
      : symbol = data['symbol'],
        name = data['name'],
        exchange = data['exchange'],
        assetType = data['assetType'],
        ipoDate = data['ipoDate'],
        delistingDate = data['delistingDate'],
        status = data['status'];

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'name': name,
        'exchange': exchange,
        'assetType': assetType,
        'ipoDate': ipoDate,
        'delistingDate': delistingDate,
        'status': status,
      };
}
