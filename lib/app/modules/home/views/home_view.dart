import 'package:all_events/app/data/all_events.dart';
import 'package:all_events/app/modules/home/models/event_data_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';
import '../widgets/event_card_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: "home",
        init: HomeController(),
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 36), //for manage space in the status bar
                  _searchBar(),
                  const SizedBox(height: 8),
                  _filterButtons(),
                  const SizedBox(height: 8),
                  _buildCityTitleRow(),
                  _eventList(),
                ],
              ),
            ),
          );
        });
  }

  //show events list view from api
  Widget _eventList() {
    if (controller.isLoadingEvent.value) {
      return eventListShimmerEffect();
    } else {
      return Expanded(
        child: controller.eventList.isEmpty
            ? const Center(child: Text("No Events"))
            : controller.eventList[controller.selectedCategory] == null || controller.eventList[controller.selectedCategory]!.eventList!.isEmpty
                ? const Center(child: Text("No Events"))
                : controller.isEventShowInList.value
                    ? _eventListViewBuilder()
                    : _eventListInGridView(),
      );
    }
  }

  Widget _eventListViewBuilder() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      controller: controller.eventScrollController,
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: controller.eventList[controller.selectedCategory]!.eventList!.length,
      itemBuilder: (context, index) {
        final Event event = controller.eventList[controller.selectedCategory]!.eventList![index];
        return EventCardView(event: event);
      },
    );
  }

  //show event list in grid view
  Widget _eventListInGridView() {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      controller: controller.eventScrollController,
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      itemCount: controller.eventList[controller.selectedCategory]!.eventList!.length,
      itemBuilder: (context, index) {
        final Event event = controller.eventList[controller.selectedCategory]!.eventList![index];
        return EventCardForGrid(event: event);
      },
      mainAxisSpacing: 12.0,
      // Space between rows
      crossAxisSpacing: 12.0, // Space between columns
    );
  }

  Widget _searchBar() {
    return const SizedBox(
      height: 44,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: ColorCode.greyDarkColor),
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }

  //buttons for filter
  Widget _filterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            _showCategoryFilterList();
          },
          label: Text(
            controller.selectedCategory != "" ? controller.selectedCategory.capitalize! : "Category",
            style: const TextStyle(fontWeight: FontWeight.bold, color: ColorCode.greyDarkColor),
          ),
          icon: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              onPressed: () {
                if (controller.selectedCategory != "") {
                  controller.selectedCategory = controller.eventList.keys.first;
                  controller.eventScrollController.position.animateTo(0, duration: const Duration(microseconds: 1000), curve: Curves.bounceInOut);
                  controller.update(["home"]);
                } else {
                  _showCategoryFilterList();
                }
              },
              icon: Icon(controller.selectedCategory != "" ? Icons.close : Icons.keyboard_arrow_down_sharp, color: ColorCode.greyDarkColor)),
          style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 12, right: 8)), backgroundColor: controller.selectedCategory == "" ? const WidgetStatePropertyAll(Colors.white) : WidgetStatePropertyAll(Get.theme.primaryColor)),
          iconAlignment: IconAlignment.end,
        ),
        OutlinedButton.icon(
          onPressed: () {
            _showDateFilterList();
          },
          label: const Text("Date", style: TextStyle(fontWeight: FontWeight.bold, color: ColorCode.greyDarkColor)),
          icon: const Icon(Icons.keyboard_arrow_down_sharp, color: ColorCode.greyDarkColor),
          iconAlignment: IconAlignment.end,
        ),
        OutlinedButton.icon(
          onPressed: () {
            _showPriceFilterList();
          },
          label: const Text("Price", style: TextStyle(fontWeight: FontWeight.bold, color: ColorCode.greyDarkColor)),
          icon: const Icon(Icons.keyboard_arrow_down_sharp, color: ColorCode.greyDarkColor),
          iconAlignment: IconAlignment.end,
        ),
      ],
    );
  }

  // category in list view
  Widget _categoryListInListTile() {
    return controller.categoryList.isEmpty
        ? const Text("No Categories")
        : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.categoryList.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: controller.categoryList[index].category ?? "category",
                child: Column(
                  key: ValueKey(controller.categoryList[index].category),
                  children: [
                    ListTile(
                      onTap: () {
                        controller.selectedCategory = controller.categoryList[index].category!;
                        controller.eventScrollController.position.animateTo(0, duration: const Duration(microseconds: 1000), curve: Curves.bounceInOut);
                        controller.update(["home"]);
                        Get.back();
                      },
                      title: Text(
                        controller.categoryList[index].category!.capitalize!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    ),
                    index == controller.categoryList.length - 1 ? const SizedBox() : const Divider()
                  ],
                ),
              );
            },
          );
  }

  // category in chip view
  Widget _categoryListInChip() {
    return controller.categoryList.isEmpty
        ? const Text("No Categories")
        : Wrap(
            children: controller.categoryList.map(
              (category) {
                return Hero(
                  tag: category.category ?? "category",
                  child: Padding(
                    key: ValueKey(category.category),
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ActionChip(
                      onPressed: () {
                        controller.selectedCategory = category.category!;
                        controller.eventScrollController.position.animateTo(0, duration: const Duration(microseconds: 1000), curve: Curves.bounceInOut);
                        controller.update(["home"]);
                        Get.back();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      label: Text(category.category!.capitalize!),
                      color: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                );
              },
            ).toList(),
          );
  }

  // bottomSheet for show category filter List
  void _showCategoryFilterList() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Get.width * 0.2,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Choose Your Preferred ', style: TextStyle(fontSize: 20)),
                                TextSpan(text: 'Category', style: TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.isCategoryShowInList.value = !controller.isCategoryShowInList.value;
                              },
                              icon: Icon(controller.isCategoryShowInList.value ? Icons.grid_view_rounded : Icons.view_list))
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1.0,
                          child: child,
                        );
                      },
                      child: controller.isCategoryShowInList.value ? _categoryListInListTile() : _categoryListInChip(),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // bottomSheet for show date filter List
  void _showDateFilterList() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Get.width * 0.2,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Date Filter is Working",style: TextStyle(fontSize: 20),),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bottomSheet for show date Price List
  void _showPriceFilterList() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: Get.width * 0.2,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Price Filter is Working",style: TextStyle(fontSize: 20),),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Event List ShimmerEffect for show smooth loading animation's
  Widget eventListShimmerEffect() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventCardPlaceholder(),
              EventCardPlaceholder(),
              EventCardPlaceholder(),
              EventCardPlaceholder(),
              EventCardPlaceholder(),
              // EventCardPlaceholder(),
            ],
          ),
        ));
  }

  // city title for events and button for change list/grind to events list
  Widget _buildCityTitleRow() {
    return controller.eventList[controller.selectedCategory] == null
        ? const SizedBox()
        : SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Events around ', style: TextStyle(fontSize: 20)),
                      TextSpan(text: controller.eventList[controller.selectedCategory]!.request!.city!.capitalize ?? 'Your City', style: TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.isEventShowInList.value = !controller.isEventShowInList.value;
                      controller.update(["home"]);
                    },
                    icon: Icon(controller.isEventShowInList.value ? Icons.grid_view_rounded : Icons.view_list))
              ],
            ),
          );
  }
}
