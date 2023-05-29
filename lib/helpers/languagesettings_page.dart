import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr()),
        centerTitle: true,
      ),
      body: Column(children: const [
        ListTile(
          title: Text("English"),
        ),
        ListTile(
          title: Text("Francais"),
        ),
      ]),
    );
  }
}
