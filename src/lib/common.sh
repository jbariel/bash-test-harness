#!/bin/bash

##################################################################
## Licensed to the Apache Software Foundation (ASF) under one   ##
## or more contributor license agreements.  See the NOTICE file ##
## distributed with this work for additional information        ##
## regarding copyright ownership.  The ASF licenses this file   ##
## to you under the Apache License, Version 2.0 (the            ##
## "License"); you may not use this file except in compliance   ##
## with the License.  You may obtain a copy of the License at   ##
##                                                              ##
##   http://www.apache.org/licenses/LICENSE-2.0                 ##
##                                                              ##
## Unless required by applicable law or agreed to in writing,   ##
## software distributed under the License is distributed on an  ##
## "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY       ##
## KIND, either express or implied.  See the License for the    ##
## specific language governing permissions and limitations      ##
## under the License.                                           ##
##################################################################

##############################################################
##############################################################
####################### COMMON LIBRARY #######################
### Location to store common functions.  Use with:
###     `source lib/output.sh`
### Can be used to create a set of libraries that are common
### across all tests.
##############################################################
##############################################################
##############################################################

##############################################################
# Randomly return a value between 0 and 255
# @see `$RANDOM`
##############################################################
function randomReturn() {
    return $((RANDOM%255));
}
