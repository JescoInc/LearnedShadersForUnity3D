Shader "Jesco/Transparency" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_BumpMap("BumpMap", 2D) = "bump" {}
		_SpecMap("SpecMap", 2D) = "black" {}
		_SpecColor("SpecColor", Color) = (0.5, 0.5, 0.5, 1.0)
		_SpecPower("SpecPower", Range(0,1)) = 0.5
		_Cutoff("Alpha Cutoff", Range(0,1)) = 0.5
	}
		SubShader
	{
			Tags { "RenderType" = "Opaque" "Queue" = "AlphaTest" }

			CGPROGRAM
			#pragma surface surf BlinnPhong alphatest:_Cutoff
			#pragma exclude_renderers flash

			sampler2D _MainTex;
			sampler2D _BumpMap;
			sampler2D _SpecMap;
			float _SpecPower;	

			struct Input
			{
				float2 uv_MainTex;
				float2 uv_BumpMap;
				float2 uv_SpecMap;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
				fixed4 specTex = tex2D(_SpecMap, IN.uv_SpecMap);


				o.Albedo = tex.rgb;
				o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
				o.Specular = _SpecPower;
				o.Gloss = specTex.rgb;
				o.Alpha = tex.a;
			}

		ENDCG
	}
	FallBack "Diffuse"
}
