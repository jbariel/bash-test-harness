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
####################### OUTPUT LIBRARY #######################
### Basic output library for bash scripts.  Use with:
###     `source lib/output.sh`
### Adds the following functions (and their alias):
### * level - set level of output
### * l - echo all params with `-e` flag enabled
### * log - call `l` with formatted ISO Date and level
### * trace (t) - trace output
### * debug (d) - debug output
### * info (i) - info output
### * warn (w) - warn output
### * error (e) - error output
### * fatal (f) - fatal output
##############################################################
##############################################################
##############################################################

##############################################################
# Define all log levels as numbers
# TODO - should refactor to make this cleaner...
LVL_ALL=0
LVL_TRACE=1
LVL_DEBUG=2
LVL_INFO=3
LVL_WARN=4
LVL_ERROR=5
LVL_FATAL=6
LVL_NONE=7
##############################################################

##############################################################
# Manage the actual log level
##############################################################
export OUT_LVL=$LVL_INFO

##############################################################
# Set the log level (to control what outputs)
##############################################################
function level() { 
    req_lvl=$1; 
    if [ -z $req_lvl ] || [ $req_lvl -gt $LVL_NONE ] || [ $req_lvl -lt $LVL_ALL ]; then req_lvl=$LVL_INFO; fi;
    OUT_LVL=$req_lvl;
}

##############################################################  
# base logger
#
# echos `$@` with the `-e` flag enabled
##############################################################
function l() {
    echo -e "$@";
}

##############################################################  
# base log statement
#
# shows ISO formatted date and log level
# @see l()
##############################################################
function log() {
    LVL=$1 && shift;
    l "[$(date +%FT%T)] [$LVL] $@";
}

##############################################################  
# TRACE level logging output - used for deep tracing
##############################################################
function trace() { if [ $OUT_LVL -le $LVL_TRACE ]; then log 'TRACE' $@; fi; }

##############################################################  
# DEBUG level logging output - used for debugging
##############################################################
function debug() { if [ $OUT_LVL -le $LVL_DEBUG ]; then log 'DEBUG' $@; fi; }

##############################################################  
# INFO level logging output - standard logging information
##############################################################
function info() { if [ $OUT_LVL -le $LVL_INFO ]; then log 'INFO ' $@; fi; }

##############################################################  
# WARN level logging output - used for warnings in code
##############################################################
function warn() { if [ $OUT_LVL -le $LVL_WARN ]; then log 'WARN ' $@; fi; }

##############################################################  
# ERROR level logging output - used for errors not causing termination
##############################################################
function error() { if [ $OUT_LVL -le $LVL_ERROR ]; then log 'ERROR' $@; fi; }

##############################################################  
# FATAL level logging output - used for termination cases
##############################################################
function fatal() { if [ $OUT_LVL -le $LVL_FATAL ]; then log 'FATAL' $@; fi; }

##############################################################  
# Aliases for output (for the lazy in us all)
function t() { trace $@; }
function d() { debug $@; }
function i() { info $@; }
function w() { warn $@; }
function e() { error $@; }
function f() { fatal $@; }
##############################################################

##############################################################  
# Validation of all log statements
#
# Will set log level then call each level of output.  Validates
# that only the levels that should be visible are displayed
##############################################################
function testAllOut() {
    for lvl in $(seq $LVL_ALL $LVL_NONE); do 
        level $lvl;

        l "\n-----------------------------------------"
        log 'TEST' "\nChecking log outputs when log level is: '$OUT_LVL'" 
        l "-----------------------------------------\n"
        l "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv\n"

        trace 'Trace me';
        debug 'Debug me';
        info 'Info me';
        warn 'Warn me';
        error 'Error me';
        fatal 'Fatal me';

        t 'T(race) me';
        d 'D(ebug) me';
        i 'I(nfo) me';
        w 'W(arn) me';
        e 'E(rror) me';
        f 'F(atal) me';
    done
}

##############################################################
# If `$DEBUG` is set to `true` will call testAllOut()
##############################################################
if [ -n $DEBUG ] && [ 'true' = "$DEBUG" ]; then
    testAllOut
fi
