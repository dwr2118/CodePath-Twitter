//
//  TweetCellTableViewCell.swift
//  
//
//  Created by Diego Rivas Lazala on 10/1/22.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    //"https://api.twitter.com/1.1/statuses/retweet/:id.json"
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success:{
            self.setRetweeted(true)
        }, failure:{ (error) in print("error in retweeting: \(error)")
        
        })
        }
                                         
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
 
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorit did not suceed: \(error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {(error) in
                print("Unfavorite did not suceed: \(error)")
            })
        }
    }
    
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"),for: UIControl.State.normal )
        }
        else{
            favButton.setImage(UIImage(named:"favor-icon"),for: UIControl.State.normal )
        }
    }
    
    @IBOutlet weak var retweetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
