import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/main/main.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../enums.dart';
import '../../navigation_bar.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const historyLength = 5;

  List<String> _searchHistory = [];

  late List<String> filteredSearchHistory;

  String? selectedTerm;

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FloatingSearchBar(
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: SearchResultsListView(
              searchTerm: selectedTerm ?? "",
            ),
          ),
          transition: CircularFloatingSearchBarTransition(),
          physics: BouncingScrollPhysics(),
          title: Text(
            selectedTerm ?? 'Search...',
            style: Theme.of(context).textTheme.headline6,
          ),
          hint: 'Search and find out...',
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          // onQueryChanged: (query) {
          //   setState(() {
          //     filteredSearchHistory = filterSearchTerms(filter: query);
          //   });
          // },
          onSubmitted: (query) {
            setState(() {
              addSearchTerm(query);
              selectedTerm = query;
            });
            controller.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(
                  builder: (context) {
                    if (filteredSearchHistory.isEmpty &&
                        controller.query.isEmpty) {
                      return Container(
                        height: 56,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Start searching',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    } else if (filteredSearchHistory.isEmpty) {
                      return ListTile(
                        title: Text(controller.query),
                        leading: const Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            addSearchTerm(controller.query);
                            selectedTerm = controller.query;
                          });
                          controller.close();
                        },
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory
                            .map(
                              (term) => ListTile(
                                title: Text(
                                  term,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: const Icon(Icons.history),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      deleteSearchTerm(term);
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    putSearchTermFirst(term);
                                    selectedTerm = term;
                                  });
                                  controller.close();
                                },
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: NavigationBar(selectedMenu: MenuState.search));
  }
}

class SearchResultsListView extends StatefulWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  State<SearchResultsListView> createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  var items = [];
  var user = {};

  @override
  void didUpdateWidget(covariant SearchResultsListView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    searchForUnits(widget.searchTerm).then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo().then((value) {
      var data = jsonDecode(value.body);
      setState(() {
        user = data;
      });
    });
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: Text(msg),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    if (widget.searchTerm != null) {}

    final fsb = FloatingSearchBar.of(context);

    return ListOfItemsSearch(
      getObjects: searchForUnits,
      searchPhrase: widget.searchTerm,
      itemBuilder: (context, index, items, size) {
        var val = items[index];
        var isDisabled = false;

        print(user);
        if (user.containsKey("plan")) {
          if (val['access_plan'] == 'PREMIUM_PLAN' &&
              user['plan'] == 'FREE_PLAN') {
            isDisabled = true;
          }
        }
        return UnitBox(
          isDiabled: isDisabled,
          content: val['short_content'],
          width: size.width * 0.92,
          height: size.height * 0.11,
          unitTitle: val['name'],
          progress: val['progress'].toString(),
          answeredQuestions: '--',
          onPressed: () {
            if (!isDisabled) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UnitTheoryScreen(
                      unitId: val['id'].toString(),
                      unitName: val['name'],
                    );
                  },
                ),
              );
            } else {
              showAlertDialog(
                context,
                "У вас нет прав просматривать данный юнит, пожалуйста обновте свою подписку до премиума, чтобы просмотреть данный юнит.",
              );
            }
          },
        );
      },
      // children: List.generate(
      //   50,
      //   (index) => ListTile(
      //     title: Text('$searchTerm search result'),
      //     subtitle: Text(index.toString()),
      //   ),
      // ),
    );
  }
}
