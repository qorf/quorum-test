#!/bin/bash
# Runs the compiled Quorum tests outside Quorum Studio. Build QuorumTest in
# Quorum Studio first, so Run/Default.jar exists. Any flags are passed on.
# It uses the JDK the tests download into Tools/ (the release in Tools.json)
# if it's there, and java from the PATH before the first run.

# run from the QuorumTest folder, wherever this script is called from
cd "$(dirname "$0")" || exit 1

if [ ! -f Run/Default.jar ]; then
    echo "Run/Default.jar is missing. Build QuorumTest in Quorum Studio first."
    exit 1
fi

JAVA=java
for candidate in Tools/jdk-*/Contents/Home/bin/java Tools/jdk-*/bin/java; do
    if [ -x "$candidate" ]; then
        JAVA="$candidate"
        break
    fi
done

# on macOS, a Quorum window must start on the first thread, as Quorum
# Studio does when it runs a program
if [ "$(uname)" = "Darwin" ]; then
    exec "$JAVA" -XstartOnFirstThread -jar Run/Default.jar "$@"
fi
exec "$JAVA" -jar Run/Default.jar "$@"
