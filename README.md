# A Dummy Auction Site

* An auction site where users can post items for bidding and bid on items that are on sale.
* A user could be a seller, a bidder or an administrator.
* The administrator manages all the items put for auction.
* All the items posted need to be approved by the admin before the auction. She can also delete them.
* After an auction is over, seller and admin can view their earnings and commissions.
* A bidder can see if he won or lost the bid.
* Multiple bidders can bid for the same item.
* A bidder can re-bid on the same item.

## Steps to install the application:

* Ruby version >= 2.2.1p85

If you don't have ruby installed on your machine, please follow the steps listed [here](https://www.ruby-lang.org/en/documentation/installation/)

* You can clone this project:
```
git clone https://github.com/vinig/AuctionSite.git
```

* In case you have the zip file:
```
unzip <zipfile>.zip -d AuctionSite
```

* Setup:
```
cd AuctionSite
bundle install
rake db:setup
rails s      
Visit localhost:3000
```

* You should begin by creating an admin user, then seller and bidder.
* Log in to your account.
* **Account** gives you access to your **Profile** (actions) and **Log out**.
* All the valid/on-going auctions can be viewed through **Sale**. 
* **View** gives you access to the item details like original price, auction start and end date.
A Bidder can bid by visiting **View**. She can Re-bid too.

### Admin
+ **View Earnings** to view the total commission earned so far.
+ **Manage Items** to view the list of all the items valid/invalid for auction.
+ **View** gives you access to approve/disapprove an auction and delete the auction.

### Seller
+ **View Earnings** to view the total amount earned through the auctions.
+ **Post new Item** to put a new item for auction. You can select both date and time for auction to start and end.
Start and End date-time should be greater than the current time.
End date-time should be greater than Start date-time.
+ The item can only be viewed under **Sale** once approved by the admin.

### Bidder
+ **View Bids** to view all bid on each item.
It informs the user of the verdict if she won or lost the bid. In case the auction hasn't ended, it shows Undecided.


