//
//  SH2ViewController.m
//  shudai
//
//  Created by Miriam Castro on 12/12/13.
//  Copyright (c) 2013 Studio Apparte. All rights reserved.
//

#import "SH2ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "SHTableViewController.h"
#import "JSON.h"
#import "UNIRest.h"


typedef NS_ENUM(NSUInteger, UYLTwitterSearchState)
{
    UYLTwitterSearchStateLoading,
    UYLTwitterSearchStateNotFound,
    UYLTwitterSearchStateRefused,
    UYLTwitterSearchStateFailed
};


@interface SH2ViewController ()

@property (nonatomic,strong) NSURLConnection *connection;
@property (nonatomic,strong) NSMutableData *buffer;
@property (nonatomic,strong) NSMutableArray *results;
@property (nonatomic,strong) ACAccountStore *accountStore;
@property (nonatomic,assign) UYLTwitterSearchState searchState;

@end

@implementation SH2ViewController

@synthesize campo2Texto;


- (ACAccountStore *)accountStore
{
    if (_accountStore == nil)
    {
        _accountStore = [[ACAccountStore alloc] init];
    }
    return _accountStore;
}



- (NSString *)searchMessageForState:(UYLTwitterSearchState)state
{
    switch (state)
    {
        case UYLTwitterSearchStateLoading:
            return @"Loading...";
            break;
        case UYLTwitterSearchStateNotFound:
            return @"No results found";
            break;
        case UYLTwitterSearchStateRefused:
            return @"Twitter Access Refused";
            break;
        default:
            return @"Not Available";
            break;
    }
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.campo2Texto;
    
    [self loadQuery];
    
    
}



#pragma mark -
#pragma mark === Private methods ===
#pragma mark -

#define RESULTS_PERPAGE @"10"

- (void)loadQuery
{
    
    
    self.searchState = UYLTwitterSearchStateLoading;
    NSString *encodedQuery = [campo2Texto stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:accountType
                                               options:NULL
                                            completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
             NSDictionary *parameters = @{@"count" : RESULTS_PERPAGE,
                                          @"q" : encodedQuery};
             
             SLRequest *slRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                       requestMethod:SLRequestMethodGET
                                                                 URL:url
                                                          parameters:parameters];
             
             NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
             slRequest.account = [accounts lastObject];
             NSURLRequest *request = [slRequest preparedURLRequest];
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
             });
         }
         else
         {
             self.searchState = UYLTwitterSearchStateRefused;
             //             dispatch_async(dispatch_get_main_queue(), ^{
             //                 [self.tableView reloadData];
             //             });
         }
     }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.buffer = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    
    NSError *jsonParsingError = nil;
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:self.buffer options:0 error:&jsonParsingError];
    
    self.results = jsonResults[@"statuses"];
    if ([self.results count] == 0)
    {
        NSArray *errors = jsonResults[@"errors"];
        if ([errors count])
        {
            self.searchState = UYLTwitterSearchStateFailed;
        }
        else
        {
            self.searchState = UYLTwitterSearchStateNotFound;
        }
    }
    
    self.buffer = nil;
    
    
    NSMutableArray *txtTweet = [self.results valueForKey:@"text"];
    
    //NSLog(@"%@", txtTweet);
    
    //    [self.tableView reloadData];
    //    [self.tableView flashScrollIndicators];
    
    //LLamar a la API de sentimientos
    [self llamadaApiSentimientos: (NSMutableArray *) txtTweet];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    self.buffer = nil;
    self.searchState = UYLTwitterSearchStateFailed;
    
    [self handleError:error];
    //    [self.tableView reloadData];
}

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)cancelConnection
{
    if (self.connection != nil)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.connection cancel];
        self.connection = nil;
        self.buffer = nil;
    }
}



#pragma mark - API Sentimientos

-(void) llamadaApiSentimientos: (NSMutableArray *) resultados
{


    NSString *twitter = [NSString stringWithFormat:@"http://store.apicultur.com/api/stmtlk/1.0.0/valoracion/tweet/10/mierda"];
    
    //LLamada a la API
    NSURL *baseURL = [NSURL URLWithString:twitter];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:baseURL];
    
    [request setHTTPMethod:@"GET"];
   
    [request setValue:@"Bearer 42pHgkV7S7UgI_mgcn3LbeDBi6ca" forHTTPHeaderField:@"Authorization:"];
    
    
   NSURLResponse *response;
   NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
   NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSUTF8StringEncoding];
    

    
   NSLog(@"Reply: %@", theReply);
    
}










#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"terceraVista"])
    {
        NSString *bsc = campo2Texto;
        NSMutableArray *textos = self.results;
        SHTableViewController *viewController = segue.destinationViewController;
        viewController.listaTweets = textos;
        viewController.busqueda = bsc;
    }
}




@end
