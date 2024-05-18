import 'dart:developer';

import 'package:all_events/app/data/all_events.dart';
import 'package:all_events/app/modules/home/views/ticket_book_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/global_widgets/custom_icon_button.dart';
import '../controllers/home_controller.dart';
import '../models/event_data_model.dart';

class EventDetailsView extends GetView<HomeController> {
  final Event event;

  const EventDetailsView({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                _buildSliverAppBar(),
                _buildSliverListEventDetails(),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.confirmation_num_outlined,
                            color: Get.theme.primaryColor,
                            size: 36,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            event.tickets!.hasTickets!
                                ? "${event.tickets!.ticketCurrency} ${event.tickets!.minTicketPrice}"
                                : "Free",
                            style: const TextStyle(
                                color: ColorCode.greyDarkColor, fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (![null, "", " "]
                                .contains(event.tickets!.ticketUrl)) {
                              Get.to(() => TicketBookView(
                                    uri: event.tickets!.ticketUrl ?? "",
                                  ));
                            } else {
                              Get.rawSnackbar(
                                  message: "Ticket Url Not found.!");
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Get.theme.primaryColor),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // You can adjust the radius value as needed
                                ),
                              ),
                              foregroundColor:
                                  const WidgetStatePropertyAll(Colors.white)),
                          child: const Text(
                            "Book Tickets",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      snap: false,
      pinned: true,
      // title: Text(event.eventname ?? ""),
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Hero(
            tag: event.eventId.toString(),
            child: CachedNetworkImage(
              imageUrl: event.thumbUrlLarge ?? "",
              height: Get.height * 0.2,
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
          ) //Images.network
          ),
      expandedHeight: Get.height * 0.22,
      leading: Container(
        margin: const EdgeInsets.all(8),
        height: 36,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
        child: IconButton(
          padding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSliverListEventDetails() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  event.eventname ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 22),
                ),
                const SizedBox(height: 12),
                // get created by name from the owner id
                const Text(
                  "Created by AllEvents Information's Private Limited",
                  style:
                      TextStyle(color: ColorCode.greyDarkColor, fontSize: 18),
                ),
                const SizedBox(height: 12),
                _buttonsRow(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Divider(color: ColorCode.greyLightColor.withOpacity(0.5)),
          ListTile(
            leading: const Icon(Icons.access_time_rounded,
                color: ColorCode.greyDarkColor),
            title: Text(
              "${event.startTimeDisplay!} to ${event.endTimeDisplay!}",
              style:
                  const TextStyle(color: ColorCode.greyDarkColor, fontSize: 16),
            ),
          ),
          ExpandableTextTile(
            text: "${event.venue!.fullAddress}",
            latitude: "${event.venue!.latitude ?? "0"}",
            longitude: "${event.venue!.longitude ?? "0"}",
            address: "${event.venue!.fullAddress}",
          ),
          Divider(color: ColorCode.greyLightColor.withOpacity(0.5)),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Text("About",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                // Text(event.eventdescription ?? "", style: TextStyle(fontWeight: FontWeight.w800,color: ColorCode.greyDarkColor, fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Obx(() {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: CustomIconButton(
                  key: ValueKey<bool>(controller.isFavoriteEvent.value),
                  icon: controller.isFavoriteEvent.value
                      ? Icons.star_outlined
                      : Icons.star_border,
                  onPressed: () {
                    controller.isFavoriteEvent.value =
                        !controller.isFavoriteEvent.value;
                  },
                  color: Get.theme.primaryColor,
                  size: 36,
                ),
              );
            }),
            const Text(
              "Interested",
              style: TextStyle(color: ColorCode.greyDarkColor),
            ),
          ],
        ),
        Column(
          children: [
            CustomIconButton(
              icon: Icons.calendar_month,
              onPressed: () {},
              color: Get.theme.primaryColor,
              size: 36,
            ),
            const Text(
              "Calendar",
              style: TextStyle(color: ColorCode.greyDarkColor),
            ),
          ],
        ),
        Column(
          children: [
            CustomIconButton(
              icon: Icons.share,
              onPressed: () {
                controller
                    .shareEventDetails(event.shareUrl ?? "${event.eventname}");
              },
              color: Get.theme.primaryColor,
              size: 36,
            ),
            const Text(
              "Share",
              style: TextStyle(color: ColorCode.greyDarkColor),
            ),
          ],
        ),
        Column(
          children: [
            CustomIconButton(
              icon: Icons.more_vert_outlined,
              onPressed: () {},
              color: Get.theme.primaryColor,
              size: 36,
            ),
            const Text(
              "More",
              style: TextStyle(color: ColorCode.greyDarkColor),
            ),
          ],
        ),
      ],
    );
  }
}

class ExpandableTextTile extends StatefulWidget {
  final String text;
  final String latitude;
  final String longitude;
  final String address;

  const ExpandableTextTile(
      {super.key,
      required this.text,
      required this.latitude,
      required this.longitude,
      required this.address});

  @override
  State<ExpandableTextTile> createState() => _ExpandableTextTileState();
}

class _ExpandableTextTileState extends State<ExpandableTextTile> {
  bool _isExpanded = false;

  Future<void> openMap() async {
    // String googleMapUrl = "https://www.google.com/maps/search/${widget.address.split(" ").join("+")}";
    String googleMapUrl =
        "https://www.google.com/maps/search/${widget.latitude},${widget.longitude}";
    // String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}';
    try {
      await launchUrl(Uri.parse(googleMapUrl));
    } on Exception catch (error) {
      log("ERROR on openMap : $error");
      Get.rawSnackbar(message: 'Could not launch map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.location_on_outlined,
            color: ColorCode.greyDarkColor),
        title: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate if the text exceeds two lines
            final span = TextSpan(
              text: widget.text,
              style:
                  const TextStyle(color: ColorCode.greyDarkColor, fontSize: 16),
            );
            final tp = TextPainter(
              text: span,
              maxLines: _isExpanded ? 100 : 2,
              textDirection: TextDirection.ltr,
            );
            tp.layout(maxWidth: constraints.maxWidth);
            final isOverflowing = tp.didExceedMaxLines;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  span,
                  maxLines: _isExpanded ? 100 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isOverflowing || _isExpanded)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? "Show less" : "Show more",
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 130,
            child: TextButton(
              onPressed: () {
                openMap();
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                visualDensity: const VisualDensity(
                  horizontal: -4,
                ),
              ),
              child: Text(
                "View on Map",
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 18),
              ),
            ),
          ),
        ));
  }
}
