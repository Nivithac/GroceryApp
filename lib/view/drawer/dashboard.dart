import 'package:flutter/material.dart';

import 'package:faker/faker.dart';
import 'package:flutter_application_1/view/drawer/product.dart';
import 'package:flutter_application_1/view/drawer/theme.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
 
  final faker = Faker();


  @override
  Widget build(BuildContext context) {
    String randomName = faker.person.name();
    String randomEmail = faker.internet.email();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(randomName),
              accountEmail: Text(randomEmail),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(faker.image.image(),),
                
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
             ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the Product page
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Product'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)  => AdminProductScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the Category page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
              },
            ),
             ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Appearance'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)  => Appearance()));
              },
            ),
          ],
        ),
      ),
     body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: <Widget>[
          _buildCard('Item 1', Icons.access_alarm),
          _buildCard('Item 2', Icons.access_time),
          _buildCard('Item 3', Icons.accessibility),
          _buildCard('Item 4', Icons.account_balance),
          _buildCard('Item 5', Icons.account_box),
          _buildCard('Item 6', Icons.account_circle),
        ],
      ),
    );
  }
  Widget _buildCard(String title, IconData icon) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 48.0,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
