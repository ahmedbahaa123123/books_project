
import 'package:books_projects/logic/home_cubit.dart';
import 'package:books_projects/widgets/custom_list_sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSportsBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sports'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://www.lifewire.com/thmb/DLbW5ikKQ57uxqc8ojMvLJnAuJ4=/3122x3192/filters:fill(auto,1)/GettyImages-4799940351-565a0cb55f9b5835e464905e.jpg', 
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var cubit = BlocProvider.of<HomeCubit>(context);
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  return Center(
                      child: Text('Failed to load cart: ${state.message}'));
                } else if (cubit.sports.isEmpty) {
                  return const Center(child: Text('No items in cart'));
                } else {
                  return const CustomListSports();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
