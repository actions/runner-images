#!/bin/bash -e -o pipefail

# This script adds permissions, which are required for some installed tools to work properly, to the TCC.db

source ~/utils/utils.sh

# /Library/Application\ Support/com.apple.TCC/TCC.db
systemValuesArray=(
    "'kTCCServiceAccessibility','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServicePostEvent','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321326"
    "'kTCCServiceSystemPolicyAllFiles','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceAccessibility','com.apple.dt.Xcode-Helper',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1551941368"
    "'kTCCServiceSystemPolicyAllFiles','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceAccessibility','/usr/libexec/sshd-keygen-wrapper',1,2,0,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,NULL,'UNUSED',NULL,0,1591112564"
    "'kTCCServiceAccessibility','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,NULL,'UNUSED',NULL,0,1591180502"
    "'kTCCServiceAccessibility','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServiceScreenCapture','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1599831148"
)
for values in "${systemValuesArray[@]}"; do
    configure_system_tccdb "$values"
done

# $HOME/Library/Application\ Support/com.apple.TCC/TCC.db
userValuesArray=(
    "'kTCCServiceUbiquity','com.apple.mail',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1551941469"
    "'kTCCServiceUbiquity','com.apple.TextEdit',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465787445646974000000000003',NULL,NULL,'UNUSED',NULL,0,1566368356"
    "'kTCCServiceUbiquity','com.apple.CloudDocs.MobileDocumentsFileProvider',0,2,0,1,X'fade0c000000004c0000000100000006000000020000002f636f6d2e6170706c652e436c6f7564446f63732e4d6f62696c65446f63756d656e747346696c6550726f76696465720000000003',NULL,NULL,'UNUSED',NULL,0,1570793290"
    "'kTCCServiceAppleEvents','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1574241374"
    "'kTCCServiceSystemPolicyAllFiles','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceAppleEvents','/usr/libexec/sshd-keygen-wrapper',1,2,0,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1591112538"
    "'kTCCServiceAppleEvents','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1591180478"
    "'kTCCServiceAppleEvents','/usr/libexec/sshd-keygen-wrapper',1,2,0,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1591357685"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1591532620"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.finder',NULL,NULL,1592919552"
    "'kTCCServiceMicrophone','com.apple.CoreSimulator.SimulatorTrampoline',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576347152"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServiceUbiquity','/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/Versions/A/Support/photolibraryd',1,2,5,1,NULL,NULL,NULL,'UNUSED',NULL,0,1619461750"
    "'kTCCServiceUbiquity','com.apple.PassKitCore',0,2,5,1,NULL,NULL,NULL,'UNUSED',NULL,0,1619516250"
    "'kTCCServiceAppleEvents','/Library/Application Support/Veertu/Anka/addons/ankarund',1,2,3,1,X'fade0c00000000ac0000000100000006000000020000001e636f6d2e7665657274752e616e6b612e6164646f6e732e616e6b6172756e0000000000060000000f000000060000000e000000010000000a2a864886f76364060206000000000000000000060000000e000000000000000a2a864886f7636406010d0000000000000000000b000000000000000a7375626a6563742e4f550000000000010000000a545439464157503656340000',NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1629294900"
)
for values in "${userValuesArray[@]}"; do
    configure_user_tccdb "$values"
done
