//
//  CCSpriteEx.h
//  firstGame
//
//  Created by apple on 14-3-16.
//
//
#ifndef __CatFight_CCSpriteEx__
#define __CatFight_CCSpriteEx__

// CCSpriteEx 是对 CCSprite类的扩展，主要是能得到触摸事件的反馈
#include <cocos2d.h>
#include <cocos-ext.h>

NS_CC_BEGIN

class CCSpriteEx: public CCSprite , public CCTargetedTouchDelegate
{
public:
    // 设置点击精灵的事件处理器
    void setSelectorWithTarget(CCObject *target, SEL_MenuHandler selector);
    static CCSpriteEx* create(const char *pszFileName);
    static CCSpriteEx* createWithSpriteFrameName(const char *pszSpriteFrameName);
    static CCSpriteEx* createWithSpriteFrame(CCSpriteFrame *pSpriteFrame);
public:
    CCSpriteEx() : m_pListener(NULL),m_pfnSelector(NULL) {}
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    // optional
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent) {CC_UNUSED_PARAM(pTouch); CC_UNUSED_PARAM(pEvent);}
    
private:
    void onEnter();
    void onExit();
    // 取得精灵的位置与尺寸
    CCRect rect();
    // 触摸点是否在精灵上
    bool isTouchInside(CCTouch* touch);
    
private:
    // 点击事件处理
    CCObject*       m_pListener;
    SEL_MenuHandler m_pfnSelector;
};

NS_CC_END

#endif // __CatFight_CCSpriteEx__
