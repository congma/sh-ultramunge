echo 'TEST: add non-empty element to empty sequence'
TARGET_PATH=
ultramunge /tmp TARGET_PATH
[ "$TARGET_PATH" = /tmp ]
