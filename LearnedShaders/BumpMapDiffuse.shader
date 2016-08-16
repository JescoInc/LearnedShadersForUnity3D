// Tells Unity where shader will be in the Editor
Shader "Jesco/DiffuseWithBumps" 
{
	// goes to the inspector
	Properties
	{
		// diffuse map
		_MainTex("Texture", 2D) = "white"{}

	   // bump map
	    _bumpMap("BumpMap", 2D) = "bump"{}
	}

	SubShader
	{
		// This shader renders opaque. No transparencies
		Tags {"RenderType" = "Opaque"}
		
		// CG code block
		CGPROGRAM
		// calls pregenerated shader code for Lambert. Basic lighting
		#pragma surface surf Lambert

		struct Input
	{
		// defines more to the data provided in properties
		float2 uv_MainTex; // (1.0, 1.0) aka (U and V direction)
		float2 uv_BumpMap; // (1.0, 1.0) aka (U and V direction)
	};

	// this will allow us to modify the data in the inspector and at runtime
	sampler2D _MainTex;
	sampler2D _BumpMap;

	// surf was created with the pragma
	void surf(Input IN, inout SurfaceOutput o)
	{
		// tex2D takes 2 parameters (texture and the uv float2)
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		// unpacknormal a function to take a normal map to apply it the way it should be
		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	}
		ENDCG
	}
		// if shader fails, we have a fallback shader
	Fallback "Diffuse"
}