// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Lighting"
{
    Properties
    {
        _MainTex("Splat Map", 2D) = "white"{}
        [NoScaleOffset] _Texture1("Texture 1", 2D) = "white" {}
        [NoScaleOffset] _Texture2("Texture 2", 2D) = "white" {}
        [NoScaleOffset] _Texture3("Texture 3", 2D) = "white" {}
        [NoScaleOffset] _Texture4("Texture 4", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

                #pragma vertex VertexProgram
                #pragma fragment FragmentProgram

                #include "UnityCG.cginc"

                sampler2D _MainTex;
                float4 _MainTex_ST;

                sampler2D _Texture1, _Texture2, _Texture3, _Texture4;

                struct Interpolators {
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : TEXCOORD1;
                };

                struct VertexData {
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : NORMAL;
                };

                Interpolators VertexProgram(VertexData v) {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    i.normal = v.normal;
                    return  i;
                }

                float4 FragmentProgram(Interpolators i) : SV_TARGET
                {
                    return float4(i.normal * .5 + .5, 1);
                }

            ENDCG
        }
    }
}
