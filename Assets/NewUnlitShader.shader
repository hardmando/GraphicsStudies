// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader"
{
    Properties
    {
        _Tint("Tint", Color) = (0, 0, 0, 1)
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
                
                float4 VertexProgram(float4 position : POSITION) : SV_POSITION
                {
                    return  UnityObjectToClipPos(position);
                }
                float4 FragmentProgram(float4 position : SV_POSITION) : SV_TARGET
                {
                    return _Tint;
                }
                
            ENDCG
        }
    }
}