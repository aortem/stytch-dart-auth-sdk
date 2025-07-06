# stytch-dart-sample-app

## Description

A sample app to showcase the process of installing, setting up and using the stytch_dart_auth_sdk

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

- Add the absolute path of the stytch_dart_auth_sdk to the sample app's pubspec.yaml file
  ```yaml
  dependencies:
  stytch_dart_auth_sdk:
    path: /Users/user/Documents/GitLab/stytch_dart_auth_sdk/stytch_dart_auth_sdk
  ```

## Usage

    Depending on the platform stytch_dart_auth_sdk can be initialized via three methods

**Web:**
For Web we use Enviroment Variable

```
import 'package:flutter/material.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

    void main() async
    {

        stytchApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);

        stytchApp.instance.getAuth();

        runApp(const MyApp());
    }

```

- Import the stytch_dart_auth_sdk and the material app
  ```
  import 'package:flutter/material.dart';
  import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
  ```
- In the main function call the 'stytchApp.initializeAppWithEnvironmentVariables' and pass in your api key and project id

  ```
    stytchApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);
  ```

- Aftwards call the 'stytchApp.instance.getAuth()'
  ```
    stytchApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```

**Mobile:**
For mobile we can use either [Service Account](#serviceaccount) or [Service account impersonation](#ServiceAccountImpersonation)

## ServiceAccount

    ```
    import 'package:flutter/material.dart';
    import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

    void main() async
    {
        stytchApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');

        stytchApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the stytch_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
  ```

- In the main function call the 'stytchApp.initializeAppWithServiceAccount' function and pass the path to your the json file
  ```
   stytchApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');
  ```
- Aftwards call the 'stytchApp.instance.getAuth()'
  ```
    stytchApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```

## ServiceAccountImpersonation

    ```
    import 'package:flutter/material.dart';
    import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

    void main() async
    {
        stytchApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: service_account_email, userEmail: user_email)

        stytchApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the stytch_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
  ```

- In the main function call the 'stytchApp.initializeAppWithServiceAccountImpersonation' function and pass the service_account_email and user_email
  ```
    stytchApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: serviceAccountEmail,userEmail:userEmail,)
  ```
- Aftwards call the 'stytchApp.instance.getAuth()'
  ```
    stytchApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```
