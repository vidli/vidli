## Welcome to Vidli

Vidli is the first of its kind Open Source Video eCommerce platform. Specifically designed for video content owners that are looking to setup a distribution storefront. Vidli is built on the Ruby on Rails framework.

Out of the box, Vidli integrates with PayPal Express checkout for payment processing and Amazon S3 for video streaming and storage.

## Getting Started

1. Copy the database.yml.example file to database.yml. Update with your login and password to your MySQL database.

    cp config/database.yml.example config/database.yml

2. Configure your AWS settings

    cp config/amazon_s3.yml.example config/amazon_s3.yml

3. Create the development and production buckets on AWS via http://console.aws.amazon.com that matches your config file.

4. Upload the lib/crossdomain.xml file to each bucket. Make sure permissions have Everyone -> Open/Download.

5. Signup at PayPal for a developer account

    http://developer.paypal.com

5. Setup your Vidli app config and ActiveMerchant for PayPal payments

    cp config/vidli_config.yml.example config/vidli_config.yml

## Who is Vidli for?

- Video content creators
- Video distributors

## Vidli comes with

- Simple, easy to use video content management system 
- Non-commercial use [JW Player](http://www.longtailvideo.com/players) video player
- Seamless integration with PayPal Express
- Integration with Amazon S3 for video storage and playback

## License

Vidli is released under the [MIT license](http://www.opensource.org/licenses/mit-license).