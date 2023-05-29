// Widget searchBarUI() {
//   return FloatingSearchBar(
//       margins: const EdgeInsets.fromLTRB(30, 50, 30, 0),
//       automaticallyImplyBackButton: false,
//       iconColor: GlobalColors.BlueColor,
//       borderRadius: const BorderRadius.all(Radius.circular(50)),
//       hint: 'Search or Use Filter ...'.tr,
//       openAxisAlignment: 0.0,
//       axisAlignment: 0.0,
//       scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
//       elevation: 4.0,
//       physics: const BouncingScrollPhysics(),
//       onQueryChanged: (query) {
//         //Methods
//       },
//       transitionCurve: Curves.easeInOut,
//       transitionDuration: const Duration(milliseconds: 500),
//       transition: CircularFloatingSearchBarTransition(),
//       debounceDelay: const Duration(milliseconds: 500),
//       actions: [
//         FloatingSearchBarAction(
//           showIfOpened: false,
//           child: CircularButton(
//             icon: const Icon(Icons.filter_list_alt),
//             onPressed: () {
//               FilterDialog.show();
//             },
//           ),
//         ),
//         FloatingSearchBarAction.searchToClear(
//           showIfClosed: false,
//         ),
//       ],
//       builder: (context, transition) {
//         return const ClipRRect();
//       });
// }