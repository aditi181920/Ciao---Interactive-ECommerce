import 'package:app1/ui/productscreen.dart';
import 'package:app1/ui/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:app1/model/product_model.dart';

class CatScreen extends StatefulWidget {
  final List<ProdModel> item;
  const CatScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  @override
  Widget build(BuildContext context) {
    // final List<String> item=['assets/prod/p1_1.jpg',
    //   'assets/prod/p1_2.jpg',
    //   'assets/prod/p2_1.jpg',
    //   'assets/prod/p2_2.jpg',
    //   'assets/prod/p3_1.jpg',
    //   'assets/prod/p3_2.jpg',
    //   'assets/prod/p4_1.jpg',
    //   'assets/prod/p4_2.jpg'
    // ];

    return Container(
      color: Colors.deepPurpleAccent.withOpacity(0.2),
      child: GridView.builder(
        controller: ScrollController(),
        padding: EdgeInsets.all(80.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2 / 2.5,
            crossAxisSpacing: 80,
            mainAxisSpacing: 80),
        itemCount: widget.item.length,
        itemBuilder: (BuildContext context, id) {
          return GestureDetector(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.item[id].image1!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        child: Text(
                          '${widget.item[id].name}',
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ))
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductPage(p: widget.item[id])));
            },
          );
        },
      ),
    );
  }
}
