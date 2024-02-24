// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Textured With Detail"
{
    Properties
    {
        _Tint("Tint", Color) = (0, 0, 0, 1)
        _MainTex("Texture", 2D) = "white"{}
        _DetailTex("Detail Texture", 2D) = "white"{}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

                #pragma vertex VertexProgram
                #pragma fragment FragmentProgram

                #include "UnityCG.cginc"

                float4 _Tint;
                sampler2D _MainTex;
                sampler2D _DetailTex;
                float4 _MainTex_ST;
                float4 _DetailTex_ST;

                struct Interpolators {
                    float4 position : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct VertexData {
                    float4 position : POSITION;
                    float2 uv : TEXCOORD0;
                };

                Interpolators VertexProgram(VertexData v) {
                    Interpolators i;
                    i.position = UnityObjectToClipPos(v.position);
                    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    return  i;
                }

                float4 FragmentProgram(Interpolators i) : SV_TARGET
                {
                    float4 color = tex2D(_MainTex, i.uv) * _Tint;
                    color *= tex2D(_DetailTex, i.uv * 10);
                    return color;
                }

            ENDCG
        }
    }
}