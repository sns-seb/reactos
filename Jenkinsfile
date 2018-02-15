node('windows') {
 // https://issues.jenkins-ci.org/browse/JENKINS-38706
 ws("workspace/${env.JOB_NAME}") {
  ws {
    checkout scm
    stash includes: 'cfamily-build.patch, cfamily-build.cmd, cfamily-analyze.cmd', name: 'files'
  }

  stage 'checkout'
  git url: "https://github.com/sns-seb/reactos.git", branch: "master"
  unstash 'files'
  withSonarQubeCredentials {
    bat 'wget %SONARQUBE_URL%/static/cpp/build-wrapper-win-x86.zip'
    bat 'unzip -o build-wrapper-win-x86.zip'
  }

  stage 'build'
  bat 'cfamily-build.cmd'

  stage 'analyze'
  withScanner {
    bat 'cfamily-analyze.cmd'
  }
  if (fileExists('.sonar/cfamily-reproducer.zip')) {
    archiveArtifacts artifacts: '.sonar/cfamily-reproducer.zip'
  }
 }
}

def withSonarQubeCredentials(def body) {
  withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'af31d5fa-f22c-42d8-b6e4-177686ec44d5', usernameVariable: 'SONARQUBE_URL', passwordVariable: 'SONARQUBE_TOKEN']]) {
    body.call();
  }
}

def withScanner(def body) {
  def javaHome = tool name: 'Java 8', type: 'hudson.model.JDK'
  def scannerHome = tool name: "SonarQube Scanner 2.6.1", type: 'hudson.plugins.sonar.SonarRunnerInstallation'
  withSonarQubeCredentials {
    withEnv(["JAVA_HOME=${javaHome}", "PATH+SCANNER=${scannerHome}/bin"]) {
      body.call()
    }
  }
}
