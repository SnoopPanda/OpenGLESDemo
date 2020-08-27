//
//  SPDrawImageViewController.m
//  OpenGLESDemo
//
//  Created by 王杰 on 2020/8/27.
//  Copyright © 2020 SPPT. All rights reserved.
//

#import "SPDrawImageViewController.h"
#import <GLKit/GLKit.h>

@interface SPDrawImageViewController ()<GLKViewDelegate>
@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) GLKBaseEffect *effect;
@end

@implementation SPDrawImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpConfig];
    [self setUpVertexData];
    [self setUpTexture];
}

- (void)setUpConfig {
    // 初始化context
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (!self.context) {
        NSLog(@"create OpenGLES context failed");
        return;
    }
    // 设置当前上下文
    [EAGLContext setCurrentContext:self.context];
    
    GLKView *glView = [[GLKView alloc] initWithFrame:self.view.bounds context:self.context];
    glView.delegate = self;
    /*
     (1). drawableColorFormat: 颜色缓存区格式.
      简介:OpenGL ES 有一个缓存区，它用以存储将在屏幕中显示的颜色。你可以使用其属性来设置缓冲区中的每个像素的颜色格式。
      
      GLKViewDrawableColorFormatRGBA8888 = 0,
      默认.缓存区的每个像素的最小组成部分（RGBA）使用8个bit，（所以每个像素4个字节，4*8个bit）。
      
      GLKViewDrawableColorFormatRGB565,
      如果你的APP允许更小范围的颜色，即可设置这个。会让你的APP消耗更小的资源（内存和处理时间）
      
      (2). drawableDepthFormat: 深度缓存区格式
      
      GLKViewDrawableDepthFormatNone = 0,意味着完全没有深度缓冲区
      GLKViewDrawableDepthFormat16,
      GLKViewDrawableDepthFormat24,
      如果你要使用这个属性（一般用于3D游戏），你应该选择GLKViewDrawableDepthFormat16
      或GLKViewDrawableDepthFormat24。这里的差别是使用GLKViewDrawableDepthFormat16
      将消耗更少的资源
     */
    // 配置视图创建的渲染缓存区
    glView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    glView.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    [self.view addSubview:glView];
    // 设置背景颜色
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
}

- (void)setUpVertexData {
    /* 设置顶点数组（顶点坐标、纹理坐标）
     顶点坐标系取值范围是[-1,1]，(0,0)是在屏幕正中间
     纹理坐标系取值范围[0,1]，原点是在左下角；
     前三个是顶点坐标（x、y、z轴），后面两个是纹理坐标（x，y）
     */
    GLfloat vertexData[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    
    //顶点数据缓存
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    //顶点数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    
    //纹理数据
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
}

- (void)setUpTexture {
    //纹理贴图
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    //着色器
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.name = textureInfo.name;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}


@end
