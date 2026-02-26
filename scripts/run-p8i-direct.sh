#!/bin/bash
cd "$(dirname "$0")/.."
cd p8i_app
flutter pub get
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
