import 'package:flutter/material.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';

class ExpanseCategoryList extends StatelessWidget {
  const ExpanseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expanseCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = newlist[index];
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  title: Text(category.name,style: TextStyle(color: Colors.black),),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(category.id);
                    },
                    icon: const Icon(Icons.delete,color: Colors.black,),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: newlist.length,
        );
      },
    );
  }
}
