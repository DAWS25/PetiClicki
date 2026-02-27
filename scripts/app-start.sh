#!/bin/bash
cd "$(dirname "$0")/../p8i_app"
flutter pub get
flutter run -d web-server --web-port=10277 --web-hostname=0.0.0.0
