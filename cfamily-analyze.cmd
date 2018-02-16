
sonar-scanner ^
    -e ^
    -Dsonar.verbose=true ^
    -Dsonar.host.url=%SONAR_HOST_URL% ^
    -Dsonar.login="9364c0b16b79933e9af94663ecee9edb17a4e604" ^
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
