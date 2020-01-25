#!/bin/sh

#1 setup build
PROJECT=HCTServices.xcodeproj
FRAMEWORK_NAME=HCTServices
PUBLISH=./publish/sdk

if [ "$1" == "Debug" ]
then
  CONFIGURATION=Debug
else
  CONFIGURATION=Release
fi

echo "Build Mode: ${CONFIGURATION}"

OUTPUT=./build/${CONFIGURATION}-universal

#2 remove old build
rm -rf ${OUTPUT}

BUILD_DIR=~/Library/Developer/Xcode/DerivedData/${FRAMEWORK_NAME}*

for x in ${BUILD_DIR}; do rm -rf $x; done

#3 build framework
xcodebuild -project "${PROJECT}" -scheme "${FRAMEWORK_NAME}" -configuration ${CONFIGURATION} ARCHS="x86_64" VALID_ARCHS="x86_64" only_active_arch=no defines_module=yes -sdk "iphonesimulator" IPHONEOS_DEPLOYMENT_TARGET=10.0 ${XCPRETTY}
xcodebuild -project "${PROJECT}" -scheme "${FRAMEWORK_NAME}" -configuration ${CONFIGURATION} ARCHS="arm64 armv7" VALID_ARCHS="arm64 arm64e armv7 armv7s" only_active_arch=no defines_module=yes -sdk "iphoneos" IPHONEOS_DEPLOYMENT_TARGET=10.0 ${XCPRETTY}

#4 get path for build folder (due to use cocoapods, could not custom BUILD_DIR)
for x in ${BUILD_DIR}; do BUILD_DIR="$x/Build/Products"; done

mkdir -p "${OUTPUT}"

#5 copy swiftmodule for both iphoneos & iphonesimulator
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework" "${OUTPUT}/"
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/." "${OUTPUT}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"

#6 combine header for iphoneos & iphonesimulator (Xcode 10.2+ issue: 48635615)
UNIVERSAL_SWIFT_HEADER=${OUTPUT}/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h

> ${UNIVERSAL_SWIFT_HEADER}
echo "#if TARGET_OS_SIMULATOR" >> ${UNIVERSAL_SWIFT_HEADER}
cat ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
echo "#else" >> ${UNIVERSAL_SWIFT_HEADER}
cat ${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
echo "#endif" >> ${UNIVERSAL_SWIFT_HEADER} 

#7 lipo to create universal framework
lipo -create -output "${OUTPUT}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

echo "Output: ${OUTPUT}"

#8 copy to publish folder
#cp -R "${OUTPUT}/${FRAMEWORK_NAME}.framework" "${PUBLISH}/"
#echo "Copied to: ${PUBLISH}"
