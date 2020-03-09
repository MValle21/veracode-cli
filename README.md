# Veracode Command line interface

## Automated way to check application status and DevSecops compliance


Analyze the latest build report according to the Adidas DevSecops compliance.
Checking the latest build status and delete the incomplete scans automatically to make sure the application is ready for a new scan request.

## Requirements
A Veracode API credential with Result API permission.

## Usage

```
Usage of veracode-cli:
  -appname string
        [Mandatory] Application Name
  -buildname string
        [Optional] Build Name
  -command string
        [Mandatory] Veracode command:
                getappid - Finding application ID by using application name.
                getbuildinfo - Showing the information of the latest build
                getbuildversion - Retrieving the latest build version name
                getbuildid - Retrieving the build id by using build name/version
                buildstatus - Checking the status of the latest build and delete it if it's been stuck
                compliancecheck - Checking DevSecops compliance of the latest build for specific application.
  -pass string
        [Mandatory] Password
  -user string
        [Mandatory] Username
  -version
        Prints the current version.

```

## Example

#### Checking DevSecops compliance for a specific application

```
./veracode-cli -user '<API_KEY>' -pass '<API_SECRET>' -command 'compliancecheck' -appname '<Application Profile Name>' -buildname <build name>
```

If the application is not compliant

```
2020/02/03 07:12:23 ComplianceCheck
2020/02/03 07:12:23 Finding App ID
2020/02/03 07:12:26 App ID:  ****
2020/02/03 07:12:26 Requesting build info
2020/02/03 07:12:27 The build status is [Results Ready]
2020/02/03 07:12:27 Requesting full report
2020/02/03 07:12:28 [Result] { High & V.High: 0 , Medium: 37 }
2020/02/03 07:12:28 [Error] your application is not compliant!
```

#### Checking Application status.

```
./veracode-cli -user '<API_KEY>' -pass '<API_SECRET>' -command 'buildstatus' -appname '<Application Profile Name>'
```

The latest build will be deleted if the status is incomplete

```
2020/02/03 06:33:01 Checking Build status
2020/02/03 06:33:01 Finding App ID
2020/02/03 06:33:04 App ID:  ***
2020/02/03 06:33:04 Requesting build info
2020/02/03 06:33:05 The build status is [Incomplete]
2020/02/03 06:33:05 Deleting last build
2020/02/03 06:33:06 [Success] The scan was stuck and successfully deleted.
```

## Cross compile

```
$ go get github.com/mitchellh/gox
$ gox --output veracode-cli_{{.OS}}_{{.Arch}}
```

## Publishing a release

Edit [version](./version) file to change the version accoring to [semver](https://semver.org/). Commit the changes and then create a tag:

```
git tag -a $(make version) -m '$(make version)'
```

Once the tag is created, push the changes and Travis will automatically perform the release.


## License and Software Information

© adidas AG

adidas AG publishes this software and accompanied documentation (if any) subject to the terms of the MIT license with the aim of helping the community with our tools and libraries which we think can be also useful for other people. You will find a copy of the MIT license in the root folder of this package. All rights not explicitly granted to you under the MIT license remain the sole and exclusive property of adidas AG.

NOTICE: The software has been designed solely for the purpose of analyzing the code quality by checking the coding guidelines. The software is NOT designed, tested or verified for productive use whatsoever, nor or for any use related to high risk environments, such as health care, highly or fully autonomous driving, power plants, or other critical infrastructures or services.

If you want to contact adidas regarding the software, you can mail us at _software.engineering@adidas.com_.

For further information open the [adidas terms and conditions](https://github.com/adidas/adidas-contribution-guidelines/wiki/Terms-and-conditions) page.

### License

[MIT](LICENSE)
