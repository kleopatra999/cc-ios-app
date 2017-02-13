//
//  deviantART_SDKTests.m
//  DeviantArt SDKTests
//
//  Created by Aaron Pearce on 19/11/13.
//  Copyright (c) 2013 deviantART. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <OHHTTPStubs/OHHTTPStubs.h>

#import "DVNTSDK.h"

@interface DVNTAPIClient ()

- (void)refreshCredential:(DVNTCredential *)credential tokenType:(DVNTTokenType)tokenType ifExpiredWithSuccess:(void (^)(DVNTCredential *))success failure:(void (^)(NSError *))failure;
+ (instancetype)sharedClient;
+ (DVNTHTTPSessionManager *)sessionManagerForTokenType:(DVNTRequestTokenType)tokenType;

@property (nonatomic) NSURL *redirectURL;
@property (nonatomic) NSString *versionHeader;
@property (nonatomic) BOOL shouldShowMatureContent;

@end

NSString * const DVNTSDKTestsServiceProvider = @"www.deviantart.com-__CHANGE_ME__";

@interface DeviantArt_SDKTests : XCTestCase

@end

@implementation DeviantArt_SDKTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// A failure of this case is expected atm given T24255, but the test-ending crash that actually occurs is not.  This crash is due to nested expectations,
// resolution is apparently not as simple as __weak XCTestExpectation as per http://stackoverflow.com/a/27555500 but perhaps that is one aspect of a fix.
- (void)dontTestExpiredUserRefreshError401 {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:@"/api/v1/oauth2/user/whois"];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        NSString *dataString = @"{\"error\": \"invalid_request\", \"error_description\": \"Something broke\"}";
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        return [[OHHTTPStubsResponse responseWithData:data statusCode:401 headers:@{@"Content-Type":@"text/json"}] requestTime:0.2 responseTime:1];
    }];
    
    XCTestExpectation *errorExpectation = [self expectationWithDescription:@"Refreshing User Credential to get 401 error"];
    
    __block NSError *requestError = nil;
    [DVNTAPIRequest whoisWithUsernames:@[@"pkly"] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Um what");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure?");
        requestError = error;
        [errorExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNotNil(requestError);
        
        // We expect a failure here still
        requestError = nil;
        XCTestExpectation *expectation2 = [self expectationWithDescription:@"Successful user load"];
        [DVNTAPIRequest whoAmIWithSuccess:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
            requestError = error;
            [expectation2 fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            XCTAssertNotNil(requestError);
            
            // Now we should get a passing request?
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return [request.URL.path isEqualToString:@"/api/v1/oauth2/user/whoami"];
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                
                NSString *dataString =  @"{\"userid\": \"49A46198-0747-F58E-37BB-2E0E87226DB2\", \"username\": \"Pickley\", \"usericon\": \"http://a.deviantart.net/avatars/p/i/pickley.png?11\", \"type\": \"admin\"}";
                
                NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
                return [[OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"Content-Type":@"text/json"}] requestTime:0.2 responseTime:1];
            }];
            
            __block DVNTUser *requestUser = nil;
            XCTestExpectation *expectation3 = [self expectationWithDescription:@"Successful user load"];
            [DVNTAPIRequest whoAmIWithSuccess:^(NSURLSessionDataTask *task, DVNTUser *user) {
                requestUser = user;
                [expectation3 fulfill];
            } failure:nil];
            
            [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
                XCTAssertNotNil(requestUser);
            }];

        }];
        
    }];
}


@end
