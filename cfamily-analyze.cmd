
sonar-scanner ^
    -e ^
    -Dsonar.verbose=true ^
    -Dsonar.host.url=%SONAR_HOST_URL% ^
    -Dsonar.login="f7cb919536e269f988d973f02e0167570e691be4" ^
    -Dsonar.cfamily.build-wrapper-output=cfamily-compilation-database ^
    -Dsonar.organization="sns-seb-github" ^
    -Dsonar.projectKey="rebloch-reactos" ^
    -Dsonar.projectName="ReactOS Windows" ^
    -Dsonar.projectVersion=latest ^
    -Dsonar.sourceEncoding=UTF-8 ^
    -Dsonar.sources=. ^
    -Dsonar.inclusions=**/*.c,**/*.cc,**/*.cpp,**/*.cxx,**/*.h,**/*.hh ^
    -Dsonar.scm.disabled=true ^
    -Dsonar.cpd.exclusions=**
