#version 150

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

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

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

void f_d2f9597c(inout vec4 vertex) {
    gl_Position=ProjMat*ModelViewMat*vertex;
}

void f_af603b4c() {
    vertexColor=Color*texelFetch(Sampler2, UV2 / 16, 0);
}


void f_c3123f1c(inout vec4 vertex) {
    f_d2f9597c(vertex);
    if(Position.z==0. && gl_Position.x > .95) {
        vertexColor=vec4(0);
    }else{
        f_af603b4c();
    }
    finalize();
}



void f_29bc959b() {
    vertexColor=hue(gl_Position.x+safeGameTime()*1000.)*texelFetch(Sampler2, UV2 / 16, 0);
}

void f_609962a4() {
    gl_Position.y+=sin(scaledTime()+(gl_Position.x*6)) / 150.;
}

void f_1e621c9a(inout vec4 vertex) {
    f_d2f9597c(vertex);
    f_29bc959b();
    finalize();
}

void f_8d55f995(inout vec4 vertex) {
    f_d2f9597c(vertex);
    f_af603b4c();
    f_609962a4();
    finalize();
}

void f_72a3554f(inout vec4 vertex) {
    f_d2f9597c(vertex);
    f_609962a4();
    f_29bc959b();
    finalize();
}

void f_9582e5c7(inout vec4 vertex) {
    f_af603b4c();
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
    f_d2f9597c(vertex);
    finalize();
}

void f_3fc1bb92(inout vec4 vertex) {
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
    f_29bc959b();
    f_d2f9597c(vertex);
    finalize();
}

void f_db9d5f9b(inout vec4 vertex, float speed) {
    f_d2f9597c(vertex);
    float blink=abs(sin(scaledTime()*speed));
    vertexColor=Color*blink*texelFetch(Sampler2, UV2 / 16, 0);
    finalize();
}



void f_36fc5a33(inout vec4 vertex) {
    f_d2f9597c(vertex);
    f_af603b4c();
    vertexColor=vec4(1, 1, 1, vertexColor.a); 
    finalize();
}


void main() {
    vec4 vertex=vec4(Position, 1.);
    ivec3 iColor=ivec3(Color.xyz*255+vec3(.5));

    
    
    if(iColor==ivec3(255, 85, 85))
    {
        f_c3123f1c(vertex);
        return;
    }
    

    
    if(fract(Position.z) < .1) {
        
        
        if(iColor==ivec3(19, 23, 9))
        {
            gl_Position=vec4(2, 2, 2, 1);
            f_af603b4c();
            finalize();
            return;
        }
        

        
        
        if(iColor==ivec3(57, 63, 63)) {
            
            
            f_d2f9597c(vertex);
            f_af603b4c();
            finalize();
            return;
        }

        
        if(iColor==ivec3(57, 63, 62)) {
            f_8d55f995(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 63)) {
            
            f_8d55f995(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 62)) {
            f_9582e5c7(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 63)) {
            f_9582e5c7(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 62)) {
            f_db9d5f9b(vertex, .5);
            return;
        }

        

        
    }

    
    
    if(iColor==ivec3(78, 92, 36))
    {
        f_36fc5a33(vertex);
        return;
    }
    

    
    
    
    if(iColor==ivec3(230, 255, 254))
    {
        f_1e621c9a(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 255, 250))
    {
        f_8d55f995(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 254))
    {
        f_72a3554f(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 250))
    {
        f_9582e5c7(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 254))
    {
        f_3fc1bb92(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 250))
    {
        f_db9d5f9b(vertex, .5);
        return;
    }

    
    

    
    
    
    if(iColor==ivec3(255, 255, 254))
    {
        f_1e621c9a(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 253))
    {
        f_8d55f995(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 25))
    {
        f_72a3554f(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 251))
    {
        f_9582e5c7(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 254, 254))
    {
        f_3fc1bb92(vertex);
        return;
    }
    

    
    f_d2f9597c(vertex);
    f_af603b4c();
    finalize();
}