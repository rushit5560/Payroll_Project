import 'package:flutter/material.dart';


class Demo extends StatelessWidget {
  Demo({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool onError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding:
                   const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        style:const TextStyle(color: Colors.amber, fontSize: 14),
                        // controller: emailEditingController,/
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding:const EdgeInsets.fromLTRB(30, 5, 10, 5),
                          labelText: "Enter Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          labelStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 14),
                        ),
                        validator: (String? value) {
                          //     setState(() {
                          //       onError = false;
                          //     });
                          //     if (value!.isEmpty) {
                          //       setState(() {
                          //         onError = true;
                          //       });
                          //       return null;
                          //     }
                          //     return null;
                          //   },
                          // )),
                          onError
                              ?const Positioned(
                                  bottom: 0,
                                  child: Text('this is an error msg',
                                      style: TextStyle(color: Colors.red)))
                              : Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
