import 'package:flutter/material.dart';
import 'package:resep_indonesia/model/resep.api.dart';
import 'package:resep_indonesia/model/resep.dart';
import 'package:resep_indonesia/views/widgets/resep_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Resep> _resep;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Resep Makanan')
          ],
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(itemCount: _resep.length,
      itemBuilder: (context, index){
        return ResepCard(
          title: _resep[index].name,
          coocktime: _resep[index].totalTime,
          rating: _resep[index].rating.toString(),
          thumbnailUrl: _resep[index].images,
        );
      },
      ),
    );
  }
}