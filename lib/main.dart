import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/item.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InventoryPage(),
    );
  }
}

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final FirestoreService _service = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _addItem() {
    final String name = nameController.text;
    final int quantity = int.tryParse(quantityController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0.0;

    if (name.isEmpty || quantity <= 0 || price <= 0) return;

    _service.addItem(Item(id: '', name: name, quantity: quantity, price: price));
    nameController.clear();
    quantityController.clear();
    priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: quantityController, decoration: InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
                TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                ElevatedButton(onPressed: _addItem, child: Text('Add Item')),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: _service.getItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('Qty: ${item.quantity} | Price: \$${item.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _service.deleteItem(item.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}