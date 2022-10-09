#ifndef WIDGETOPENGL_H
#define WIDGETOPENGL_H

#include <QOpenGLWidget>
#include <QOpenGLFunctions_1_0>
#include <QOpenGLFunctions_4_1_Core>

#define MIN_OPENGL_VERSION "4.1"


class OpenGLVersionTest: public QOpenGLFunctions_4_1_Core
{
public:
    QString version()
    {
        initializeOpenGLFunctions();
        return (char *)glGetString(GL_VERSION);
    }
};


class WidgetOpenGL: public QOpenGLWidget, public QOpenGLFunctions_4_1_Core
{
public:
    WidgetOpenGL(QWidget *parent = 0): QOpenGLWidget(parent){}


protected:
    bool init_ok;

    GLuint shaderProgram;
    GLuint VAO;

    GLuint loadShader(GLenum type, QString fname); // !!!

    void initializeGL();
    void paintGL();
};

#endif // WIDGETOPENGL_H
