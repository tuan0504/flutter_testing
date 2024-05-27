import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    const Text('Movies'),
  ];

  final List<Widget> _listWidget = [
    const WatchlistMoviesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Watchlist',
                style: kHeading5.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
                child: TabBar(
                  labelPadding: const EdgeInsets.all(16),
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFF211F30),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelStyle: kBodyText.copyWith(fontWeight: FontWeight.w700),
                  labelColor: Colors.white,
                  unselectedLabelStyle: kBodyText,
                  tabs: _listTabs,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _listWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
