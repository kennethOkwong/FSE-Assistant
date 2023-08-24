import 'package:flutter/material.dart';
import 'package:fse_assistant/config/theme_data.dart';
import 'package:fse_assistant/core/resources/helper_functions.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'loading_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor? _icon;

  @override
  void initState() {
    super.initState();
    _getIcon();
  }

  // Cargar imagen del Marker
  void _getIcon() async {
    var bitMap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1)),
        'assets/icons/location.png');
    _icon = bitMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: HelperFunctions.loadLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!.lat, snapshot.data!.lng),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('L1'),
                      position: LatLng(snapshot.data!.lat, snapshot.data!.lng),
                      icon: _icon!,
                    )
                  },
                  onTap: (argument) {},
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                      color: AppColors.green,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LocationBottonSheet(
                    address: snapshot.data!.address,
                    onPressed: () {
                      Navigator.of(context).pop(snapshot.data);
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}

class LocationBottonSheet extends StatefulWidget {
  const LocationBottonSheet({
    super.key,
    required this.address,
    required this.onPressed,
  });

  final String address;
  final VoidCallback onPressed;

  @override
  State<LocationBottonSheet> createState() => _LocationBottonSheetState();
}

class _LocationBottonSheetState extends State<LocationBottonSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SizedBox(
                  height: 5,
                  width: 50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Base station location',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Move and tap the map to pick the exact location or type to search',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(2, 2)),
              ],
            ),
            child: TextField(
              autocorrect: false,
              textCapitalization: TextCapitalization.sentences,
              controller: TextEditingController(text: widget.address),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.lightGrey,
                ),
                hintText: 'Search location',
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.lightGrey),

                // border: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(25),
                //   ),
                // ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              child: const Text(
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
