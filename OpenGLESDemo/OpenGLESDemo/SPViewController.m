//
//  SPViewController.m
//  OpenGLESDemo
//
//  Created by 王杰 on 2020/9/8.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "SPViewController.h"
#import "SPShaderManager.h"

@interface SPViewController ()
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) SPShaderManager *shaderManager;
@end

@implementation SPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

-(void)setup {
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }

    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:self.context];
    
    self.shaderManager = [[SPShaderManager alloc] init];
    
    NSString *vertexShaderPath = [[NSBundle mainBundle] pathForResource:@"vertex" ofType:@"glsl"];
    NSString *fragmentShaderPath = [[NSBundle mainBundle] pathForResource:@"fragment" ofType:@"glsl"];
    
    // 编译连个shader 文件
    GLuint vertexShader,fragmentShader;
    
    if (![self.shaderManager compileShader:&vertexShader type:GL_VERTEX_SHADER URL:[NSURL fileURLWithPath:vertexShaderPath]]||![self.shaderManager compileShader:&fragmentShader type:GL_FRAGMENT_SHADER URL:[NSURL fileURLWithPath:fragmentShaderPath]]){
        return ;
    }
    // 注意获取绑定属性要在连接程序之前
//    [self.shaderManager bindAttribLocation:GLKVertexAttribPosition andAttribName:"position"];
//    [self.shaderManager bindAttribLocation:GLKVertexAttribTexCoord0 andAttribName:"texCoord0"];
    
   
    // 将编译好的两个对象和着色器程序进行连接
    if(![self.shaderManager linkProgram]){
        [self.shaderManager deleteShader:&vertexShader];
        [self.shaderManager deleteShader:&fragmentShader];
    }
//    _textureBufferR = [self.shaderManager getUniformLocation:"sam2DR"];
    
    // 接触
    [self.shaderManager detachAndDeleteShader:&vertexShader];
    [self.shaderManager detachAndDeleteShader:&fragmentShader];
//    [self.shaderManager useProgram];
}

#pragma mark - Update Delegate

- (void)update {
    // 距离上一次调用update过了多长时间，比如一个游戏物体速度是3m/s,那么每一次调用update，
    // 他就会行走3m/s * deltaTime，这样做就可以让游戏物体的行走实际速度与update调用频次无关
    // NSTimeInterval deltaTime = self.timeSinceLastUpdate;
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    // 清空之前的绘制
    glClearColor(1, 0.2, 0.2, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // 使用fragment.glsl 和 vertex.glsl中的shader
    [self.shaderManager useProgram];
}


@end
