import 'package:flutter/material.dart';

import '../../domain/models/place_model.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.place,
    required this.onTap,
  });

  final PlaceModel place;
  final Function(PlaceModel place) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(place),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.more_time,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: Text(
                    place.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: Text(
                    place.address ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
