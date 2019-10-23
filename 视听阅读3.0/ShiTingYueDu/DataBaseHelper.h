//
//  DataBaseHelper.h
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShuJi;
@interface DataBaseHelper : NSObject
+(instancetype)shareDataBaseHelper;
-(void)creatDataBase;
- (void)buildSqliteWithTableName:(NSString *)tableName;
// 增加
-(void)insertIntoTable:(NSString *)tableName WithDownload:(ShuJi *)shujiModel;
// 删除
- (void)deletaFromTable:(NSString *)tableName  withPath:(NSString *)imagePath;
// 查询
- (NSArray *)selectAllFromTable:(NSString *)tableName;
@end
