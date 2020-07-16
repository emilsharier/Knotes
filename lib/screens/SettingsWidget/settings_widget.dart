import 'package:flutter/material.dart';
import 'package:knotes/components/providers/DynamicTheme.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DynamicTheme>(context);
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          ListTile(
            title: Text('Follow system theme'),
            trailing: Switch(
              value: true,
              onChanged: (arg) {},
            ),
          ),
          ListTile(
            title: Text('Change theme'),
            trailing: IconButton(
              icon: Icon(Icons.palette),
              onPressed: () => provider.toggleTheme(),
            ),
          ),
          ListTile(
            title: Text('Report bugs'),
            trailing: Switch(
              value: true,
              onChanged: (arg) {},
            ),
          ),
          ListTile(
            title: Text('About'),
            trailing: Switch(
              value: true,
              onChanged: (arg) {},
            ),
          ),
        ],
      ),
    );
  }
}
