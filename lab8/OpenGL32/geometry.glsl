#version 410

layout (triangles) in;
layout (triangle_strip, max_vertices=18) out;

in vec3 geoNormal[];
in vec4 geoPos[];

flat out float useColor;
out vec3 fragNormal;
out vec4 fragPos;
out vec4 fragColor;

uniform mat4 p_matrix;
uniform mat4 v_matrix;
uniform mat4 m_matrix;

uniform int slider;

void drawTriangle(vec3 geoNormalA, vec3 geoNormalB, vec3 geoNormalC,
                  vec4 geoPosA, vec4 geoPosB, vec4 geoPosC,
                  vec4 A, vec4 B, vec4 C,
                  out vec3 geoNormalAB, out vec3 geoNormalBC, out vec3 geoNormalCA,
                  out vec4 geoPosAB, out vec4 geoPosBC, out vec4 geoPosCA,
                  out vec4 AB, out vec4 BC, out vec4 CA
                  ) {

    geoNormalAB = (geoNormalA + geoNormalB)/2.0;
    geoPosAB = (geoPosA + geoPosB)/2.0;
    AB = (A + B) / 2.0;
    fragNormal = geoNormalAB;
    fragColor = vec4(abs(fragNormal), 1.0);
    fragPos = geoPosAB;
    gl_Position = AB;
    EmitVertex();


    geoNormalBC = (geoNormalB + geoNormalC)/2.0;
    geoPosBC = (geoPosB + geoPosC)/2.0;
    BC = (B + C) / 2.0;
    fragNormal = geoNormalBC;
    fragColor = vec4(abs(fragNormal), 1.0);
    fragPos = geoPosBC;
    gl_Position = BC;
    EmitVertex();

    geoNormalCA = (geoNormalC + geoNormalA)/2.0;
    geoPosCA = (geoPosC + geoPosA)/2.0;
    CA = (C + A) / 2.0;
    fragNormal = geoNormalCA;
    fragColor = vec4(abs(fragNormal), 1.0);
    fragPos = geoPosCA;
    gl_Position = CA;
    EmitVertex();

    fragNormal = geoNormalAB;
    fragColor = vec4(abs(fragNormal), 1.0);
    fragPos = geoPosAB;
    gl_Position = AB;
    EmitVertex();

    EndPrimitive();
}


void main()
{

        useColor = 0;

        // first level.
        vec4 A = gl_in[0].gl_Position;
        vec4 B = gl_in[1].gl_Position;
        vec4 C = gl_in[2].gl_Position;

        vec3 geoNormalA = geoNormal[0];
        vec3 geoNormalB = geoNormal[1];
        vec3 geoNormalC = geoNormal[2];

        vec4 geoPosA = geoPos[0];
        vec4 geoPosB = geoPos[1];
        vec4 geoPosC = geoPos[2];

        // first level.
        vec4 AB = gl_in[0].gl_Position;
        vec4 BC = gl_in[1].gl_Position;
        vec4 CA = gl_in[2].gl_Position;

        vec3 geoNormalAB = geoNormal[0];
        vec3 geoNormalBC = geoNormal[1];
        vec3 geoNormalCA = geoNormal[2];

        vec4 geoPosAB = geoPos[0];
        vec4 geoPosBC = geoPos[1];
        vec4 geoPosCA = geoPos[2];

        // draw A-B-C
        drawTriangle(geoNormalA, geoNormalB, geoNormalC,
                     geoPosA, geoPosB, geoPosC,
                     A, B, C,
                     geoNormalAB, geoNormalBC, geoNormalCA,
                     geoPosAB, geoPosBC, geoPosCA,
                     AB, BC, CA);

        // some temporary variables.
        vec4 ABtemp = gl_in[0].gl_Position;
        vec4 BCtemp = gl_in[1].gl_Position;
        vec4 CAtemp = gl_in[2].gl_Position;

        vec3 geoNormalABtemp = geoNormal[0];
        vec3 geoNormalBCtemp = geoNormal[1];
        vec3 geoNormalCAtemp = geoNormal[2];

        vec4 geoPosABtemp = geoPos[0];
        vec4 geoPosBCtemp = geoPos[1];
        vec4 geoPosCAtemp = geoPos[2];


        // draw AB-B-BC
        drawTriangle(geoNormalAB, geoNormalB, geoNormalBC,
                     geoPosAB, geoPosB, geoPosBC,
                     AB, B, BC,
                     geoNormalABtemp, geoNormalBCtemp, geoNormalCAtemp,
                     geoPosABtemp, geoPosBCtemp, geoPosCAtemp,
                     ABtemp, BCtemp, CAtemp);

        // draw A-AB-AC
        drawTriangle(geoNormalA, geoNormalAB, geoNormalCA,
                     geoPosA, geoPosAB, geoPosCA,
                     A, AB, CA,
                     geoNormalABtemp, geoNormalBCtemp, geoNormalCAtemp,
                     geoPosABtemp, geoPosBCtemp, geoPosCAtemp,
                     ABtemp, BCtemp, CAtemp);

        // draw AC-BC-C
        drawTriangle(geoNormalCA, geoNormalBC, geoNormalC,
                     geoPosCA, geoPosBC, geoPosC,
                     CA, BC, C,
                     geoNormalABtemp, geoNormalBCtemp, geoNormalCAtemp,
                     geoPosABtemp, geoPosBCtemp, geoPosCAtemp,
                     ABtemp, BCtemp, CAtemp);



  // trojkat

//  useColor = 1;
//  fragNormal = geoNormal[0];
//  fragPos = geoPos[0];
//  gl_Position = gl_in[0].gl_Position;
//  EmitVertex();

//  fragNormal = geoNormal[1];
//  fragPos = geoPos[1];
//  gl_Position = gl_in[1].gl_Position;
//  EmitVertex();

//  fragNormal = geoNormal[2];
//  fragPos = geoPos[2];
//  gl_Position = gl_in[2].gl_Position;
//  EmitVertex();

//  fragNormal = geoNormal[0];
//  fragPos = geoPos[0];
//  gl_Position = gl_in[0].gl_Position;
//  EmitVertex();

//  EndPrimitive();


  // normalna

  useColor = 1;
  mat4 pvm_matrix = p_matrix*v_matrix*m_matrix;

  fragNormal = (geoNormal[0] + geoNormal[1] + geoNormal[2])/3.0;
  fragColor = vec4(abs(fragNormal), 1.0);
  fragPos = (geoPos[0] + geoPos[1] + geoPos[2])/3.0;
  gl_Position = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position)/3.0;
  EmitVertex();

  fragPos += vec4(fragNormal, 0.0);
  gl_Position += pvm_matrix*vec4(fragNormal, 0.0)*0.001*slider;
  EmitVertex();

  EndPrimitive();
}
