Shader "Custom/TransparentShadowCatcher" 
{
    Properties
    {
        _Color("Main Color", Color) = (1,1,1,1)
        _MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
        _Cutoff("Alpha cutoff", Range(0,1)) = 0
    }

    SubShader
    {
        Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
        LOD 200
        Blend Zero One
        Lighting Off
        ZTest LEqual
        ZWrite On
        ColorMask 0
        Cull Back

        CGPROGRAM
        #pragma surface surf ShadowOnly alphatest:_Cutoff fullforwardshadows addshadow
        fixed4 _Color;

        struct Input 
        {
            float2 uv_MainTex;
            float4 screenPos;
        };

        half4 LightingShadowOnly(SurfaceOutput s, half3 lightDir, half3 viewDir, fixed atten)
        {
            half diff = max(0, dot(s.Normal, lightDir));

            half3 h = normalize(lightDir + viewDir);
            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, 32.0);

            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            return c;
        }

        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = _Color.rgb;
            o.Alpha = 1;
        }

        ENDCG
    }
       
    Fallback "Transparent/Cutout/VertexLit"
}