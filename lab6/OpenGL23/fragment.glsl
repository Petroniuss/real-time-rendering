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
    float useTex;
};

//in vec4 fragPos;
in vec2 fragTexCoor;
in vec3 fragTanEyePos;
in vec3 fragTanLightPos;
in vec3 fragTanFragPos;
in vec3 fragTanNormal;

uniform vec3 eyePos;
uniform Light light;
uniform Material material;

uniform sampler2D textureColor;
uniform sampler2D textureNormal;
uniform sampler2D textureDepth;

uniform int slider;
uniform float paralaxHeightSlider;
uniform float maxLayersSlider;

out vec4 color;


vec2 ParallaxMapping(vec2 texCoor, vec3 viewDir)
{
    const float height_scale = 2.0/128.0;

    float height = texture(textureDepth, texCoor).r;
    vec2 p = viewDir.xy / viewDir.z * (height * height_scale);
    return texCoor - p;
}


vec2 ParallaxMapping_Steep(vec2 texCoords, vec3 viewDir)
{

     const float height_scale = 2.0/128.0;

    const float minLayers = 2;
    // todo: :)
    const float maxLayers = 10;

    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    vec2 P = viewDir.xy / viewDir.z * height_scale;
    vec2 deltaTexCoords = P / numLayers;

    vec2  currentTexCoords     = texCoords;
    float currentDepthMapValue = texture(textureDepth, currentTexCoords).r;

    int cnt = 0;
    while (currentLayerDepth < currentDepthMapValue && cnt < numLayers)
    {
        currentTexCoords -= deltaTexCoords;
        currentDepthMapValue = texture(textureDepth, currentTexCoords).r;
        currentLayerDepth += layerDepth;

        cnt++;
    }

    return currentTexCoords;
}


vec2 ParallaxMapping_Steep2(vec2 texCoords, vec3 viewDir, float paralaxHeightSlider, float maxLayers)
{

//    const float height_scale = 2.0/128.0;
    float height_scale = paralaxHeightSlider / 128.0;

    const float minLayers = 2;
    // maxLayers.
//    const float maxLayers = 10;

    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    vec2 P = viewDir.xy / viewDir.z * height_scale;
    vec2 deltaTexCoords = P / numLayers;

    vec2  currentTexCoords     = texCoords;
    float currentDepthMapValue = texture(textureDepth, currentTexCoords).r;

    int cnt = 0;
    while(currentLayerDepth < currentDepthMapValue && cnt < numLayers)
    {
        currentTexCoords -= deltaTexCoords;
        currentDepthMapValue = texture(textureDepth, currentTexCoords).r;
        currentLayerDepth += layerDepth;

        cnt++;
    }

    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;

    float afterDepth  = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = texture(textureDepth, prevTexCoords).r - currentLayerDepth + layerDepth;

    float weight = afterDepth / (afterDepth - beforeDepth);
    vec2 finalTexCoords = mix(currentTexCoords, prevTexCoords, weight);

    return finalTexCoords;
}

void main()
{
    vec3 viewDir = normalize(fragTanEyePos - fragTanFragPos);
    vec2 texCoor;

    if (int(gl_FragCoord.x) < slider)
      texCoor = fragTexCoor;
      // texCoor = ParallaxMapping_Steep(fragTexCoor, viewDir);
    else
      texCoor = ParallaxMapping_Steep2(fragTexCoor, viewDir, paralaxHeightSlider, maxLayersSlider);

    if (texCoor.x < 0 || texCoor.x > 1 || texCoor.y < 0 || texCoor.y > 1)
        discard;

    vec3 texColor = texture(textureColor, texCoor).rgb * material.useTex + vec3(1.0 - material.useTex, 1.0 - material.useTex, 1.0 - material.useTex);
    vec3 texNormal = normalize(texture(textureNormal, texCoor).rgb * 2.0 - 1.0);

    // ambient
    vec3 ambient = material.ambient*texColor;

    // diffuse
    vec3 lightDir = normalize(fragTanLightPos - fragTanFragPos);

    vec3 diffuse = max(dot(texNormal, lightDir), 0.0)*light.color*material.diffuse*texColor;

    // specular
    vec3 reflDir = reflect(-lightDir, texNormal);
    vec3 specular = pow(max(dot(viewDir, reflDir), 0.0), material.shininess + 1)*light.color*material.specular;


    float v = max(dot(fragTanNormal, lightDir), 0.0);
    if (v < 0.1)
    {
      diffuse *= v*10;
      specular *= v*10;
    }

    color = vec4(ambient + diffuse + specular, 1.0);
}
