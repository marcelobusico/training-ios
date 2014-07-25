//
//  Mobile_PractiseTests.m
//  Mobile PractiseTests
//
//  Created by Marcelo Busico on 17/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Mobile_PractiseTests : XCTestCase

@end

@implementation Mobile_PractiseTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"Este test no funca!");
    XCTAssertEqual(1, 2, @"No son iguales ni a gancho!");
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
