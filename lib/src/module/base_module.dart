import 'package:flutter/material.dart';

abstract class ModuleFeaturePage {}

abstract class BaseModule {
  MaterialPage getRootWidget({ModuleFeaturePage? displayPage});
}
