import 'package:finance/lite/category.impl.dart';
import 'package:finance/model/category.model.dart';
import 'package:flutter/material.dart';

import '../colory.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final categoryLibelleCtrl = TextEditingController();
  bool isSaving = false;

  final categoryService = CategoryImpl();

  Future<List<Category>?> getCategories() async {
    return await categoryService.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: Colory.greenLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colory.greenLight,
        foregroundColor: Colors.white,
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return showForm();
          },
        ),
      ),
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          _head(),
          Positioned(
              top: 20,
              child: Container(
                height: 550,
                width: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: FutureBuilder(
                    future: getCategories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final produit = snapshot.data?[index];
                              return ListTile(
                                title: Text('${produit?.libelle}'),
                              );
                            });
                      }
                    }),
              ))
        ],
      )),
    );
  }

  Column _head() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
              color: Colory.greenLight,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ],
    );
  }

  Widget showForm() {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        width: double.infinity,
        height: 150,
        child: Form(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: libelleField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: !isSaving
                  ? OutlinedButton(
                      child: const Text("Submit"),
                      onPressed: () async {
                        try {
                          setState(() {
                            isSaving = true;
                          });
                          await categoryService.save(Category(
                              libelle: categoryLibelleCtrl.text, version: 1));
                          setState(() {
                            isSaving = false;
                          });
                          Navigator.of(context).pop();
                        } catch (e) {
                          setState(() {
                            isSaving = false;
                          });
                        }
                      },
                    )
                  : const CircularProgressIndicator(),
            )
          ]),
        ),
      ),
    );
  }

  Padding libelleField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: categoryLibelleCtrl,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Category',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffC5C5C5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Colory.greenLight))),
      ),
    );
  }
}
