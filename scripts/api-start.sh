#!/bin/bash
cd "$(dirname "$0")/../p8i_api"
dart pub get
dart run bin/api.dart
