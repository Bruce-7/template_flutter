import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

// const FocusDetectorForFlutterBoost = true;

// 监测Widget是否可见性（生命周期使用）。每当小部件在屏幕上出现或消失时，都会触发回调。
class FocusDetector extends StatefulWidget {
  const FocusDetector({
    required this.child,
    this.onFocusGained,
    this.onFocusLost,
    this.onVisibilityGained,
    this.onVisibilityLost,
    this.onForegroundGained,
    this.onForegroundLost,
    super.key,
  });

  // 当该 widget 可见或进入前台时触发的回调。
  final VoidCallback? onFocusGained;

  // 当该 widget 不可见或进入后台时触发的回调。
  final VoidCallback? onFocusLost;

  // 当该 widget 在屏幕上变得可见时触发的回调。
  final VoidCallback? onVisibilityGained;

  // 当该 widget 不再可见时触发的回调。
  final VoidCallback? onVisibilityLost;

  // 当应用恢复到前台时触发的回调。
  final VoidCallback? onForegroundGained;

  // 当应用进入后台时触发的回调。
  final VoidCallback? onForegroundLost;

  // 需要监测的 widget。
  final Widget child;

  @override
  State<FocusDetector> createState() {
    // if (FocusDetectorForFlutterBoost) {
    //   return _FocusDetectorStateForFlutterBoost();
    // } else {
    return _FocusDetectorState();
    // }
  }
}

class _FocusDetectorState extends State<FocusDetector> with WidgetsBindingObserver {
  final _visibilityDetectorKey = UniqueKey();

  // 此 Widget 当前在应用程序中是否可见。
  bool _isWidgetVisible = false;

  // 应用程序是否位于前台。
  bool _isAppInForeground = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notifyPlaneTransition(state);
  }

  // 通知应用程序从前台转入/转出。
  void _notifyPlaneTransition(AppLifecycleState state) {
    if (!_isWidgetVisible) {
      return;
    }

    final isAppResumed = state == AppLifecycleState.resumed;
    final wasResumed = _isAppInForeground;
    if (isAppResumed && !wasResumed) {
      _isAppInForeground = true;
      _notifyFocusGain();
      _notifyForegroundGain();
      return;
    }

    final isAppPaused = state == AppLifecycleState.paused;
    if (isAppPaused && wasResumed) {
      _isAppInForeground = false;
      _notifyFocusLoss();
      _notifyForegroundLoss();
    }
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: _visibilityDetectorKey,
        onVisibilityChanged: (visibilityInfo) {
          final visibleFraction = visibilityInfo.visibleFraction;
          _notifyVisibilityStatusChange(visibleFraction);
        },
        child: widget.child,
      );

  // 通知部件可见性的变化。
  void _notifyVisibilityStatusChange(double newVisibleFraction) {
    if (!_isAppInForeground) {
      return;
    }

    final wasFullyVisible = _isWidgetVisible;
    final isFullyVisible = newVisibleFraction == 1;
    if (!wasFullyVisible && isFullyVisible) {
      _isWidgetVisible = true;
      _notifyFocusGain();
      _notifyVisibilityGain();
    }

    final isFullyInvisible = newVisibleFraction == 0;
    if (wasFullyVisible && isFullyInvisible) {
      _isWidgetVisible = false;
      _notifyFocusLoss();
      _notifyVisibilityLoss();
    }
  }

  void _notifyFocusGain() {
    final onFocusGained = widget.onFocusGained;
    if (onFocusGained != null) {
      onFocusGained();
    }
  }

  void _notifyFocusLoss() {
    final onFocusLost = widget.onFocusLost;
    if (onFocusLost != null) {
      onFocusLost();
    }
  }

  void _notifyVisibilityGain() {
    final onVisibilityGained = widget.onVisibilityGained;
    if (onVisibilityGained != null) {
      onVisibilityGained();
    }
  }

  void _notifyVisibilityLoss() {
    final onVisibilityLost = widget.onVisibilityLost;
    if (onVisibilityLost != null) {
      onVisibilityLost();
    }
  }

  void _notifyForegroundGain() {
    final onForegroundGained = widget.onForegroundGained;
    if (onForegroundGained != null) {
      onForegroundGained();
    }
  }

  void _notifyForegroundLoss() {
    final onForegroundLost = widget.onForegroundLost;
    if (onForegroundLost != null) {
      onForegroundLost();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
