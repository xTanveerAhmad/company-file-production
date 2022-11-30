import 'package:epp_film/provider/searchstate.dart';
import 'package:epp_film/ui/page/allitempage.dart';
import 'package:epp_film/ui/page/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'cors/firebase_options.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchState()),
      ],
      child: GetMaterialApp(
        title: 'EPP film production company',
        debugShowCheckedModeBanner: false,
        home: user.currentUser != null?const AllItemsPage():const LoginPage(),
      ),
    );
  }
}
