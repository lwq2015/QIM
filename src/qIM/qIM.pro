TEMPLATE = app

QT += qml quick webengine widgets
CONFIG += c++11

SOURCES += main.cpp
OTHER_FILES += \
    skin/*.qml \
    skin/images/*.png \

RESOURCES += qml.qrc

lupdate_only{
SOURCES =  \
          skin/*.qml \

}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
OUTDIR = $${PWD}/../../build
win32:Debug{
        DESTDIR += $${OUTDIR}/bin/debug
        OBJECTS_DIR += $${OUTDIR}/obj/$${TARGET}/debug
    }
win32:Release{
    DESTDIR += $${OUTDIR}/bin/release
    OBJECTS_DIR += $${OUTDIR}/obj/$${TARGET}/release
}

UI_DIR +=  $${OUTDIR}/forms/$${TARGET}
RCC_DIR += $${OUTDIR}/temp/$${TARGET}
MOC_DIR += $${OUTDIR}/temp/$${TARGET}

TRANSLATIONS += i18n/qim_zh_CN.ts

DISTFILES += \
    skin/HLine.qml \
    skin/SystemButton.qml \
    skin/VLine.qml
