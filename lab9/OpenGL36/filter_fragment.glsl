#version 410

// filter_fragment

in vec2 fragTexCoor;

uniform float horizontal;

out vec4 color;

uniform sampler2D textureIn;

void main()
{

  float w[5];
  w[0] = 0.227027;
  w[1] = 0.1945946;
  w[2] = 0.1216216;
  w[3] = 0.054054;
  w[4] = 0.016216;


  vec2 texel = 1.0/textureSize(textureIn, 0);
  texel.x *= horizontal;
  texel.y *= (1.0 - horizontal);

  color = texture(textureIn, fragTexCoor)*w[0];
  for (int i = 1; i < w.length(); i++)
    color += texture(textureIn, fragTexCoor + vec2(texel.x*i, texel.y*i))*w[i]
          +  texture(textureIn, fragTexCoor - vec2(texel.x*i, texel.y*i))*w[i];
}
