import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    //  height: 42,
     // margin: const EdgeInsets.all(20.0),
      width: 500,
      height: 40,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 8,
        child: TextFormField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(

            prefixIcon: InkWell(

              onTap: (){},
              child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(Icons.search,color: Colors.grey[500],),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(top:10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),

            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,

            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
            ),
            hintText: 'Search Ciao.in',
            hintStyle: TextStyle(
              color: Colors.grey[500],

            )
          ),
        ),
      ),
    );
  }
}
