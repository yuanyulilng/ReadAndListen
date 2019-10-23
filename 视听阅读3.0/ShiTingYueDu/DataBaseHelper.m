//
//  DataBaseHelper.m
//  ShiTingYueDu
//
//  Created by 袁玉灵 on 2019/3/9.
//  Copyright © 2019年 袁玉灵. All rights reserved.
//

#import "DataBaseHelper.h"
#import <FMDatabase.h>
#import <FMDB.h>
#import "ShuJi.h"
@interface DataBaseHelper ()
@property (nonatomic, strong) FMDatabase *db;
@end
@implementation DataBaseHelper
static DataBaseHelper *user;
+(instancetype)shareDataBaseHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
        [user creatDataBase];
    });
    return user;
}
-(void)creatDataBase{
      NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cache = [filePaths objectAtIndex:0];
   // NSLog(@"%@",cache);
    
    NSString *str = [cache stringByAppendingString:@"/UserSql.sqlite"];
    
    _db = [FMDatabase databaseWithPath:str];
    
}
- (void)buildSqliteWithTableName:(NSString *)tableName{
    if ([_db open]) {
        NSString *createStr =[NSString stringWithFormat:@"CREATE TABLE %@(image text PRIMARY KEY, title text, jianjie text,author text,contentString text)",tableName];
        
        BOOL res = [_db executeUpdate:createStr];
        
        if (res != YES) {
           // NSLog(@"创建表失败");
        } else {
           // NSLog(@"创建表失败");
        }
        [_db close];
        
    }
}
// 增加
-(void)insertIntoTable:(NSString *)tableName WithDownload:(ShuJi *)shujiModel{
    if([_db open])
    {
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO %@ (image, title, jianjie, author, contentString) VALUES ('%@', '%@', '%@','%@', '%@')",tableName,shujiModel.image,shujiModel.title,shujiModel.jianjie,shujiModel.author,shujiModel.contentString];
        
        BOOL res = [_db executeUpdate:insertSql1];
        
        if(res != YES)
        {
           // NSLog(@"添加失败");
        }
        else
        {
           // NSLog(@"添加成功");
        }
        
        [_db close];
    }
    else
    {
       // NSLog(@"数据库打开失败");
    }
}
// 删除
- (void)deletaFromTable:(NSString *)tableName  withPath:(NSString *)imagePath{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"DELETE FROM %@ WHERE image = '%@'",tableName, imagePath];
        
        BOOL res = [_db executeUpdate:insertSql1];
        
        if(res != YES)
        {
          //  NSLog(@"删除失败");
        }
        else
        {
           // NSLog(@"删除成功");
        }
        
        [_db close];
    }
    else
    {
       // NSLog(@"数据库打开失败");
    }
    
    
}
// 查询
- (NSArray *)selectAllFromTable:(NSString *)tableName{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if ([_db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",tableName];
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            NSString *image = [rs stringForColumnIndex:0];
            NSString *title = [rs stringForColumn:@"title"];
            NSString * jianjie = [rs stringForColumn:@"jianjie"];
            NSString * author = [rs stringForColumn:@"author"];
            NSString *contentString  =[rs stringForColumn:@"contentString"];
            
            
            ShuJi *user = [[ShuJi alloc] init];
            
            user.image = image;
            user.title = title;
            user.jianjie = jianjie;
            user.author = author;
            user.contentString = contentString;
         
            
            [dataArray addObject:user];
        }
        [_db close];
        
        for (ShuJi *user in dataArray) {
            
          //  NSLog(@"%f%@%@",user.title, user.author,user.jianjie);
        }
    }
    
    
    
    return dataArray;
    
}
@end
