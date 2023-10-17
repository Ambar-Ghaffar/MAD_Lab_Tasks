import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_app/home.dart';

class About extends StatefulWidget {
  String email;
  String imageUrl;
  bool react;
  bool python;
  bool html;
  bool javascript;
  bool typescript;
  bool css;
  bool java;

  About({
    required this.email,
    required this.imageUrl,
    required this.react,
    required this.python,
    required this.html,
    required this.javascript,
    required this.typescript,
    required this.java,
    required this.css,
  });

  @override
  State<About> createState() => _AboutState(
        react: react,
        imageUrl: imageUrl,
        python: python,
        javascript: javascript,
        typescript: typescript,
        html: html,
        css: css,
        java: java,
      );
}

class _AboutState extends State<About> {
  String imageUrl;
  bool react;
  bool python;
  bool html;
  bool javascript;
  bool typescript;
  bool css;
  bool java;

  _AboutState({
    required this.react,
    required this.imageUrl,
    required this.python,
    required this.html,
    required this.javascript,
    required this.typescript,
    required this.java,
    required this.css,
  });

  final Shader headerGradient = const LinearGradient(colors: <Color>[
    Color.fromARGB(255, 0, 242, 255),
    Color.fromARGB(255, 33, 170, 97)
  ]).createShader(const Rect.fromLTWH(0, 0, 200.0, 70.0));

  final Shader highLightGradient = const LinearGradient(colors: <Color>[
    Color.fromARGB(255, 43, 255, 1),
    Color.fromARGB(255, 255, 255, 0)
  ]).createShader(const Rect.fromLTWH(0, 0, 200.0, 70.0));

  // ignore: prefer_const_constructors
  final Shader overallTextGradient = LinearGradient(colors: const <Color>[
    Color(0xFF0000FF),
    Color(0xff5b0060),
    Color(0xffa70160),
    Color(0xff870160),
    Color(0xffac255e),
    Color(0xffca485c),
    Color(0xfff39860),
    Color.fromARGB(255, 255, 89, 0)
  ]).createShader(const Rect.fromLTWH(0, 0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    print("These are the skills ${react} ${python} ${javascript} ${html}");
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
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
            return Container(
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
                                colors: [Colors.black, Colors.transparent])
                            .createShader(
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
                        top: MediaQuery.of(context).size.height * 0.55),
                    child: Column(
                      children: [
                        const Text(
                          'Hello I am',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Text(
                            '$name $last',
                            style: TextStyle(
                              foreground: Paint()..shader = headerGradient,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Occupation,
                          style: TextStyle(
                            foreground: Paint()..shader = highLightGradient,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 120,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHome(
                                    email: widget.email,
                                    python: python,
                                    react: react,
                                    html: html,
                                    javascript: javascript,
                                    typescript: typescript,
                                    imageUrl: imageUrl,
                                    css: css,
                                    java: java,
                                  ),
                                ),
                              );
                            },
                            // ignore: sort_child_properties_last
                            child: const Text('My Skills'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.linkedinIn,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.white,
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
