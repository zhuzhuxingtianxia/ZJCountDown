# ZJCountDown
   电商秒杀倒计时
   
## 效果图
 ![img](https://github.com/zhuzhuxingtianxia/ZJCountDown/blob/master/20180117.gif)
 
 ### 使用API
        ```
        /**
        字体颜色 默认白色
        */
        @property(nonatomic,strong)UIColor  *textColor;
        /**
        背景颜色 默认黑色
        */
        @property(nonatomic,strong)UIColor  *tintColor;
        /**
        字体大小
        */
        @property(nonatomic,strong)UIFont   *textFont;
        /**
        圆角大小
        */
        @property(nonatomic,assign)CGFloat  cornerRadius;
        
        /**
        用于倒计时
        
        @param timeInterval 倒计时时间戳
        @param completion 倒计时结束时的回调
        */
        -(void)countDownWithTimeInterval:(NSInteger)timeInterval completion:(void (^ __nullable)(BOOL finished))completion;
        
        /**
        取消倒计时
        */
        -(void)cancelTimerCountDown;
        ```
