import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_app/bussines_logic_layer/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/my_colors.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.blue[100]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.asset(
              'assets/myimage.jpg',
              fit: BoxFit.contain,
              height: 100,
            ),
          ),
        ),
        Text(
          'Samy Elmenshawy',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '01550882958',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??
          Icon(
            Icons.arrow_right,
            color: MyColors.blue,
          ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url ';
  }

  Widget buildSocialIcon(IconData icon, String url, Color color) {
    return InkWell(
      onTap: () => launchUrl(url),
      child: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildSocialIcon(FontAwesomeIcons.facebook,
              'https://www.facebook.com/samy.M.elmenshawy', Colors.blue),
          SizedBox(
            width: 15,
          ),
          buildSocialIcon(
              FontAwesomeIcons.youtube,
              'https://www.youtube.com/channel/UC2NwgKuvz2VdhMexhjzX3uw',
              Colors.red),
          SizedBox(
            width: 15,
          ),
          buildSocialIcon(FontAwesomeIcons.telegram, '', Colors.blueAccent)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemDivider(),
          buildDrawerListItem(
              leadingIcon: Icons.history,
              title: 'Places History',
              onTap: () {}),
          buildDrawerListItemDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: buildDrawerListItem(
                leadingIcon: Icons.logout,
                title: 'Logout',
                onTap: () async {
                  await phoneAuthCubit.logOut();
                  Navigator.of(context).pushReplacementNamed(loginScreen);
                },
                color: Colors.red,
                trailing: SizedBox()),
          ),
          Spacer(),
          ListTile(
            leading: Text(
              'Follow us ',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons()
        ],
      ),
    );
  }
}
