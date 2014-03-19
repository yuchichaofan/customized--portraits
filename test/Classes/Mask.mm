//
//  Mask.cpp
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#include "Mask.h"
#include "ImageData.h"
CCScene * MaskScene::scene()
{
    CCScene * scene = CCScene::create();
    MaskScene * layer = MaskScene::create();
    scene->addChild(layer);
    return scene;
}
bool MaskScene::init()
{
    if (!CCLayer::init()) {
        return false;
    }
    size = CCDirector::sharedDirector()->getWinSize();

    //添加通知
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(MaskScene::imageCallBack), "shao", NULL);
    CCSpriteEx* button = CCSpriteEx::create("Icon-144.png");
    button->setSelectorWithTarget(this, menu_selector(MaskScene::callBackFunction));
    button->setPosition(ccp(size.width/2 - 50, size.height - 72));
    addChild(button);
    
    
        //演示效果button
    CCSpriteEx* testButton = CCSpriteEx::create("Icon-144.png");
    testButton->setPosition(ccp(100, size.height - 72));
    addChild(testButton);
    
    jqButton = CCSpriteEx::create("Icon-144.png");
    jqButton->setSelectorWithTarget(this, menu_selector(MaskScene::jq));
    jqButton->setPosition(ccp(size.width/2 + 130, size.height - 72 ));
    jqButton->setVisible(false);
    addChild(jqButton);
    
    return true;
}

void MaskScene::callBackFunction()
{
    CCLog("***********开始拍照 选图***************");
    ImageData * newImageData = [[ImageData alloc]init];
    [newImageData chooseImage];
    CCDirector::sharedDirector()->getTouchDispatcher()->removeDelegate(this);
}
void MaskScene::imageCallBack(CCObject * object)
{
    CCNode * node = (CCNode *)object;
    CCImage * image = (CCImage *)node->getUserObject();
    tt= new CCTexture2D();
    tt->initWithImage(image);
    sp = CCSprite::createWithTexture(tt);
    sp->setScale(0.2);
    sp->setRotation(90);
    sp->setPosition(ccp(size.width/2, size.height/2));
    addChild(sp);
    
    drawNode = CCDrawNode::create();
    drawNode->drawDot(ccp(size.width/2, size.height/2), 72, ccc4f(1, 1, 1, 1));//圆形
    addChild(drawNode);
    jqButton->setVisible(true);
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);

    image->release();
    node->release();
}
void MaskScene::jq()
{
    
    drawNode->setPosition( ccp(50, 50) );
    drawNode->retain();
    drawNode->removeFromParent();
    clipper = CCClippingNode::create();
    clipper->setStencil(drawNode);
    clipper->setContentSize( CCSizeMake(100,100) );
    clipper->setAnchorPoint( ccp(0.5, 0.5) );
    this->addChild(clipper,100);
    sp->retain();
    sp->removeFromParent();
    clipper->addChild(sp);
    clipper->setInverted(false);
    clipper->setAlphaThreshold(0.05);
}

void MaskScene::onEnter()
{
    CCLayer::onEnter();
}
void MaskScene::onExit()
{
    CCLayer::onExit();
}
bool MaskScene::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
        return true;
}
void MaskScene::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    startPoint  = pTouch->getPreviousLocation();
    CCPoint endPoint = pTouch->getLocation();
    float xx = endPoint.x - startPoint.x;
    float yy = endPoint.y - startPoint.y;
    drawNode->setPosition(ccpAdd(drawNode->getPosition(), ccp(xx, yy)));
}
void MaskScene::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    
}
void MaskScene::ccTouchCancelled(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvet)
{
    
}


