// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Lighting"
{
    Properties
    {
        _Tint("Tint", Color) = (1, 1, 1, 1)
        _MainTex("Albedo", 2D) = "white"{}
        _Smoothness ("Smoothness", Range(0, 1)) = .5
    }
    SubShader
    {
        Pass
        {
            Tags{
                "LightMode" = "ForwardBase"
            }
            CGPROGRAM

                #pragma vertex VertexProgram
                #pragma fragment FragmentProgram

                #include "UnityStandardBRDF.cginc"

                sampler2D _MainTex;
                float4 _MainTex_ST;
                float4 _Tint;

                struct Interpolators {
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : TEXCOORD1;
                    float3 worldPos : TEXCOORD2;
                };

                struct VertexData {
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : NORMAL;
                };

                Interpolators VertexProgram(VertexData v) {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.worldPos = mul(unity_ObjectToWorld, v.position);
                    i.normal = UnityObjectToWorldNormal(v.normal);
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);

                    return  i;
                }

                float4 FragmentProgram(Interpolators i) : SV_TARGET
                {
                    i.normal = normalize(i.normal);
                    float3 lightDir = _WorldSpaceLightPos0.xyz;
                    float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

                    float3 reflectionDir = reflect(-lightDir, i.normal);

                    float3 lightColor = _LightColor0.rgb;
                    float3 albedo = tex2D(_MainTex, i.uv) * _Tint;
                    float3 diffuse = albedo * lightColor * DotClamped(lightDir, i.normal);

                    return DotClamped(viewDir, reflectionDir) * float4(albedo * lightColor, 1);
                }

            ENDCG
        }
    }
}
