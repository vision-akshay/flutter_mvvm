import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/status.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view-model/home_view_model.dart';
import 'package:flutter_mvvm/view-model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel _homeViewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeViewModel.fetchMoviesListApi();
  }

  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter MVVM'),
          actions: [
            IconButton(
                onPressed: () async {
                  await userPref.remove().then((value) {
                    Navigator.of(context)
                        .pushReplacementNamed(RoutesName.splash);
                  });
                },
                icon: const Icon(Icons.power_settings_new))
          ],
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
            create: (BuildContext context) => _homeViewModel,
            child: Consumer<HomeViewModel>(
              builder: (context, value, _) {
                log('api status---->${value.moviesList.status}');
                switch (value.moviesList.status) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.error:
                    return Text(value.moviesList.message.toString());
                  case Status.completed:
                    return ListView.builder(
                        itemCount: value.moviesList.data?.movies?.length ?? 0,
                        itemBuilder: (context, index) => Card(
                              child: ListTile(
                                title: Text(value
                                    .moviesList.data!.movies![index].title
                                    .toString()),
                                subtitle: Text(value
                                    .moviesList.data!.movies![index].year
                                    .toString()),
                                leading: Image.network(
                                  value
                                      .moviesList.data!.movies![index].posterurl
                                      .toString(),
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Utils.averageRating(value.moviesList
                                            .data!.movies![index].ratings!)
                                        .toStringAsFixed(1)),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  ],
                                ),
                              ),
                            ));

                  default:
                    return const Text('Default case');
                }
              },
            )));
  }
}
