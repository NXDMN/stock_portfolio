import 'package:flutter/material.dart';
import 'package:stock_portfolio/models/company_listing_status.dart';
import 'package:stock_portfolio/portfolio_service.dart';
import 'package:stock_portfolio/screens/company_portfolio_screen.dart';
import 'package:stock_portfolio/screens/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<CompanyListingStatus> _companyList = [];
  List<CompanyListingStatus> _filterCompanyList = [];

  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

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
    _companyList = await PortfolioService.getCompanyListingStatus();
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
          title: const Text('My Portfolio'),
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
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
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
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: _filterCompanyList.length,
                      itemBuilder: (context, index) {
                        CompanyListingStatus company =
                            _filterCompanyList[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
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
