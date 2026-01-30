#!/bin/bash
# filepath: /workspaces/images/src/java/download-jdk.sh

set -e

# Check if Java version is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <java-version>"
    echo "Example: $0 25"
    exit 1
fi

TARGET_JAVA_VERSION="$1"

# Determine architecture
arch="$(dpkg --print-architecture)"
case "$arch" in
    "amd64")
        jdkUrl="https://aka.ms/download-jdk/microsoft-jdk-${TARGET_JAVA_VERSION}-linux-x64.tar.gz"
        ;;
    "arm64")
        jdkUrl="https://aka.ms/download-jdk/microsoft-jdk-${TARGET_JAVA_VERSION}-linux-aarch64.tar.gz"
        ;;
    *)
        echo >&2 "error: unsupported architecture: '$arch'"
        exit 1
        ;;
esac

echo "Downloading Microsoft OpenJDK ${TARGET_JAVA_VERSION} for ${arch}..."

# Download JDK and checksum
wget --progress=dot:giga -O msopenjdk.tar.gz "${jdkUrl}"
wget --progress=dot:giga -O sha256sum.txt "${jdkUrl}.sha256sum.txt"

# Validate checksum
echo "Validating checksum..."
sha256sumText=$(cat sha256sum.txt)
sha256=$(expr substr "${sha256sumText}" 1 64)
echo "${sha256} msopenjdk.tar.gz" | sha256sum --strict --check -

if [ $? -eq 0 ]; then
    echo "Checksum validation successful!"
else
    echo "Checksum validation failed!"
    rm -f msopenjdk.tar.gz sha256sum.txt
    exit 1
fi

# Cleanup
echo "Cleaning up downloaded files..."
rm -f msopenjdk.tar.gz sha256sum.txt

echo "Done!"

