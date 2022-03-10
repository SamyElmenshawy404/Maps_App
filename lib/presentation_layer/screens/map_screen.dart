import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/my_colors.dart';
import 'package:maps_app/location_helper.dart';
import 'package:maps_app/presentation_layer/widgets/my_drawer_wedget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.5,
      tilt: 0.0,
      zoom: 17);

  Future<void> getMyCurrentLocationForInitial() async {
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocationForInitial();
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
        setState(() {});
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Find a place',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      onFocusChanged: (_) {},
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place, color: Colors.black),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: MyColors.blue,
                    ),
                  ),
                ),
          buildFloatingSearchBar()
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: MyColors.blue,
          onPressed: () {
            _goToMyCurrentLocation();
            setState(() {});
          },
          child: Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
