//
//  ProjectHeader.h
//  ScrollViewTitleView
//
//  Created by new on 2019/11/19.
//  Copyright © 2019 new. All rights reserved.
//

#ifndef ProjectHeader_h
#define ProjectHeader_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NavAndStatusHight self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


#endif /* ProjectHeader_h */
