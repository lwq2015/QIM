TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
OUTDIR = $${PWD}/build
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
