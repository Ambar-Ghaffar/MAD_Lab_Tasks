
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';

class MyHome extends StatefulWidget {
  String email;
  String imageUrl;
  bool react;
  bool javascript;
  bool python;
  bool typescript;
  bool html;
  bool css;
  bool java;
  MyHome({
    required this.email,
    required this.react,
    required this.javascript,
    required this.python,
    required this.typescript,
    required this.html,
    required this.imageUrl,
    required this.java,
    required this.css,
  });

  @override
  State<MyHome> createState() => _MyHomeState(
        react: react,
        javascript: javascript,
        python: python,
        typescript: typescript,
        html: html,
        imageUrl: imageUrl,
        java: java,
        css: css,
      );
}

class _MyHomeState extends State<MyHome> {
  String imageUrl;
  bool react;
  bool javascript;
  bool python;
  bool typescript;
  bool html;
  bool java;
  bool css;
  _MyHomeState({
    required this.react,
    required this.javascript,
    required this.python,
    required this.typescript,
    required this.html,
    required this.imageUrl,
    required this.java,
    required this.css,
  });
  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
  final Shader headerGradient = LinearGradient(colors: <Color>[
    // ignore: prefer_const_constructors
    Color.fromARGB(255, 0, 242, 255),
    // ignore: prefer_const_constructors
    Color.fromARGB(255, 33, 170, 97)
  ]).createShader(Rect.fromLTWH(0, 0, 200.0, 70.0));

  final Shader highLightGradient = LinearGradient(colors: <Color>[
    Color.fromARGB(255, 43, 255, 1),
    Color.fromARGB(255, 255, 255, 0)
  ]).createShader(const Rect.fromLTWH(0, 0, 200.0, 70.0));

  final Shader overallTextGradient = LinearGradient(colors: <Color>[
    Color(0xFF0000FF),
    Color(0xff5b0060),
    Color(0xffa70160),
    Color(0xff870160),
    Color(0xffac255e),
    Color(0xffca485c),
    Color(0xfff39860),
    Color.fromARGB(255, 255, 89, 0)
  ]).createShader(Rect.fromLTWH(0, 0, 200.0, 70.0));

  // ignore: avoid_types_as_parameter_names
  mySkills(num, type) {
    return Row(
      children: [
        Text(
          num,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = overallTextGradient),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(type),
        )
      ],
    );
  }

  mySpecialization(icon, text) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 105,
      height: 115,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: const Color.fromARGB(255, 30, 31, 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // ignore: avoid_unnecessary_containers
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(text,
                style: TextStyle(
                    foreground: Paint()..shader = highLightGradient,
                    fontSize: 16))
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          itemBuilder: (context) => [
            PopupMenuItem(
                // ignore: sort_child_properties_last
                child: TextButton(
                  child: const Text('Projects',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'projects');
                  },
                ),
                value: 1),
            PopupMenuItem(
              // ignore: sort_child_properties_last
              child: TextButton(
                  child: const Text('About Me',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'about');
                  }),
              value: 2,
            )
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Check if the document exists and has data
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No data found for this email.'),
            );
          }
          final name = snapshot.data!['name'];
          final last = snapshot.data!['last'];
          final Occupation = snapshot.data!['occupation'];
          final projectdone = snapshot.data!['project-done'];
          final yearsworked = snapshot.data!['year-experience']; 
           final companies = snapshot.data!['no-of-companies'];

          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromARGB(255, 19, 16, 16),
                  Color.fromARGB(255, 0, 0, 0)
                ])),
            child: SlidingSheet(
              elevation: 8,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.4, 0.7, 1.0],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              // ignore: avoid_unnecessary_containers
              body: Container(
                child: Stack(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      margin: const EdgeInsets.all(40),
                      child: ShaderMask(
                        shaderCallback: (bound) {
                          return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black,
                                Colors.transparent
                              ]).createShader(
                              Rect.fromLTRB(0, 0, bound.width, bound.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.network(
                          imageUrl,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.49),
                      child: Column(
                        children: [
                          Text(
                            '$name $last',
                            style: TextStyle(
                                foreground: Paint()..shader = headerGradient,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Occupation,
                            style: TextStyle(
                                foreground: Paint()..shader = highLightGradient,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [mySkills(projectdone, '+Projects'),
                          mySkills(yearsworked, '+years Experience'),
                          mySkills(companies, 'Companies')

                          
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // ignore: prefer_const_constructors
                      Text('Specialized In',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              react
                                  ? mySpecialization(
                                      FontAwesomeIcons.react, 'React')
                                  : Text(''),
                              javascript
                                  ? mySpecialization(
                                      FontAwesomeIcons.js, 'JavaScript')
                                  : Text(''),
                              python
                                  ? mySpecialization(
                                      FontAwesomeIcons.python, 'Python')
                                  : Text(''),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              java
                                  ? mySpecialization(
                                      FontAwesomeIcons.java, 'Java')
                                  : Text(''),
                              html
                                  ? mySpecialization(
                                      FontAwesomeIcons.html5, 'HTML')
                                  : Text(''),
                              css
                                  ? mySpecialization(
                                      FontAwesomeIcons.css3, 'CSS')
                                  : Text(''),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
