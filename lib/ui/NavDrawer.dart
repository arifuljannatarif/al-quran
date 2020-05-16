import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Surah'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.audiotrack),
            title: Text('Audio'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourite'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
