#-------------------------------------------------
#
# Project created by QtCreator
#
#-------------------------------------------------

QT       += core gui widgets openglwidgets

TARGET = OpenGL36
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    widgetopengl.cpp \
    model.cpp

HEADERS  += mainwindow.h \
    widgetopengl.h \
    model.h \
    light.h \
    material.h

FORMS    += mainwindow.ui

DISTFILES += \
    readme.txt \
    shading_fragment.glsl \
    shading_vertex.glsl \
    filter_fragment.glsl \
    filter_vertex.glsl \
    hdr_vertex.glsl \
    hdr_fragment.glsl \
    shadowmap_fragment.glsl \
    shadowmap_vertex.glsl \
    shadowmap_geometry.glsl
