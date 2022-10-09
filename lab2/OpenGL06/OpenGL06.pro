#-------------------------------------------------
#
# Project created by QtCreator
#
#-------------------------------------------------

QT       += core gui widgets openglwidgets

TARGET = OpenGL06
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    widgetopengl.cpp

HEADERS  += mainwindow.h \
    widgetopengl.h

FORMS    += mainwindow.ui

DISTFILES += \
    readme.txt \
    fragment.glsl \
    vertex.glsl
