#!/bin/sh

test=$(cat ~/disk/git/plaxelss/.idea/workspace.xml | xq -r '.project.component[] | select(."@name" == "RunManager") | ."@selected"' | sed 's/Google Test\.//' | sed 's/\./() > /2')
#test=$(cat ~/disk/git/storemydocs/.idea/workspace.xml | xq -r '.project.component[] | select(."@name" == "RunManager") | ."@selected"' | sed 's/Karma\.//' | sed 's/\./() > /2')

echo " TDD: $test"
