#version 410

// filter_fragment

in vec2 fragTexCoor;

uniform float horizontal;

out vec4 color;

uniform sampler2D textureIn;

// some fixed size
uniform float w[32];
uniform int w_size;

void main()
{
  vec2 texel = 1.0/textureSize(textureIn, 0);
  texel.x *= horizontal;
  texel.y *= (1.0 - horizontal);

  color = texture(textureIn, fragTexCoor)*w[0];
  for (int i = 1; i < w_size; i++)
    color += texture(textureIn, fragTexCoor + vec2(texel.x*i, texel.y*i))*w[i]
          +  texture(textureIn, fragTexCoor - vec2(texel.x*i, texel.y*i))*w[i];
}
