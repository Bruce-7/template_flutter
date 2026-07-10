import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gen/assets.gen.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/managers/translations.dart';
import 'package:flutter_app/routes/routes.gr.dart';
import 'package:flutter_app/routes/routes_navigator.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:flutter_app/widgets/dropdown/dropdown_popup.dart';
import 'package:flutter_app/widgets/focus_detector.dart';
import 'package:flutter_app/widgets/grouped_list/grouped_list_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'widget.dart';

enum ExampleNumbers { one, two, three, four }

@RoutePage()
class ExamplePage extends HookConsumerWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () {
        log.d('$this dispose');
      };
    }, []);

    // final User user = ref.watch(userLoginProvider);
    // var watch = ref.watch(apiUserLoginProvider(username: "", password: "password"));

    final indexState = useState(0);
    final dropdownState = useState<Locale>(context.locale);
    final multiSelectedState = useState<Set<ExampleNumbers>>({ExampleNumbers.two, ExampleNumbers.three});

    return Scaffold(
      appBar: AppBar(
        title: Text('测试页面'.tr()),
      ),
      body: SafeArea(
        bottom: false,
        child: FocusDetector(
          onFocusGained: () {
            log.d('$this onFocusGained');
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: CommonUtil.bottomViewPadding(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // watch.when(
                //     data: (data){
                //       return Text(data.message??"");
                //     },
                //     error: (e,s)=> Text(e.toString()??""),
                //     loading: (){
                //       return CircularProgressIndicator();
                //     }),

                _buildGroupedListView(context),
                const SizedBox(height: 20),

                _buildIcons(context),
                const SizedBox(height: 20),

                _buildDropdownPopup(context),
                const SizedBox(height: 20),

                _buildButtons(context, ref, indexState, dropdownState, multiSelectedState),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var test = await ref.read(apiServiceTestProvider.future);
          // var test = await ref.read(apiServiceTest1Provider.future);

          if (context.mounted) {
            // CommonUtil.showToast(test.message ?? '');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(test.message.toString()),
            //   ),
            // );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
