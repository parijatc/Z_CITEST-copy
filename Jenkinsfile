node {

    //Wipe the workspace so that we are building completely clean
    //deleteDir()

    stage('Checkout') {

        // Checkout files.
        checkout([
            $class: 'GitSCM',
            branches: [[name: '*/master']],
            doGenerateSubmoduleConfigurations: false,
            extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [],
            userRemoteConfigs: [[
                credentialsId: '6c17c82f-93e1-4c72-904d-593e5accd4c3',
                url: 'https://github.com/parijatc/Z_CITEST-copy.git'
            ]]
        ])
    }

    stage('build') {
        // Build
        //sh 'security unlock-keychain -p jenkins ${HOME}/Library/Keychains/jenkins.keychain'

        sh 'security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k  niit123 login.keychain'

        sh '/usr/bin/xcodebuild -scheme JenkinsTesting -configuration Release clean build archive -archivePath /Users/Shared/Jenkins/Home/workspace/pipelinetest1/build/Release-iphoneos/JenkinsTesting.xcarchive DEVELOPMENT_TEAM=UAWU67869T'

        sh '/usr/bin/xcodebuild -exportArchive -archivePath /Users/Shared/Jenkins/Home/workspace/z_citest/build/Release-iphoneos/JenkinsTesting.xcarchive -exportPath /Users/Shared/Jenkins/Home/workspace/pipelinetest1/build -exportOptionsPlist /Users/Shared/Jenkins/Home/workspace/pipelinetest1/build/ad-hocUAWU67869TExportOptions.plist'
    }

    stage('fastlane') {
        sh 'whereis fastlane'

        dir ('/Users/Shared/Jenkins/z_citest') {
            fastlane("scan")
        }
       //sh 'fastlane("beta")'
    }

    stage('test') {
        //testing
        //sh 'xcodebuild -scheme "JenkinsTesting" -configuration "Debug" build test -destination "platform=iOS Simulator,name=iPhone 8,OS=11.2" -enableCodeCoverage YES | /usr/local/bin/xcpretty -r junit'
    }

    stage('post-build') {
        // Publish test restults.
        //step([$class: 'JUnitResultArchiver', allowEmptyResults: true, testResults: 'build/reports/junit.xml'])
    }

    stage('archive') {
        //Archiving artifacts
        archiveArtifacts '**'
    }
}

def fastlane(lane) {
def env = [
"PATH+LOCAL=/usr/local/bin/",
//“HTTP_PROXY=http://dmzproxy.tech.rz.db.de:8080",
//“HTTPS_PROXY=http://dmzproxy.tech.rz.db.de:8080",
"LC_ALL=en_US.UTF-8",
"LANG=en_US.UTF-8",
"FASTLANE_EXPLICIT_OPEN_SIMULATOR=2"
]

withEnv(env) {
timeout(time: 30, unit: 'MINUTES') {
wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm', 'defaultFg': 1, 'defaultBg': 2]) {
sh "fastlane ${lane}"
}
}
}
}



