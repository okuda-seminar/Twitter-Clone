package main

test_deny_missing_env_for_db_url {
    input := {
        "kind": "Deployment",
        "spec": {
            "template": {
                "spec": {
                    "containers": [
                        {
                            "name": "users-app",
                            "env": [
                                {
                                    "name": "PGURL",
                                    "value": "postgres://user:password@hostname:5432/dbname"
                                }
                            ]
                        }
                    ]
                }
            }
        }
    }
    deny_missing_env_for_db_url with input as input
}

test_deny_missing_env_for_db_url_fails {
    input := {
        "kind": "Deployment",
        "spec": {
            "template": {
                "spec": {
                    "containers": [
                        {
                            "name": "users-app",
                            "env": [
                                {
                                    "name": "OTHER_ENV",
                                    "value": "somevalue"
                                }
                            ]
                        }
                    ]
                }
            }
        }
    }
    deny_missing_env_for_db_url[message] with input as input
    message == "The container in the Deployment must have a 'PGURL' environment variable."
}

test_deny_no_corresponding_depl_exist {
    input := [
        {
            "kind": "Service",
            "contents": {
                "metadata": {
                    "name": "users-app-service"
                },
                "spec": {
                    "selector": {
                        "app": "users-app"
                    }
                }
            }
        },
        {
            "kind": "Deployment",
            "contents": {
                "metadata": {
                    "name": "users-app-deployment"
                },
                "spec": {
                    "template": {
                        "metadata": {
                            "labels": {
                                "app": "users-app"
                            }
                        }
                    }
                }
            }
        }
    ]
    deny_no_corresponding_depl_exist with input as input
}

test_deny_no_corresponding_depl_exist_fails {
    input := [
        {
            "kind": "Service",
            "contents": {
                "metadata": {
                    "name": "users-app-service"
                },
                "spec": {
                    "selector": {
                        "app": "users-app"
                    }
                }
            }
        }
    ]
    deny_no_corresponding_depl_exist with input as input
}