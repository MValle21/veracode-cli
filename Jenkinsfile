@Library('GlobalJenkinsLibrary@2') _

def artifactoryCredentials = 'svc_devsecops'
def artifactoryRepository = 'https://tools.adidas-group.com/artifactory/devsecops-local/veracode-cli'


def withGoPath(Closure body) {
    try {
        steps.withEnv([
            "GOPATH=${env.WORKSPACE}/gopath",
            "PATH=${env.WORKSPACE}/gopath/bin:${env.PATH}"
        ]) {
            body()
        }
    } finally {
        steps.sh "rm -rf ${steps.env.WORKSPACE}/gopath"
    }
}

node('incubation') {
    stage('Collect info') {
        checkout scm
    }

    stage('Build') {
        withGoPath {
            sh 'go get ./...'
            sh 'go build'
        }
    }

    if (env.BRANCH_NAME == 'master') {
        stage('Cross-compile') {
            withGoPackages(['github.com/mitchellh/gox']) {
                sh 'gox --output "veracode-cli_{{.OS}}_{{.Arch}}"'
            }
        }

        stage('Publish') {
            withCredentials([
                usernamePassword(credentialsId: artifactoryCredentials, usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASS')
            ]) {
                for (String file in findFiles(glob: 'veracode-cli_*')) {
                    sh "curl -u${ARTIFACTORY_USER}:${ARTIFACTORY_PASS} -T ${file.name} ${artifactoryRepository}/${file.name}"
                }
            }
        }
    }
}
