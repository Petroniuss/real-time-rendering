#version 410

struct Light
{
    vec3 pos;
    vec3 color;
};

struct Material
{
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};

in vec4 fragPos;
in vec3 fragNormal;

uniform vec3 eyePos;
uniform Light light;
uniform Material material;
uniform samplerCube textureSkybox;
uniform int slider;
uniform float refractionIndex;

out vec4 color;

void main()
{
//  this is it!
//  float ratio = 1.0 / 1.52;
  float ratio = 1.0 / refractionIndex;
  vec3 I = normalize(fragPos.xyz - eyePos);
  vec3 R = refract(I, normalize(fragNormal), ratio);

  // diffuse
  vec3 lightDir = normalize(light.pos - fragPos.xyz);
  vec3 diffuse = max(dot(fragNormal, lightDir), 0.0)*light.color*material.diffuse;

  // specular
  vec3 viewDir = normalize(eyePos - fragPos.xyz);
  vec3 reflDir = reflect(-lightDir, fragNormal);
  vec3 specular = pow(max(dot(viewDir, reflDir), 0.0), material.shininess)*light.color*material.specular;

  vec3 refracted = texture(textureSkybox, R).rgb;
  if (int(gl_FragCoord.x) < slider)
    refracted = vec3(0.0, 0.0, 0.0);

  color = vec4(material.ambient + diffuse + specular + refracted, 1.0);
}
