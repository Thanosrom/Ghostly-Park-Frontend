// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, file_names
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Libs
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Settings_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/ImagePath.dart';

Future<void> uploadPhoto(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    Provider.of<ImageState>(context, listen: false)
        .setImagePath(pickedFile.path);
  }
}

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

void change_Language_State(String languageCode) {
  save_Selected_Language(languageCode);
}

Future<void> change_Language(BuildContext context) async {
  initializeSettings(context);
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        color: Color.fromARGB(255, 30, 39, 78).withOpacity(0.4),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Height_Spacer(),
                Height_Spacer(),
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.select_your_language,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'English',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('en');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Ελληνικά',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('gr');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Español',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('es');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Português',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('por');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Français',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('fr');
                    initializeSettings(context);
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Deutsch',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('de');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: 'Русский',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('ru');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: '日本語',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('ja');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: '中文',
                  icon: Icons.language,
                  onPressed: () {
                    change_Language_State('ch');
                    initializeSettings(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Report_Modal(
                          context: context,
                          labelTexts: AppLocale.getString(
                              context, AppLocale.changed_small_text,
                              languageCode: current_locale),
                          its_error: false,
                          is_changed: true,
                        );
                      },
                    );
                  },
                ),
                Height_Spacer(),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(context, AppLocale.back_button,
                      languageCode: current_locale),
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Go_Back(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
