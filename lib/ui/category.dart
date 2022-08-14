
import 'package:flutter/material.dart';
import 'package:app1/services/loginuser.dart';
import '../model/product_model.dart';
import 'package:app1/ui/categoryscreen.dart';
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    List<String> imag=[
      'assets/cat/11.jpg',
      'assets/cat/2.jpg',
      'assets/cat/3.jpg',
      'assets/cat/5.jpg',
      'assets/cat/6.jpg',
      'assets/cat/7.jpg',
      'assets/cat/8.jpg',
      'assets/cat/9.jpg',
    ];
    List<String> tag=[
      'Mobiles and Electronic devices',
      'Fashion and Beauty',
      'Groceries and Pet Supply',
      'Home and Furniture Appliances',
      'Music, Video and Gaming',
      'Books and Education',
      'Toys',
      'Sports'
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
          title: Text(
            'Category',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
      ),
      body: Container(
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        child:GridView.builder(
            padding:EdgeInsets.all(80.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2/2.5,
                crossAxisSpacing: 80,
                mainAxisSpacing: 80
            ),
            itemCount: imag.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  imag[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // color: Colors.amber,
                          // borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(tag[index],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,

                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: ()async {
                  List<ProdModel> fetchitem=await FireCloud().getCatData(tag[index]);
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>CatScreen(item:fetchitem)),

                  );
                },
              );
            }),
      ),
    );
  }
}
