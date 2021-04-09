# Packages


flutter create --template=package name_of_the_package

flutter pub upgrade

 - Official documentation [here](https://flutter.dev/docs/development/packages-and-plugins/using-packages)
 - Tuto on Medium - [article](https://medium.com/flutter-community/how-to-create-publish-and-manage-flutter-packages-b4f2cd2c6b90)

### git package depends on another git package
 - add **publish_to: 'none'** in pubspec.yaml

## Versioning

When modifying package, don't forget to change the version number in **pubspec.yaml** <br>
In the project using this package, run *flutter pub upgrade* to get the latest version 
