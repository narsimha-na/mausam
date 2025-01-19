import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosam/core/constants/color_constants.dart';
import 'package:mosam/core/functions/general_functions.dart';
import 'package:mosam/core/router/app_router.dart';
import 'package:mosam/core/widgets/shimmer.dart';
import 'package:mosam/features/home/provider/home_provider.dart';
import 'package:mosam/features/search/repository/models/search_city_model.dart';
import 'package:provider/provider.dart';
import 'package:mosam/features/search/provider/search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgWhiteColor,
      body: SafeArea(
        child:
            Consumer<SearchProvider>(builder: (context, searchProvider, child) {
          return ListView(
            children: [
              _serachBar(searchProvider: searchProvider),
              searchProvider.loading
                  ? ShimmerEffectWidgets.listEffect()
                  : searchProvider.results.isEmpty
                      ? _emptyList()
                      : _listView(searchProvider: searchProvider),
            ],
          );
        }),
      ),
    );
  }

  _serachBar({required SearchProvider searchProvider}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          searchProvider.onSearchChanged(value);
        },
        decoration: const InputDecoration(
          hintText: 'Search City',
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  _listView({required SearchProvider searchProvider}) {
    return ListView.builder(
      itemCount: searchProvider.results.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _itemList(
            searchList: searchProvider.results[index],
            searchProvider: searchProvider);
      },
    );
  }

  _emptyList() {
    return const Center(
      child: Text("No results found"),
    );
  }

  _itemList(
      {required SearchList searchList,
      required SearchProvider searchProvider}) {
    String country = searchList.sys!.country ?? "";
    String imgUrl = getCountryImagePath(country);
    String climateTemp = "${searchList.main!.temp!.toStringAsFixed(1)}°C";
    String climateDescription =
        searchList.weather![0].description?.toUpperCase() ?? "";
    return GestureDetector(
      onTap: () {
        searchProvider.saveSearchResult(
          context: context,
          searchList: searchList,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Image.network(imgUrl, height: 20, width: 20, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(searchList.name ?? ""),
                Text("$climateTemp\t-\t$climateDescription"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
