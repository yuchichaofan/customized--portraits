//
//  CCSpriteEx.cpp
//  firstGame
//
//  Created by apple on 14-3-16.
//
//

#include "CCSpriteEx.h"
NS_CC_BEGIN

CCSpriteEx* CCSpriteEx::create(const char *pszFileName)
{
    CCSpriteEx *pobSprite = new CCSpriteEx();
    if (pobSprite && pobSprite->initWithFile(pszFileName))
    {
        pobSprite->autorelease();
        return pobSprite;
    }
    CC_SAFE_DELETE(pobSprite);
    return NULL;
}
CCSpriteEx* CCSpriteEx::createWithSpriteFrameName(const char *pszSpriteFrameName)
{
    CCSpriteFrame *pFrame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(pszSpriteFrameName);
    
#if COCOS2D_DEBUG > 0
    char msg[256] = {0};
    sprintf(msg, "Invalid spriteFrameName: %s", pszSpriteFrameName);
    CCAssert(pFrame != NULL, msg);
#endif
    
    return createWithSpriteFrame(pFrame);
}

CCSpriteEx* CCSpriteEx::createWithSpriteFrame(CCSpriteFrame *pSpriteFrame)
{
    CCSpriteEx *pobSprite = new CCSpriteEx();
    if (pSpriteFrame && pobSprite && pobSprite->initWithSpriteFrame(pSpriteFrame))
    {
        pobSprite->autorelease();
        return pobSprite;
    }
    CC_SAFE_DELETE(pobSprite);
    return NULL;
}


void CCSpriteEx::onEnter()
{
    // 注册触摸协议，并吃掉触摸事件
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, kCCMenuHandlerPriority, true);
    CCSprite::onEnter();
}
void CCSpriteEx::onExit()
{
    CCDirector::sharedDirector()->getTouchDispatcher()->removeDelegate(this);
    CCSprite::onExit();
}

cocos2d::CCRect CCSpriteEx::rect()
{
    return CCRectMake(getPositionX() - getContentSize().width * getAnchorPoint().x,
                      getPositionY() - getContentSize().height * getAnchorPoint().y,
                      getContentSize().width, getContentSize().height); 
}

bool CCSpriteEx::isTouchInside( CCTouch* touch )
{
    CCPoint touchLocation = touch->getLocation(); // 返回GL坐标

    CCPoint localPos = convertToNodeSpace(touchLocation);
    CCRect rc = rect();
    rc.origin = CCPointZero;
    bool isTouched = rc.containsPoint(localPos);
    return isTouched;
}

bool CCSpriteEx::ccTouchBegan( CCTouch *pTouch, CCEvent *pEvent )
{
    bool isTouched = isTouchInside(pTouch);
    if(isTouched)
    {
        setColor(ccc3(122, 122, 122));
    }
    return isTouched;
}
void CCSpriteEx::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent)
{
    bool isTouched = isTouchInside(pTouch);
    
    if (isTouched)
    {
        setColor(ccc3(122, 122, 122));
    }
    else
    {
        setColor(ccc3(255, 255, 255));
    }
}
void CCSpriteEx::ccTouchEnded( CCTouch *pTouch, CCEvent *pEvent )
{
    bool isTouched = isTouchInside(pTouch) && isVisible();
    setColor(ccc3(255, 255, 255));
    if (isTouched)
    {
        if (m_pListener && m_pfnSelector)
        {
            (m_pListener->*m_pfnSelector)(this);
        }
    }
}

void CCSpriteEx::setSelectorWithTarget( CCObject *target, SEL_MenuHandler selector )
{
    m_pListener = target;
    m_pfnSelector = selector;
}

NS_CC_END