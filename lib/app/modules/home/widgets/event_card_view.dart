import '../../../data/all_events.dart';
import '../models/event_data_model.dart';
import '../views/event_details_view.dart';

class EventCardView extends StatelessWidget {
  final Event event;

  const EventCardView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Get.to(() => EventDetailsView(event: event));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: event.eventId.toString(),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    color: ColorCode.greyLightColor.withOpacity(0.2)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: event.thumbUrlLarge ?? "",
                  height: 90,
                  width: 135,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventname!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  event.venue != null
                      ? event.venue!.fullAddress != null
                          ? event.venue!.fullAddress ?? ""
                          : event.venue!.city!.toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorCode.greyDarkColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  event.startTimeDisplay != null
                      ? event.startTimeDisplay!.toString().substring(0, 15)
                      : event.startTimeDisplay!.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorCode.greyLightColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EventCardPlaceholder extends StatelessWidget {
  const EventCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 135,
          height: 90.0,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.43,
              height: 18.0,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            Container(
              width: Get.width * 0.3,
              height: 16.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            Container(
              width: Get.width * 0.25,
              height: 18.0,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class EventCardForGrid extends StatelessWidget {
  final Event event;

  const EventCardForGrid({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Get.to(() => EventDetailsView(event: event));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: event.eventId.toString(),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                      color: ColorCode.greyLightColor.withOpacity(0.2)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: event.thumbUrlLarge ?? "",
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.eventname ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
