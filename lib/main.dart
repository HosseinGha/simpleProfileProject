import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale("en");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: _themeMode == ThemeMode.dark
          ? myAppThemeConfig.dark().getTheme(_locale.languageCode)
          : myAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              _themeMode = ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguagebyUser) {
          setState(() {
            _locale = newSelectedLanguagebyUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language language) selectedLanguageChanged;
  const MyHomePage(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _Language __language = _Language.en;
  _SkillType mySkill = _SkillType.photoshop;
  void _updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this.mySkill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      __language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(Localization.appBarTitle),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Icon(CupertinoIcons.chat_bubble_2),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: InkWell(
                onTap: widget.toggleThemeMode,
                child: Icon(
                  CupertinoIcons.ellipsis_vertical,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'images/profile_image.png',
                          width: 60,
                          height: 60,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Localization.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            Localization.job,
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_circle,
                                size: 18,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(Localization.location,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                      child: Icon(
                        CupertinoIcons.heart,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(Localization.summary,
                    style: TextStyle(
                      fontSize: 12,
                    )),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Localization.selectedLanguage),
                    CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: __language,
                        children: {
                          _Language.en: Text(Localization.enLanguage,
                              style: TextStyle(fontSize: 12)),
                          _Language.fa: Text(Localization.faLanguage,
                              style: TextStyle(fontSize: 12))
                        },
                        onValueChanged: (value) {
                          if (value != null) _updateSelectedLanguage(value);
                        })
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 8, 32, 12),
                child: Row(children: [
                  Text(Localization.skills,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w900)),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(2, 7, 0, 0),
                    child: Icon(
                      CupertinoIcons.chevron_down,
                      size: 8,
                    ),
                  )
                ]),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    MySkill(
                      type: _SkillType.photoshop,
                      title: 'Photoshop',
                      imagePath: 'images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: mySkill == _SkillType.photoshop,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.photoshop);
                      },
                    ),
                    MySkill(
                      type: _SkillType.adobeXd,
                      title: 'Adobe XD',
                      imagePath: 'images/app_icon_05.png',
                      shadowColor: Color.fromARGB(255, 243, 33, 156),
                      isActive: mySkill == _SkillType.adobeXd,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.adobeXd);
                      },
                    ),
                    MySkill(
                      type: _SkillType.ilustrator,
                      title: 'ilustrator',
                      imagePath: 'images/app_icon_04.png',
                      shadowColor: Color.fromARGB(255, 247, 126, 21),
                      isActive: mySkill == _SkillType.ilustrator,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.ilustrator);
                      },
                    ),
                    MySkill(
                      type: _SkillType.afterEffect,
                      title: 'After Effect',
                      imagePath: 'images/app_icon_03.png',
                      shadowColor: Colors.blue,
                      isActive: mySkill == _SkillType.afterEffect,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.afterEffect);
                      },
                    ),
                    MySkill(
                      type: _SkillType.lightRoom,
                      title: 'Lightroom',
                      imagePath: 'images/app_icon_02.png',
                      shadowColor: Colors.blue,
                      isActive: mySkill == _SkillType.lightRoom,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.lightRoom);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Localization.personalinfo,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                          labelText: Localization.email,
                          prefixIcon: Icon(CupertinoIcons.at)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: Localization.password,
                          prefixIcon: Icon(CupertinoIcons.lock)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text(Localization.save)))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class MySkill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const MySkill(
      {super.key,
      required this.type,
      required this.title,
      required this.imagePath,
      required this.shadowColor,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRadius = BorderRadius.circular(12);
    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: isActive
            ? BoxDecoration(
                color: Color.fromARGB(12, 255, 255, 255),
                borderRadius: defaultBorderRadius)
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: shadowColor.withOpacity(0.45), blurRadius: 20)
                    ])
                  : null,
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

class myAppThemeConfig {
  static const String faPrimaryFontFamily = "Dana";
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  myAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;
  myAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        brightness: brightness,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor))),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
            backgroundColor: appBarColor,
            foregroundColor: primaryTextColor,
            elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
        ),
        textTheme:
            languageCode == "en" ? enPrimaryTextTheme : faPrimaryTextTheme);
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
            bodyText2: TextStyle(fontSize: 12, color: primaryTextColor),
            bodyText1: TextStyle(fontSize: 8, color: secondaryTextColor),
            headline6: TextStyle(
                fontWeight: FontWeight.bold, color: primaryTextColor)),
      );
  TextTheme get faPrimaryTextTheme => TextTheme(
        bodyText2: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
            button: TextStyle(fontFamily: faPrimaryFontFamily),
        bodyText1: TextStyle(
            fontSize: 8,
            color: secondaryTextColor,
            fontFamily: faPrimaryFontFamily),
        caption: TextStyle(fontFamily: faPrimaryFontFamily),
        headline6: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
      );
}

enum _SkillType { photoshop, adobeXd, ilustrator, afterEffect, lightRoom }

enum _Language { en, fa }
// Custom Profile Widget
class UserProfile extends StatelessWidget {
  final String name;
  final String job;
  final String location;

  UserProfile({required this.name, required this.job, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'images/profile_image.png',
            width: 60,
            height: 60,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(job, style: TextStyle(fontSize: 12)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(CupertinoIcons.location_circle, size: 18),
                  SizedBox(width: 4),
                  Text(location, style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Icon(CupertinoIcons.heart, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}

// Custom Skills Widget
class SkillsSection extends StatelessWidget {
  final _SkillType currentSkill;
  final Function(_SkillType) onSkillSelected;

  SkillsSection({required this.currentSkill, required this.onSkillSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      children: [
        // Add your skill widgets here using the same MySkill widget
      ],
    );
  }
}

