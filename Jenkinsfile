node('windows') {
  deleteDir()
 // https://issues.jenkins-ci.org/browse/JENKINS-38706
 ws("workspace/${env.JOB_NAME}") {
  ws {
    checkout scm
    stash includes: 'cfamily-build.patch, cfamily-build.cmd, cfamily-analyze.cmd', name: 'files'
  }

  stage 'checkout'
  git url: "https://github.com/sns-seb/reactos.git", branch: "rebloch-work-branch"
  unstash 'files'
  withSonarQubeEnv('Rebloch (henri.gomez@sonarsource.com)') {
    bash 'curl -LsS %SONAR_HOST_URL%/static/cpp/build-wrapper-win-x86.zip > build-wrapper-win-x86.zip'
  }
  bat 'unzip -o build-wrapper-win-x86.zip'

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

def withScanner(def body) {
  def javaHome = tool name: 'OracleJDK8', type: 'hudson.model.JDK'
  def scannerHome = tool name: "SonarQube Scanner 2.6.1", type: 'hudson.plugins.sonar.SonarRunnerInstallation'
  withSonarQubeEnv('Rebloch (henri.gomez@sonarsource.com)') {
    withEnv(["JAVA_HOME=${javaHome}", "PATH+SCANNER=${scannerHome}/bin"]) {
      body.call()
    }
  }
}
