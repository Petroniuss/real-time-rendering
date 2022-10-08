#-------------------------------------------------
#
# Project created by QtCreator
#
#-------------------------------------------------

QT       += core gui widgets openglwidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = OpenGL04
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    widgetopengl.cpp

HEADERS  += mainwindow.h \
    widgetopengl.h

FORMS    += mainwindow.ui

DISTFILES += \
    readme.txt
