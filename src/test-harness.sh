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
######################## TEST HARNESS ########################
### Wrapper for all tests to run and then report on the output
###
### @see lib/output.sh
### @see tests/*.sh
##############################################################
##############################################################
##############################################################

##############################################################  
# Global `DEBUG` flag - anything but `true` will be ignored
##############################################################
export DEBUG=false

##############################################################  
# Include output (logging) support
##############################################################
source lib/output.sh;

##############################################################  
# Stub in cli help information
##############################################################
HELP_REGEX="^-+[hH].*";

if [[ $1 =~ $HELP_REGEX ]]; then
    echo "How to use $0...";
    echo "    ./$0";
    echo " ";
    echo " ";
    exit 0;
fi

##############################################################  
# prepare result output
results="\n\n==============================================\n\t\tTEST SUITE\t\t\n==============================================\n"
results="${results}Results for the test suite run:\n"
##############################################################

##############################################################
# Run all tests.  Test are identifed as any file in the `tests`
# folder.
##############################################################
for test in $(ls ./tests); do
    . tests/$test
    results="$results\n\t$test\treturned: $?"
done

##############################################################  
# finalize result output
l "$results\n\n==============================================\n\t\tCOMPLETE\t\t\n==============================================\n"
##############################################################  

exit 0;
