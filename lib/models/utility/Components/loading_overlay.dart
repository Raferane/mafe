import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay extends StatelessWidget {
  final RxBool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Obx(
          () =>
              isLoading.value
                  ? Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
