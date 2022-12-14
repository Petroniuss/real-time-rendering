#ifndef WIDGETOPENGL_H
#define WIDGETOPENGL_H

#include <QOpenGLWidget>
#include <QOpenGLFunctions_1_0>
#include <QOpenGLFunctions_4_1_Core>
#include <QMatrix4x4>

#include "light.h"
#include "material.h"


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
    WidgetOpenGL(QWidget *parent = 0): QOpenGLWidget(parent), slider(0) 
    {
        QSurfaceFormat sfm = QSurfaceFormat::defaultFormat();
        sfm.setSamples(4);
        setFormat(sfm);
    }


    void v_transform(float rot_x, float rot_y, float rot_z, float zoom);
    void move_light(float x, float y, float z);
    void move_slider(int _slider);
    void readTexture();

protected:
    bool init_ok;
    int triangles_cnt, triangles_transparent_cnt, triangles_floor_cnt;

    QMatrix4x4 m_matrix, v_matrix, p_matrix, l_matrix;
    int slider;

    Light light;

    GLuint shaderProgram, shaderProgramShadow;
    GLuint VAO, VAO_transparents, VAO_floor, TEX, TEX_floor, TEX_FBO_DEPTH;
    GLuint FBO;

    GLuint loadShader(GLenum type, QString fname);
    GLuint linkProgram(GLuint vertex_shader, GLuint fragment_shader, GLuint geometry_shader = 0, GLuint tess_eval_shader = 0, GLuint tess_control_shader = 0);
    GLuint loadTexture2D(QString fname, int clamp_mode);
    GLuint loadTextureCube(QString fname, QString fext);
    GLuint getUniformLocation(GLuint program, const GLchar *uniform);
    GLuint getAttribLocation(GLuint program, const GLchar *attrib);
    QMatrix3x3 upperLeftMatrix3x3(QMatrix4x4 const &m);

    void initializeGL();
    void paintGL();
    void resizeGL(int w, int h);
    float f_rand(float min, float max);

    void makeShadowMatrix();
    void paintScene(GLboolean gen_shadow_map, GLboolean paint_transparents);
};


#endif // WIDGETOPENGL_H
