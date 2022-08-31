import 'package:flutter/material.dart';
import 'package:stock_portfolio/models/company_listing_status.dart';
import 'package:stock_portfolio/screens/company_portfolio_screen.dart';
import 'package:stock_portfolio/screens/home_screen.dart';
import 'package:stock_portfolio/watchlist_storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoading = false;
  final WatchlistStorage _watchlistStorage = WatchlistStorage();
  List<CompanyListingStatus> _companyList = [];
  List<CompanyListingStatus> _filterCompanyList = [];

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCompanyList();

    _controller.addListener(() {
      setState(() {
        _filterCompanyList = _companyList
            .where((company) => company.name
                .toLowerCase()
                .contains(_controller.text.toLowerCase()))
            .toList();
      });
    });
  }

  getCompanyList() async {
    setState(() {
      _isLoading = true;
    });
    _companyList = await _watchlistStorage.readWatchlist();
    _filterCompanyList = _companyList;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Watchlist'),
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Watchlist',
            ),
          ],
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 40.0, 200.0, 20.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search a company',
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _filterCompanyList.isEmpty
                        ? const Center(child: Text('You have empty watchlist'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: _filterCompanyList.length,
                            itemBuilder: (context, index) {
                              CompanyListingStatus company =
                                  _filterCompanyList[index];
                              return Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: ListTile(
                                  title: Text(company.name),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyPortfolioScreen(
                                                  company: company,
                                                )));
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ));
  }
}
