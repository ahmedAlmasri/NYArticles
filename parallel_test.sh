devices=(
	"iPhone 8"
	"iPhone 8 Plus"
	"iPhone SE (1st generation)"
	"iPad Pro (11-inch)"
	"iPhone Xʀ")

workspace="NYArticles"

scheme="NYArticles"

myCommand="xcodebuild test -workspace $workspace.xcworkspace -scheme $scheme"

for index in ${!devices[*]}
do
    myCommand+=" -destination 'platform=iOS Simulator,name=${devices[$index]}'"
done

eval $myCommand