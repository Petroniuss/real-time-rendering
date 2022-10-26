#ifndef MODEL_H
#define MODEL_H

#include <QString>
#include <QStringList>

class Model
{
public:
    Model(): v_cnt(0), vn_cnt(0), f_cnt(0), read_normals(false), read_textures(false), vertData(0), v(0), vn(0), vt(0) {}
    ~Model() { delete [] vertData; }


    void readFile(QString fname, bool readNormals, bool readTextures, float scale);

    float *getVertData() {
        return vertData;
    }

    int getVertDataStride() { return stride; }

    int getVertDataCount() {
        return f_cnt * stride * 10;
    }

    int getVertDataSize() {
        return getVertDataCount() * sizeof(float);
    }

    int* getEBOIndices() {
        return ebo_indices;
    }

    int getEBOIndicesCount() {
        return 3 * f_cnt;
    }

    int getEBOIndicesSize() {
        return getEBOIndicesCount() * sizeof(int);
    }

private:
    QStringList source;
    int v_cnt, vn_cnt, vt_cnt, f_cnt, stride;
    bool read_normals, read_textures;
    float *vertData;
    float *v, *vn, *vt;

    int* ebo_indices;

    void count_items();
    void alloc_items();
    void parse_items(float scale);
    void print();
};

#endif // MODEL_H
