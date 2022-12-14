#version 450

layout (quads, fractional_odd_spacing) in;
//layout (quads) in;

in vec2 tesCoor[];

uniform mat4 pvm_matrix;
layout (binding = 1) uniform sampler2D textureHeight;

out vec2 fragTexCoor;

void main()
{
  vec2 t01 = mix(tesCoor[0], tesCoor[1], gl_TessCoord.y);
  vec2 t32 = mix(tesCoor[3], tesCoor[2], gl_TessCoord.y);

  fragTexCoor = mix(t01, t32, gl_TessCoord.x);

  vec4 s01 = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.y);
  vec4 s32 = mix(gl_in[3].gl_Position, gl_in[2].gl_Position, gl_TessCoord.y);

  gl_Position = mix(s01, s32, gl_TessCoord.x);
  gl_Position.y += texture(textureHeight, fragTexCoor).x;

  gl_Position = pvm_matrix*gl_Position;
}
