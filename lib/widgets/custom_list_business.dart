
import 'package:books_projects/logic/home_cubit.dart';
import 'package:books_projects/screens/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomListBusiness extends StatelessWidget {
  const CustomListBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text('Failed to load books: ${state.message}'));
        } else if (cubit.business.isEmpty) {
          return const Center(child: Text('No Books'));
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // One card per row
                  childAspectRatio: 3 / 1, // Adjust the aspect ratio as needed
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: cubit.business.length,
                itemBuilder: (context, index) {
                  var business = cubit.business[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: business),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: business.image != null && business.image!.isNotEmpty
                                  ? Image.network(
                                      business.image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                       Text(
                                          business.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                       //const Text("No Title"),
                                  const SizedBox(height: 10),
                                  business.description != null &&
                                          business.description!.isNotEmpty
                                      ? Text(
                                          business.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "No Description",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                  // Center(
                                  //     child: Text(
                                  //   cubit.allBooks[index].language!,
                                  //   style: const TextStyle(
                                  //       color: Colors.amber,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 12),
                                  // ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
