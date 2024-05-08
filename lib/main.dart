import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tctt_mobile/app.dart';
import 'package:tctt_mobile/bloc_observer.dart';
import 'package:tctt_mobile/services/firebase_service.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Bloc.observer = const AppBlocObserver();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getTemporaryDirectory(),
      );

      await FirebaseService.init();

      await dotenv.load(fileName: ".env");

      runApp(const App());
    },
    (error, stack) => log(error.toString(), stackTrace: stack),
  );
}
