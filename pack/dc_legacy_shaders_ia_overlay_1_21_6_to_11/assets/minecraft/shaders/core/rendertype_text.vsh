#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl> 

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

void f_7df9e067(inout vec4 vertex) {
    gl_Position=ProjMat*ModelViewMat*vertex;
}

void f_38ba87ee() {
    vertexColor=Color*texelFetch(Sampler2, UV2 / 16, 0);
}


void f_11f2e62c(inout vec4 vertex) {
    f_7df9e067(vertex);
    if(Position.z==0. && gl_Position.x > .95) {
        vertexColor=vec4(0);
    }else{
        f_38ba87ee();
    }
    finalize();
}



void f_acad2a43() {
    vertexColor=hue(gl_Position.x+safeGameTime()*1000.)*texelFetch(Sampler2, UV2 / 16, 0);
}

void f_54616b28() {
    gl_Position.y+=sin(scaledTime()+(gl_Position.x*6)) / 150.;
}

void f_185d7286(inout vec4 vertex) {
    f_7df9e067(vertex);
    f_acad2a43();
    finalize();
}

void f_d7928fbb(inout vec4 vertex) {
    f_7df9e067(vertex);
    f_38ba87ee();
    f_54616b28();
    finalize();
}

void f_d8dc4956(inout vec4 vertex) {
    f_7df9e067(vertex);
    f_54616b28();
    f_acad2a43();
    finalize();
}

void f_483f1d32(inout vec4 vertex) {
    f_38ba87ee();
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
    f_7df9e067(vertex);
    finalize();
}

void f_c7979f4f(inout vec4 vertex) {
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
    f_acad2a43();
    f_7df9e067(vertex);
    finalize();
}

void f_2ef851a4(inout vec4 vertex, float speed) {
    f_7df9e067(vertex);
    float blink=abs(sin(scaledTime()*speed));
    vertexColor=Color*blink*texelFetch(Sampler2, UV2 / 16, 0);
    finalize();
}



void f_6dc74ecd(inout vec4 vertex) {
    f_7df9e067(vertex);
    f_38ba87ee();
    vertexColor=vec4(1, 1, 1, vertexColor.a); 
    finalize();
}


void main() {

    sphericalVertexDistance=fog_spherical_distance(Position);
    cylindricalVertexDistance=fog_cylindrical_distance(Position);
    vertexColor=Color*texelFetch(Sampler2, UV2 / 16, 0);

    vec4 vertex=vec4(Position, 1.);
    ivec3 iColor=ivec3(Color.xyz*255+vec3(.5));

    
    
    if(iColor==ivec3(255, 85, 85))
    {
        f_11f2e62c(vertex);
        return;
    }
    

    
    if(fract(Position.z) < .1) {
        
        
        if(iColor==ivec3(19, 23, 9))
        {
            gl_Position=vec4(2, 2, 2, 1);
            f_38ba87ee();
            finalize();
            return;
        }
        

        
        
        if(iColor==ivec3(57, 63, 63)) {
            
            
            f_7df9e067(vertex);
            f_38ba87ee();
            finalize();
            return;
        }

        
        if(iColor==ivec3(57, 63, 62)) {
            f_d7928fbb(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 63)) {
            
            f_d7928fbb(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 62)) {
            f_483f1d32(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 63)) {
            f_483f1d32(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 62)) {
            f_2ef851a4(vertex, .5);
            return;
        }

        

        
    }

    
    
    if(iColor==ivec3(78, 92, 36))
    {
        f_6dc74ecd(vertex);
        return;
    }
    

    
    
    
    if(iColor==ivec3(230, 255, 254))
    {
        f_185d7286(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 255, 250))
    {
        f_d7928fbb(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 254))
    {
        f_d8dc4956(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 250))
    {
        f_483f1d32(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 254))
    {
        f_c7979f4f(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 250))
    {
        f_2ef851a4(vertex, .5);
        return;
    }

    
    

    
    
    
    if(iColor==ivec3(255, 255, 254))
    {
        f_185d7286(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 253))
    {
        f_d7928fbb(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 25))
    {
        f_d8dc4956(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 251))
    {
        f_483f1d32(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 254, 254))
    {
        f_c7979f4f(vertex);
        return;
    }
    

    
    f_7df9e067(vertex);
    f_38ba87ee();
    finalize();
}