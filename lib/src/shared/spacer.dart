import 'package:flutter/material.dart';

class DsSpace {
  const DsSpace._();

  static const xs = 4.0;
  static const sm = 8.0;
  static const sl = 12.0;
  static const md = 16.0;
  static const ml = 18.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 28.0;
}

class DsVerticalSpace {
  const DsVerticalSpace._();

  static get xs => const SizedBox(height: DsSpace.xs);
  static get sm => const SizedBox(height: DsSpace.sm);
  static get sl => const SizedBox(height: DsSpace.sl);
  static get md => const SizedBox(height: DsSpace.md);
  static get ml => const SizedBox(height: DsSpace.ml);
  static get lg => const SizedBox(height: DsSpace.lg);
  static get xl => const SizedBox(height: DsSpace.xl);
  static get xxl => const SizedBox(height: DsSpace.xxl);
}

class DsHorizontalSpace {
  const DsHorizontalSpace._();

  static get xs => const SizedBox(width: DsSpace.xs);
  static get sm => const SizedBox(width: DsSpace.sm);
  static get sl => const SizedBox(width: DsSpace.sl);
  static get md => const SizedBox(width: DsSpace.md);
  static get ml => const SizedBox(width: DsSpace.ml);
  static get lg => const SizedBox(width: DsSpace.lg);
  static get xl => const SizedBox(width: DsSpace.xl);
  static get xxl => const SizedBox(width: DsSpace.xxl);
}
