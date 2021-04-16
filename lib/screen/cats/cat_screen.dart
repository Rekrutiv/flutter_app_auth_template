import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/cat_list/cats_bloc.dart';
import 'package:flutter_app_auth_template/screen/cats/cat_detail.dart';
import 'package:flutter_app_auth_template/screen/widgets/cat_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CatsScreen extends StatefulWidget {
  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CatsBloc>(context).add(FetchCats());
    return Scaffold(
      body: BlocBuilder<CatsBloc, CatsState>(
        builder: (context, state) {
          if (state is CatsLoading) {
            return Center(
              child:
                  //Text('loading')
                  Image.asset(
                "assets/loader.gif",
                height: 150.0,
                width: 150.0,
              ),
            );
          }
          if (state is CatsLoaded) {
            final cats = state.cats;

            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  final currentCat = cats[index];
                  return InkWell(
                    onTap: () {},
                    child: Hero(
                      tag: 'imgHero${currentCat.imageUrl}',
                      child: CatCard(
                        breed: currentCat.breed,
                        imageUrl: currentCat.imageUrl,
                        condition: true,
                      ),
                    ),
                  );
                });
          }
          if (state is CatsLoadingError) {
            return Text(
              'Something went wrong!, error = ${state.error}',
              style: TextStyle(color: Colors.red),
            );
          }
          return Center(child: Text('Please Select a Location'));
        },
      ),
    );
  }
}
