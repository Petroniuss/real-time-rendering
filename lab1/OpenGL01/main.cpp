#include "mainwindow.h"
#include <QApplication>
#include <qsurfaceformat.h>

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_UseDesktopOpenGL);
    QApplication a(argc, argv);

    // necessary on macos monterey 12.6
    // otherwise opengl 2.1 would be used :/
    QSurfaceFormat format;
    format.setDepthBufferSize(24);
    format.setStencilBufferSize(8);
    format.setVersion(4, 1);
    format.setProfile(QSurfaceFormat::CoreProfile);
    QSurfaceFormat::setDefaultFormat(format);

    MainWindow w;
    w.show();

    return a.exec();
}
