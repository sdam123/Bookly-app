import 'package:bookly_app/core/utils/servise_locator.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:bookly_app/features/home/presentation/view/widget/home_page_body.dart';
import 'package:bookly_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearshPage extends StatelessWidget {
  const SearshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => SearchCubit(getIt.get<HomeRepoImpl>()),
        child: const SearshBody(),
      ),
    ));
  }
}

class SearshBody extends StatelessWidget {
  const SearshBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(),
          SizedBox(
            height: 16,
          ),
          Text(
            'Result Searsh',
            style: Styles.textStyle14,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(child: ResultListView())
        ],
      ),
    );
  }
}

class ResultListView extends StatelessWidget {
  const ResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
  return ListView.builder(
    
    itemBuilder: (context, index) {
      return  Padding(
        padding:const EdgeInsets.symmetric(vertical: 10),
        child: BestSillerItem(bookes: state.books[index],),
      );
    },
    padding: EdgeInsets.zero,
    itemCount: state.books.length,
    physics: const BouncingScrollPhysics(),
  );
}  else if(state is SearchFailure){
  return Center(child: Text(state.errMessage),);
}else if(state is SearchLooding){
  return Center(child: CircularProgressIndicator(),);
}else {
  return Center(child: Text('No Search'),);
}
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        BlocProvider.of<SearchCubit>(context).fetchSearchBooks(search: value);
      },
      decoration: InputDecoration(
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          hintText: 'Searsh',
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12));
  }
}
