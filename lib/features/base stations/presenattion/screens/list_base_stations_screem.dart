import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/main_controller.dart';
import '../widgets/base_station_list_item.dart';

class ListBaseStationsScreen extends ConsumerWidget {
  const ListBaseStationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseStationMethods = ref.watch(baseStationStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Stations'),
      ),
      body: FutureBuilder(
        future: baseStationMethods.getBaseStations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          if (snapshot.hasError) {
            return const Text('Error');
          }

          return snapshot.data!.fold(
            (l) {
              return Text(l.message);
            },
            (r) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListView.builder(
                  itemCount: r.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        BaseStationListItem(
                          title: r[index].name,
                          address: r[index].address,
                          onSelected: (value) {
                            if (value == MenuOptions.update) {
                              log('Update');
                            } else {
                              baseStationMethods.deleteBaseStation(r[index].id);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              );
            },
          );

          //
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push('/add_base_station/${false}');
        },
      ),
    );
  }
}
