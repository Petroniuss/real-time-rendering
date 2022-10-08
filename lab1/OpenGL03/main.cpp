#include "mainwindow.h"
#include <QApplication>
#include <QDebug>


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QApplication::setAttribute(Qt::AA_UseDesktopOpenGL);

    MainWindow w;
    w.show();

    return a.exec();
}
