
OUTPUT_DIR="`pwd`/bin"
NAME="ForceQuitUnresponsiveApps"
PROJECT="`pwd`/$NAME/$NAME.xcodeproj"

xcodebuild \
  -project "$PROJECT" \
  -scheme $NAME \
  -configuration Release \
  CONFIGURATION_BUILD_DIR="$OUTPUT_DIR"
