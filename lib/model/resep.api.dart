import 'dart:convert';
import 'package:resep_indonesia/model/resep.dart';
import 'package:http/http.dart' as http;


class ResepApi{

//   const req = unirest('GET', 'https://yummly2.p.rapidapi.com/feeds/list');

// req.query({
// 	limit: '24',
// 	start: '0'
// });

// req.headers({
	// 'x-rapidapi-key': '60c741613cmshf898331f50db792p169101jsn95c3d135adfb',
	// 'x-rapidapi-host': 'yummly2.p.rapidapi.com'
// });


static Future<List<Resep>> getResep() async {
  var uri = Uri.https('yummly2.p.rapidapi.com','feeds/list',
  {
    "limit": "24",
   	"start": "0",
    "tag": "list.recipe.popular"
  });



final response = await http.get(uri, headers: {
  
  	"x-rapidapi-key": "60c741613cmshf898331f50db792p169101jsn95c3d135adfb",
	  "x-rapidapi-host": "yummly2.p.rapidapi.com",
    "useQueryString" : "true"
});


  Map data = jsonDecode(response.body);


  List _temp = [];

  for (var i in data['feed']) {
    _temp.add(i['content']['details']);
  }


  return Resep.resepFromSnapshot(_temp);
}
}