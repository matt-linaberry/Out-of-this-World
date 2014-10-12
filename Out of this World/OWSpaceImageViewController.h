//
//  OWSpaceImageViewController.h
//  Out of this World
//
//  Created by Matthew Linaberry on 10/4/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;
@end
