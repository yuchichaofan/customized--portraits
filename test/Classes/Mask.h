//
//  Mask.h
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#ifndef __firstGame__Mask__
#define __firstGame__Mask__

#include <iostream>
#include "cocos2d.h"
#include "CCSpriteEx.h"
USING_NS_CC;
class MaskScene:public CCLayer {
public:
    static CCScene * scene();
    CREATE_FUNC(MaskScene);
    bool init();
    void callBackFunction();
    void imageCallBack(CCObject * object); //通知回调
    
    void onEnter();
    void onExit();
    bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvet);
    void jq();   //剪切头像
private:
    CCSprite * sp ;
    CCSprite * mask;
    CCSpriteEx* jqButton;
    CCSize size ;
    CCClippingNode *clipper;
    CCPoint startPoint;
    CCPoint tempPoint;
    CCDrawNode * drawNode;
    CCTexture2D * tt;
};
#endif /* defined(__firstGame__Mask__) */
