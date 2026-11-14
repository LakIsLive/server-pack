#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl> 
#moj_import <minecraft:sample_lightmap.glsl>

precision highp float;






#define hue(v)  ((.6+.6*cos(6.*(v)+vec4(0, 23, 21, 1)))+vec4(0., 0., 0., 1.) )

#define finalize() { \
    vertexDistance=length((ModelViewMat*vertex).xyz); \
    texCoord0=UV0; \
}

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;


uniform sampler2D Sampler0;

uniform sampler2D Sampler2;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;

float safeGameTime() {
    float gameTime=GameTime;
    
    if(gameTime <= 0) {
        gameTime=.5;
    }
    return gameTime;
}

float scaledTime() {
    return safeGameTime()*12000.;
}

void f_fa41a99a(inout vec4 vertex) {
    gl_Position=ProjMat*ModelViewMat*vertex;
}

void f_c8b9917b() {
    vertexColor=Color*sample_lightmap(Sampler2, UV2);
}


void f_170efea9(inout vec4 vertex) {
    f_fa41a99a(vertex);
    if(Position.z==0. && gl_Position.x > .95) {
        vertexColor=vec4(0);
    }else{
        f_c8b9917b();
    }
        finalize();
}



void f_4060c159() {
    vertexColor=hue(gl_Position.x+safeGameTime()*1000.)*sample_lightmap(Sampler2, UV2);
}

void f_e09ab46a() {
    gl_Position.y+=sin(scaledTime()+(gl_Position.x*6)) / 150.;
}

void f_264f5584(inout vec4 vertex) {
    f_fa41a99a(vertex);
    f_4060c159();
    finalize();
}

void f_665db838(inout vec4 vertex) {
    f_fa41a99a(vertex);
    f_c8b9917b();
    f_e09ab46a();
    finalize();
}

void f_2ce8ab7b(inout vec4 vertex) {
    f_fa41a99a(vertex);
    f_e09ab46a();
    f_4060c159();
    finalize();
}

void f_df4490a1(inout vec4 vertex) {
    f_c8b9917b();
    float vertexId=mod(gl_VertexID, 4.);
    if(vertex.z <= 0.) {
        if(vertexId==3. || vertexId==0.) {
            vertex.y+=cos(scaledTime() / 4)*.1;
            vertex.y+=max(cos(scaledTime() / 4)*.1, 0.);
        }
    }else{
        if(vertexId==3. || vertexId==0.) {
            vertex.y-=cos(scaledTime() / 4)*3;
            vertex.y-=max(cos(scaledTime() / 4)*4, 0.);
        }
    }
    f_fa41a99a(vertex);
    finalize();
}

void f_68b8e63b(inout vec4 vertex) {
    float vertexId=mod(gl_VertexID, 4.);
    if(vertex.z <= 0.) {
        if(vertexId==3. || vertexId==0.) {
            vertex.y+=cos(scaledTime() / 4)*.1;
            vertex.y+=max(cos(scaledTime() / 4)*.1, 0.);
        }
    }else{
        if(vertexId==3. || vertexId==0.) {
            vertex.y-=cos(scaledTime() / 4)*3;
            vertex.y-=max(cos(scaledTime() / 4)*4, 0.);
        }
    }
    f_4060c159();
    f_fa41a99a(vertex);
    finalize();
}

void f_bec427c1(inout vec4 vertex, float speed) {
    f_fa41a99a(vertex);
    float blink=abs(sin(scaledTime()*speed));
    vertexColor=Color*blink*sample_lightmap(Sampler2, UV2);
    finalize();
}



void f_19c1069b(inout vec4 vertex) {
    f_fa41a99a(vertex);
    f_c8b9917b();
    vertexColor=vec4(1, 1, 1, vertexColor.a); 
    finalize();
}


void main() {

    sphericalVertexDistance=fog_spherical_distance(Position);
    cylindricalVertexDistance=fog_cylindrical_distance(Position);
    vertexColor=Color*sample_lightmap(Sampler2, UV2);

    vec4 vertex=vec4(Position, 1.);
    ivec3 iColor=ivec3(Color.xyz*255+vec3(.5));

    
    
    if(iColor==ivec3(255, 85, 85))
    {
        f_170efea9(vertex);
        return;
    }
    

    
    if(fract(Position.z) < .1) {
        
        
        if(iColor==ivec3(19, 23, 9))
        {
            gl_Position=vec4(2, 2, 2, 1);
            f_c8b9917b();
            finalize();
            return;
        }
        

        
        
        if(iColor==ivec3(57, 63, 63)) {
            
            
            f_fa41a99a(vertex);
            f_c8b9917b();
            finalize();
            return;
        }

        
        if(iColor==ivec3(57, 63, 62)) {
            f_665db838(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 63)) {
            
            f_665db838(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 62)) {
            f_df4490a1(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 63)) {
            f_df4490a1(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 62)) {
            f_bec427c1(vertex, .5);
            return;
        }

        

        
    }

    
    
    if(iColor==ivec3(78, 92, 36))
    {
        f_19c1069b(vertex);
        return;
    }
    

    
    
    
    if(iColor==ivec3(230, 255, 254))
    {
        f_264f5584(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 255, 250))
    {
        f_665db838(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 254))
    {
        f_2ce8ab7b(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 250))
    {
        f_df4490a1(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 254))
    {
        f_68b8e63b(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 250))
    {
        f_bec427c1(vertex, .5);
        return;
    }

    
    

    
    
    
    if(iColor==ivec3(255, 255, 254))
    {
        f_264f5584(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 253))
    {
        f_665db838(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 25))
    {
        f_2ce8ab7b(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 251))
    {
        f_df4490a1(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 254, 254))
    {
        f_68b8e63b(vertex);
        return;
    }
    

    
    f_fa41a99a(vertex);
    f_c8b9917b();
    finalize();
}