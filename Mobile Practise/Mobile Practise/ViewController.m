//
//  ViewController.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 17/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"
#import "ItemEntity.h"

@interface ViewController ()

@property(nonatomic,strong) IBOutlet UITextField *txtSearch;

-(IBAction)showResults:(id)sender;

@end

@implementation ViewController

@synthesize txtSearch;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)search:(id)sender {
    
    NSString *stringUrl = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLA/search?q=%@&limit=100",txtSearch.text];
    NSLog(@"BOTON PRESIONADO!!");
    NSLog(@"%@", stringUrl);
    
    __weak typeof (self) weakSelf = self;
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
             
             NSArray *results = [ItemEntity parseFrom:response];
             
             //self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
             //self.greetingContent.text = [greeting objectForKey:@"content"];
             [weakSelf showResults:results];
         }
     }];
}

-(void)showResults:(NSArray *) results {
    ResultsViewController *resultsViewController = [[ResultsViewController alloc] init];
    resultsViewController.title = @"Resultados";
    resultsViewController.results = results;
    
    [self.navigationController pushViewController:resultsViewController
                                         animated:YES];
}

@end
