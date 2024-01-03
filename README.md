## Simoxy eSIM iOS Framework Integration Guide

**Minimum iOS SDK Version Required**: 13.0

**Requirements for Submission to the Simoxy Team:**

 1. Apple ID and Bundle ID of your application.
 2. Your application's Production Push Certificate (.pem file) along with its password, if it has one.
 3. Your application's App-Specific Shared Secret, which can be found on your app's App Store Connect information page.
 4. Configure your application to use the App Store Server Notifications Production URL provided by the Simoxy Team. If you
    already have an existing URL, please use this PHP repository to forward notifications to our servers.

**What You Will Receive from the Simoxy Team:**
 1. A dashboard link to view your application's statistics and earnings.
 2. An API Key for use with this SDK.
 3. Information on your domain's nameserver settings.
 

## Instructions for SDK Installation:

 1. Download the ESimKit.xcframework from this repository.
 2. Drag and drop the framework into your Application's Frameworks folder.
Don't forget to check "**Copy items if needed**" and be sure to check your app as the target.

![0](https://github.com/SimoxyKits/ESimKit/assets/3602109/8e1e33a7-a32f-408e-99c6-246b1e81594f)

 3. Go to your target's "General" tab and scroll down to "Frameworks, Libraries, and Embedded Content" area.
Be sure to choose "**Embed & Sign**" for **ESimKit.xcframework**

![Screenshot 2024-01-03 at 17 34 31](https://github.com/SimoxyKits/ESimKit/assets/3602109/9f8d6558-66bc-4734-922c-63b8139ec966)

 4. Make sure that "**Embed Frameworks**" configuration must be placed above "**Run Script**" configuration in your application target -> Build Phases.

 ![Screenshot 2024-01-03 at 17 46 58](https://github.com/SimoxyKits/ESimKit/assets/3602109/67d80f2c-f02d-4e8c-974e-223650468a16)

 5. Add those to your Podfile (change *YourAppTargetName*):
```
platform :ios, '13.0'

target 'YourAppTargetName' do
  use_frameworks!
  
  pod 'SPIndicator'
  pod 'RNCryptor'
  pod 'Alamofire'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxDataSources'
  pod 'Kingfisher'
  
  pod 'IBAnimatable'
  pod 'KeychainSwift'
  pod 'NVActivityIndicatorView'
  pod 'CryptoSwift'
  pod 'DateToolsSwift'
  pod 'PhoneNumberKit'
  pod 'SwiftyStoreKit'
  pod 'SwiftWebVC', :git => 'https://github.com/Up2dateSoftware/SwiftWebVC'
  pod 'SAConfettiView', :git => 'https://github.com/isayeter/SAConfettiView'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
	config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
    
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
	config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
    
    # fix xcode 15 DT_TOOLCHAIN_DIR - remove after fix oficially - https://github.com/CocoaPods/CocoaPods/issues/12065
    installer.aggregate_targets.each do |target|
	target.xcconfigs.each do |variant, xcconfig|
	    xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
	    IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
	end
    end
    
    installer.pods_project.targets.each do |target|
	target.build_configurations.each do |config|
	    if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
		xcconfig_path = config.base_configuration_reference.real_path
		IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
	    end
	end
    end
end
```
6. Run ```pod install``` command to update your Pods.
7. Add ```import ESimKit``` to your AppDelegate file.
8. In AppDelegate file, in your ```func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool ``` method, start the SDK, like:
```
ESimKitManager.shared.startSDK(
    apiKey: "yourApiKey",
    inAppIdForCurrency: "testsimoxy",
    domain: "https://backend.simoxy.com/",
    privacyUrl: URL(string: "https://backend.simoxy.com/docs/tos")!,
    tosURL: URL(string: "https://backend.simoxy.com/docs/privacy")!
)
```
9. Whenever you want to present ESimKit main page, please call 
	```ESimKitManager.shared.presentESimVC(on: self)```
	Don't forget to import the module at beginning of your controller file: ```import ESimKit```
10. Build & Run



## Assets and Presentences

To access ESimKit's assets for customizing images and sample localized sentences (available in 34 languages), please see the Demo app. You have the option to use any of these preset localized sentences in your application:

	"esimkit_sentences_small_1" = "Are you planning to go abroad?";
	"esimkit_sentences_small_2" = "Get your eSIM now!";
	"esimkit_sentences_small_3" = "Get super-fast internet in every country.";
	"esimkit_sentences_small_4" = "eSIMs for 194 countries and regions.";
	"esimkit_sentences_small_5" = "Get your traveler eSIM now!";
	"esimkit_sentences_small_6" = "Worldwide internet for travelers!";
	"esimkit_sentences_long_1" = "Install a travel eSIM on your phone and roam like at home in 194 countries.";
	"esimkit_sentences_long_2" = "Get super-fast 4G/LTE and 5G mobile data in every country.";
	"esimkit_sentences_long_3" = "Activation on an eSIM compatible phone or mobile device takes less than 5 minutes, no SIM card needed.";
	"esimkit_sentences_long_4" = "Are you planning to go abroad? Switch networks effortlessly. No physical SIMs - just tap and connect to the internet!";
	"esimkit_sentences_slogans_1" = "Fast Mobile Data";
	"esimkit_sentences_slogans_2" = "Instant Activation";

![demoapp](https://github.com/SimoxyKits/ESimKit/assets/3602109/135e1a72-6ba5-43a2-a4a6-cc75f8fdcb53)




## Extra Configurations:

You can customize all screens, sentences, colors and icons. Please see detailed configuration below, all configurations are optional. Below, you see default configurations.

*Images used in ESimKitPNGImage method can be found in the Demo app Assets file.*

    ESimKitManager.shared.startSDK(
    	apiKey: "yourApiKey",
    	inAppIdForCurrency: "testsimoxy",
    	domain: "https://backend.simoxy.com/",
    	privacyUrl: URL(string: "https://backend.simoxy.com/docs/tos")!,
    	tosURL: URL(string: "https://backend.simoxy.com/docs/privacy")!,
    	configuration: ESimKitConfiguration(
    	    //pagesBgColor: ESimKitColor(colorHex: "ECFAFF"),
    	    headerNavBarConfig: ESimKitHeaderNavBarConfig(
    	        //bgColor: ESimKitGradientColor(
    	        //    startColor: ESimKitColor(colorHex: "2980B9"),
    	        //    endColor: ESimKitColor(colorHex: "2980B9"),
    	        //    direction: .topToBottom
    	        //)
    	        //closeImage: ESimKitPNGImage(photo: UIImage(named: "btn-close-x-white")),
    	        //titleIconEnabled: true,
    	        //titleIcon:  ESimKitPNGImage(photo: UIImage(named: "esim_internet")),
    	        //refreshIcon: ESimKitPNGImage(photo: UIImage(named: "icon_refresh_new")),
    	        //refreshActivityColor: ESimKitColor(colorHex: "FFFFFF")
    	    ),
    	    searchBarConfig: ESimKitSearchBarConfig(
    	        //tintColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //font: ESimKitFont(name: "Montserrat-Medium", size: 13.0),
    	        //placeHolderText: "Search",
    	        //textColor: ESimKitColor(colorHex: "111828")
    	    ),
    	    headerInfoAreaConfig: ESimKitHeaderInfoAreaConfig(
    	        //isEnabled: true,
    	        //bGColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //iconsBGColor: ESimKitColor(colorHex: "2980B9"),
    	        //borderColor: ESimKitColor(colorHex: "111828", alpha: 0.18),
    	        //paginationSelectedColor: ESimKitColor(colorHex: "2980B9"),
    	        //paginationUnselectedColor: ESimKitColor(colorHex: "AAAAAA")
    	    ),
    	    tableViewConfig: ESimKitTableViewConfig(
    	        //headerBgColor: ESimKitColor(colorHex: "2980b9"),
    	        //headerTitleFont: ESimKitFont(name: "Montserrat-Medium", size: 15.0),
    	        //headerTitleColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //cellBgColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //cellBorderColor: ESimKitColor(colorHex: "111828", alpha: 0.12),
    	        //cellRegionsBgColorInside: ESimKitColor(colorHex: "ECFAFF"),
    	        //cellRegionsBorderColorInside: ESimKitColor(colorHex: "111828", alpha: 0.12),
    	        //cellArrowBgColor: ESimKitColor(colorHex: "2980B9"),
    	        //titleFont: ESimKitFont(name: "Montserrat-Bold", size: 14.0),
    	        //titleColor: ESimKitColor(colorHex: "111828"),
    	        //descFont: ESimKitFont(name: "Montserrat-Bold", size: 13.0),
    	        //descColor: ESimKitColor(colorHex: "555555")
    	        //image5G: ESimKitPNGImage(photo: UIImage(named: "yesim_5g3_black")),
    	        //imageLTE: ESimKitPNGImage(photo: UIImage(named: "yesim_lte_black")),
    	        //imageHotspot: ESimKitPNGImage(photo: UIImage(named: "yesim_hotspot_black"))
    	    ),
    	    sentences: ESimKitSentences(
    	        //mainPageTitle: ESimKitSentence(
    	        //    text: "",
    	        //    font: ESimKitFont(name: "Montserrat-Bold", size: 16.0),
    	        //   color: ESimKitColor(colorHex: "FFFFFF")
    	        //),
    	        //whereAreYouTraveling: ESimKitSentence(
    	        //    text: "",
    	        //    font: ESimKitFont(name: "Montserrat-Medium", size: 14.0),
    	        //    color: ESimKitColor(colorHex: "111828")
    	        //),
    	        //yourPackagesTitle: ESimKitSentence(
    	        //    text: "",
    	        //    font: ESimKitFont(name: "Montserrat-Bold", size: 16.0),
    	        //    color: ESimKitColor(colorHex: "FFFFFF")
    	        //),
    	        //activateESIMTitle: ESimKitSentence(
    	        //    text: "",
    	        //    font: ESimKitFont(name: "Montserrat-Bold", size: 16.0),
    	        //    color: ESimKitColor(colorHex: "FFFFFF")
    	        //)
    	    ),
    	    detailPageConfig: ESimKitDetailPageConfig(
    	        //titleFont: ESimKitFont(name: "Montserrat-SemiBold", size: 16.0),
    	        //titleFontColor: ESimKitColor(colorHex: "ffffff")
    	        //navigationBackImage: ESimKitPNGImage(photo: UIImage(named: "btn-back-white2")),
    	        //featuresAreaBgColor: ESimKitColor(colorHex: "ffffff"),
    	        //featuresAreaImageBgColor: ESimKitColor(colorHex: "2980b9", alpha: 0.1),
    	        //featuresAreaTitleFont:  ESimKitFont(name: "Montserrat-Regular", size: 12.0),
    	        //featuresAreaTitleFontColor: ESimKitColor(colorHex: "111828"),
    	        //features5GImage: ESimKitPNGImage(photo: UIImage(named: "yesim_5g3_black")),
    	        //featuresLTEImage: ESimKitPNGImage(photo: UIImage(named: "yesim_lte_black")),
    	        //featuresHotspotImage: ESimKitPNGImage(photo: UIImage(named: "yesim_hotspot_black")),
    	        //featuresInstantActivationImage: ESimKitPNGImage(photo: UIImage(named: "yesim_5g3_black")),
    	        //labelAvailableInCountriesFont: ESimKitFont(name: "Montserrat-Medium", size: 14.0),
    	        //labelAvailableInCountriesFontColor: ESimKitColor(colorHex: 545454),
    	        //availableCountriesBgColor: ESimKitColor(colorHex: "FFFFFF", alpha: 0.7),
    	        //availableCountriesPlaceHolderColor: ESimKitColor(colorHex: "2980b9"),
    	        //availableCountriesBorderColor: ESimKitColor(colorHex: "111828", alpha: 0.12),
    	        //availableCountriesLabelFont: ESimKitFont(name: "Montserrat-Regular", size: 13.0),
    	        //availableCountriesLabelColor: ESimKitColor(colorHex: "111828"),
    	        //pricesCellBgColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //pricesCellBorderColor: ESimKitColor(colorHex: "111828", alpha: 0.12),
    	        //pricesCellImage1: ESimKitPNGImage(photo: UIImage(named: "esim_package_1")),
    	        //pricesCellImage2: ESimKitPNGImage(photo: UIImage(named: "esim_package_3")),
    	        //pricesCellImage3: ESimKitPNGImage(photo: UIImage(named: "esim_package_5")),
    	        //pricesCellImage4: ESimKitPNGImage(photo: UIImage(named: "esim_package_10")),
    	        //pricesCellImage5: ESimKitPNGImage(photo: UIImage(named: "esim_package_50")),
    	        //pricesCellTitleFont: ESimKitFont(name: "Montserrat-SemiBold", size: 14.0),
    	        //pricesCellTitleFontColor: ESimKitColor(colorHex: "111828"),
    	        //pricesCellDescFont: ESimKitFont(name: "Montserrat-SemiBold", size: 11.0),
    	        //pricesCellDescFontColor: ESimKitColor(colorHex: "AFB0B5"),
    	        //pricesCellDescBorderColor: ESimKitColor(colorHex: "AFB0B5"),
    	        //pricesPriceButtonBgColor: ESimKitColor(colorHex: "FFFFFF"),
    	        //pricesPriceButtonBorderColor: ESimKitColor(colorHex: "2980B9", alpha: 0.4),
    	        //pricesPriceButtonFont: ESimKitFont(name: "Montserrat-Medium", size: 12.0),
    	        //pricesPriceButtonFontColor: ESimKitColor(colorHex: "2980B9"),
    	        //bottomTextsFont: ESimKitFont(name: "Montserrat-Regular", size: 11.0),
    	        //bottomTextsColor: ESimKitColor(colorHex: "AFB0B5")
    	    ),
    	    myEsimsPageConfig: ESimKitMyEsimsPageConfig(
    	        //navigationBackImage: ESimKitPNGImage(photo: UIImage(named: "btn-back-white2")),
    	        //cellCountryNameFont: ESimKitFont(name: "Montserrat-Bold", size: 20.0),
    	        //cellCountryNameFontColor: ESimKitColor(colorHex: "111828"),
    	        //cellTitleFont: ESimKitFont(name: "Montserrat-Medium", size: 14.0),
    	        //cellTitleFontColor: ESimKitColor(colorHex: "111828"),
    	        //cellDescFont: ESimKitFont(name: "Montserrat-Light", size: 14.0),
    	        //cellDescFontColor: ESimKitColor(colorHex: "434343"),
    	        
    	        //iconsBgColor: ESimKitColor(colorHex: "2980B9", alpha: 0.1),
    	        //mainButtonBgColorEnabled: ESimKitGradientColor(
    	        //    startColor: ESimKitColor(colorHex: "2980b9"),
    	        //    endColor: ESimKitColor(colorHex: "2980b9"),
    	        //    direction: .topToBottom
    	        //)
    	        //mainButtonBgColorDisabled: ESimKitGradientColor(
    	        //    startColor: ESimKitColor(colorHex: "ffffff"),
    	        //    endColor: ESimKitColor(colorHex: "ffffff"),
    	        //    direction: .topToBottom
    	        //),
    	        //mainButtonBorderColorEnabled: ESimKitColor(colorHex: "2980b9"),
    	        //mainButtonBorderColorDisabled: ESimKitColor(colorHex: "d9dbe0"),
    	        //mainButtonFont: ESimKitFont(name: "Montserrat-Semibold", size: 16.0),
    	        //mainButtonFontColorEnabled: ESimKitColor(colorHex: "ffffff"),
    	        //mainButtonFontColorDisabled: ESimKitColor(colorHex: "434343")
    	    ),
    	    activateEsimPageConfig: ESimKitActivateEsimPageConfig(
    	        //navigationBackImage: ESimKitPNGImage(photo: UIImage(named: "btn-back-white2")),
    	        //navBarSelectedBgColor: ESimKitColor(colorHex: "2980b9"),
    	        //navBarUnSelectedBgColor: ESimKitColor(colorHex: "d0d2d8"),
    	        //navBarTitlesFont: ESimKitFont(name: "Montserrat-Semibold", size: 14.0),
    	        //navBarTitleSelectedFontColor: ESimKitColor(colorHex: "ffffff"),
    	        //navBarTitleUnSelectedFontColor: ESimKitColor(colorHex: "ffffff"),
    	        //qrIcon: ESimKitPNGImage(photo: UIImage(named: "icon_esim_qr")),
    	        //tipIcon: ESimKitPNGImage(photo: UIImage(named: "icon_esim_info")),
    	        //manuelIcon: ESimKitPNGImage(photo: UIImage(named: "icon_esim_manual")),
    	        //cellsRightArrowIcon: ESimKitPNGImage(photo: UIImage(named: "icon-right-arrow-wh")),
    	        //cellsRightArrowIconsBgColor: ESimKitColor(colorHex: "2980B9"),
    	        //cellsTitleFont: ESimKitFont(name: "Montserrat-Semibold", size: 20.0),
    	        //cellsTitleFontColor: ESimKitColor(colorHex: "111828"),
    	        //cellsDescFont: ESimKitFont(name: "Montserrat-Medium", size: 13.0),
    	        //cellsDescFontColor: ESimKitColor(colorHex: "111828"),
    	        //cellsActivationCodeFont: ESimKitFont(name: "Montserrat-Bold", size: 13.0),
    	        //cellsActivationCodeFontColor: ESimKitColor(colorHex: "111828"),
    	        //sendButtonBgColor: ESimKitColor(colorHex: "0E0847"),
    	        //sendButtonBorderColor: ESimKitColor(colorHex: "9790CC")
    	        //sendButtonFont: ESimKitFont(name: "Montserrat-Semibold", size: 13.0),
    	        //sendButtonFontColor: ESimKitColor(colorHex: "ffffff")
    	        //clickToCopyButtonBgColor: ESimKitColor(colorHex: "ffffff"),
    	        //clickToCopyButtonBorderColor: ESimKitColor(colorHex: "ECEAFF"),
    	        //clickToCopyButtonFont: ESimKitFont(name: "Montserrat-Semibold", size: 13.0),
    	        //clickToCopyButtonFontColor: ESimKitColor(colorHex: "2980B9")
    	    )
    	)
    )

For further assistance, please reach out to us at: https://simoxy.com
