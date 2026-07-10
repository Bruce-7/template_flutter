part of 'page.dart';

extension ExamplePageWidget on ExamplePage {
  Widget _buildDropdownPopup(BuildContext context) {
    return DropdownPopup(
      // showOverlay: false,
      // isActive: true,
      // isForbidClick: true,
      // leftOffset: 80,
      // rightOffset: 80,
      backgroundColor: context.colors.scrim,
      // direction: DropdownPopupDirection.up,
      // barrierBackgroundColor: context.colors.surface,
      // nodeBackgroundColor: context.colors.transparent,
      // alignment: Alignment.bottomLeft,
      // childBackgroundColor: context.colors.surface,
      nodeWidget: Text(
        '自定义下拉菜单'.tr(),
        style: context.textStyle.labelLarge,
      ),
      child: Container(
        height: 70,
        width: 60,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.outline, width: context.spacing.strokeThin),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '点我1'.tr(),
                style: context.textStyle.labelLarge,
              ),
              Text(
                '点我2'.tr(),
                style: context.textStyle.labelLarge,
              ),
              Text(
                '点我3'.tr(),
                style: context.textStyle.labelLarge,
              ),
              Text(
                '点我4'.tr(),
                style: context.textStyle.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcons(BuildContext context) {
    return Row(
      children: [
        Assets.icons.assets.svg(
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            context.colors.onSurface,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 20),
        Assets.icons.setting.svg(
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            context.colors.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<int> indexState,
    ValueNotifier<Locale> dropdownState,
    ValueNotifier<Set<ExampleNumbers>> multiSelectedState,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            indexState.value++;
          },
          child: Text('${'TextButton'.tr()}${indexState.value}'),
        ),
        TextButton.icon(
          onPressed: () {
            CommonUtil.showToast('showToast TextButton.icon'.tr());
          },
          icon: const Icon(Icons.add),
          label: Text('TextButton.icon'.tr()),
        ),
        IconButton(
          onPressed: () {
            ActionDialog(
              title: '温馨提示'.tr(),
              subTitle: '这是一个IconButton'.tr(),
              content: '这是开始到结尾了好好生活，说几句话就是厉害，说到居委会。'.tr(),
              mainButtonText: '确定'.tr(),
              subButtonText: '取消'.tr(),
              showCloseButton: true,
              contentAlign: TextAlign.left,
              style: ActionDialogStyle.sheet,
              showViewPaddingBottom: true,
              // vertical: true,
            ).show(context);
          },
          icon: const Icon(Icons.home),
        ),
        const SizedBox(height: 2),
        FilledButton(
          onPressed: () async {
            CommonUtil.showToast('打印日志'.tr());

            log.d('打印测试日志');
          },
          child: Text(
            'FilledButton 打印测试日志'.tr(),
          ),
        ),
        const SizedBox(height: 2),
        OutlinedButton(
          onPressed: () {
            ActionDialog(
              title: '温馨提示'.tr(),
              // subTitle: '这是一个弹窗',
              content: '这是开始到结尾了好好生活，说几句话就是厉害，说到居委会。'.tr(),
              mainButtonText: '确定'.tr(),
              subButtonText: '取消'.tr(),
              vertical: true,
            ).show(context);
          },
          child: Text('OutlinedButton'.tr()),
        ),
        const SizedBox(height: 2),
        ElevatedButton(
          onPressed: () {
            RoutesNavigator.push(const NotFoundRoute());
          },
          child: Text('ElevatedButton push not_found页面'.tr()),
        ),
        const SizedBox(height: 2),
        FilledButton(
          onPressed: () {
            CommonUtil.showToast('resetLocale'.tr());
            context.resetLocale();
            dropdownState.value = context.locale;
          },
          child: Text(
            'FilledButton resetLocale'.tr(),
          ),
        ),
        const SizedBox(height: 2),
        DropdownButton<Locale>(
          dropdownColor: context.colors.surface,
          // 下拉菜单背景色
          icon: Icon(Icons.keyboard_arrow_down, color: context.colors.onSurface),
          // 自定义图标
          underline: const SizedBox(),
          // 移除下划线
          borderRadius: BorderRadius.circular(8),
          padding: EdgeInsets.zero,
          // 圆角
          value: dropdownState.value,
          onChanged: (Locale? newValue) {
            if (newValue == null) return;

            log.d(newValue.languageCode);

            dropdownState.value = newValue;
            CommonUtil.showToast('切换'.tr() + newValue.languageCode);
            context.setLocale(newValue);
          },

          items: Translations.supportedLocales.map((Locale value) {
            return DropdownMenuItem<Locale>(
              value: value,
              child: Text(value.languageCode),
            );
          }).toList(),
        ),

        DropdownButtonFormField<Locale>(
          initialValue: dropdownState.value,
          dropdownColor: context.colors.surface,
          // 下拉菜单背景色
          icon: const Icon(Icons.arrow_drop_down),
          // 自定义图标
          borderRadius: BorderRadius.circular(8),
          padding: EdgeInsets.zero,
          decoration: InputDecoration(
            labelText: '语言测试-请选择语言'.tr(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: Translations.supportedLocales.map((Locale value) {
            return DropdownMenuItem<Locale>(
              value: value,
              child: Text(value.languageCode),
            );
          }).toList(),
          onChanged: (Locale? newValue) {
            if (newValue == null) return;

            log.d(newValue.languageCode);

            dropdownState.value = newValue;
            CommonUtil.showToast('切换'.tr() + newValue.languageCode);
            context.setLocale(newValue);
          },
        ),
        SegmentedButton(
          segments: const [
            ButtonSegment(
              label: Text('111'),
              icon: Icon(Icons.add),
              value: ExampleNumbers.one,
              enabled: false,
            ),
            ButtonSegment(
              label: Text('222'),
              icon: Icon(Icons.favorite),
              value: ExampleNumbers.two,
            ),
            ButtonSegment(
              label: Text('333'),
              icon: Icon(Icons.do_not_disturb),
              value: ExampleNumbers.three,
            ),
          ],
          multiSelectionEnabled: true,
          selected: multiSelectedState.value,
          onSelectionChanged: (Set<ExampleNumbers> newSelected) {
            // 点击时切换按钮，如果是已经选择的就变成未选择
            log.d("changed $newSelected");
            multiSelectedState.value = newSelected;
          },
        ),
        RawMaterialButton(
          onPressed: () {
            CommonUtil.showToast('RawMaterialButton');
          },
          fillColor: context.colors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.access_alarm),
        ),
        MaterialButton(
          onPressed: () {
            _loggerExample();
          },
          child: Text('MaterialButton 打印日志'.tr()),
        ),
        Text(
          '我是底部'.tr(),
          style: context.textStyle.bodyMedium,
        )
        // const DrawerButton(),
        // const BackButton(),
        // const CloseButton(),
      ],
    );
  }

  Widget _buildGroupedListView(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GroupedListView(
        groupCount: 10,
        // pinned: false, // 支持不吸顶
        itemCount: (groupIndex) {
          return 15;
        },
        groupHeaderBuilder: (index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              alignment: Alignment.center,
              color: context.colors.surface,
              child: Text(
                'Group Header $index'.tr(),
                style: context.textStyle.titleMedium,
              ),
            ),
          );
        },
        itemBuilder: (groupIndex, index) {
          return Text(
            'Item $index'.tr(),
            style: context.textStyle.bodyMedium,
          );
        },
        itemSeparatorBuilder: (groupIndex, index) {
          return const Divider();
        },
      ),
    );
  }
}
