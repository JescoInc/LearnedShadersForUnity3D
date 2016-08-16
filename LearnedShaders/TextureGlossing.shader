// Tells Unity where shader will be in the Editor
Shader "Jesco/TextureGloss" 
{
	// goes to the inspector
	Properties
	{
		// diffuse map
		_MainTex("Texture", 2D) = "white"{}

	   // bump map
	    _BumpMap("BumpMap", 2D) = "bump"{}

	   // Specular map
		_SpecMap("SpecularMap", 2D) = "black"{}

		// Specular Color
		_SpecColor("Specular Color", Color) = (0.5, 0.5, 0.5, 1.0)

       // Shinyness or Power of the Specular Map
			// Range creates the slider
		_Shinyness("Specular Shinyness", Range(0,1)) = 0.5
	}

	SubShader
	{
		// This shader renders opaque. No transparencies
		Tags {"RenderType" = "Opaque"}
		
		// CG code block
		CGPROGRAM
		// calls pregenerated shader code for BlinPhong controls the Speculars
		#pragma surface surf BlinnPhong

		// this will allow us to modify the data in the inspector and at runtime
		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _SpecMap;
		float _SpecShiny;

		struct Input
	{
		// defines more to the data provided in properties
		float2 uv_MainTex; // (1.0, 1.0) aka (U and V direction)
		float2 uv_BumpMap; // (1.0, 1.0) aka (U and V direction)
		float2 uv_SpecMap;
	};

	// surf was created with the pragma
	void surf(Input IN, inout SurfaceOutput o)
	{
		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 specTex = tex2D(_SpecMap, IN.uv_SpecMap);

		o.Albedo = tex.rgb;
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		o.Specular = _SpecShiny;
		o.Gloss = specTex.rgb;
	}
		ENDCG
	}
		// if shader fails, we have a fallback shader
	Fallback "Diffuse"
}