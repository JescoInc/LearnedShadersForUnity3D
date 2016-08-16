Shader "Jesco/CellShadedWithAlphas"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_bumpMap("BumpMap", 2D) = "bump"{}
		_Cutoff("Alpha Cutoff", Range(0,1)) = 0.5
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" "Queue" = "AlphaTest" }


		CGPROGRAM
		#pragma surface surf Ramp alphatest:_Cutoff
		#pragma exclude_renderers flash


		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Ramp;

	half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
	{
		half3 ramp = tex2D(_Ramp, float2(0,2)).rgb;
		half4 c;
		c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;
		c.a = s.Alpha;
		return c;
	}

	struct Input
	{
		float2 uv_MainTex;
		float2 uv_BumpMap;
	};

	void surf(Input IN, inout SurfaceOutput o)
	{
		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);

		o.Albedo = tex.rgb;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		o.Alpha = tex.a;
	}

	ENDCG

	}
		Fallback "Diffuse"

}
