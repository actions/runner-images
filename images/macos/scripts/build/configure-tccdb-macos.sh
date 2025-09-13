#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-tccdb-macos.sh
##  Desc:  Configure permissions to the TCC.db
################################################################################

source ~/utils/utils.sh

# /Library/Application\ Support/com.apple.TCC/TCC.db
systemValuesArray=(
    # Allow Full Disk Access for "Microsoft Defender for macOS" to bypass installation on-flight
    "'kTCCServiceAccessibility','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceAccessibility','/opt/hca/hosted-compute-agent',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,NULL,1592919552"
    "'kTCCServiceAccessibility','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServiceAccessibility','/usr/bin/osascript',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServiceAccessibility','/usr/libexec/sshd-keygen-wrapper',1,2,4,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'UNUSED',NULL,0,1644564233"
    "'kTCCServiceAccessibility','/usr/local/opt/runner/provisioner/provisioner',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,NULL,1592919552"
    "'kTCCServiceAccessibility','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServiceAccessibility','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,NULL,'UNUSED',NULL,0,1591180502"
    "'kTCCServiceAccessibility','com.apple.dt.Xcode-Helper',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1551941368"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1591532620"
    "'kTCCServiceAppleEvents','/opt/hca/hosted-compute-agent',1,2,3,1,NULL,NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','/usr/local/opt/runner/provisioner/provisioner',1,2,3,1,NULL,NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,NULL,'UNUSED',NULL,0,1591180502"
    "'kTCCServiceAppleEvents','/usr/bin/osascript',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1591532620"
    "'kTCCServiceAppleEvents','/usr/bin/osascript',1,2,0,1,NULL,NULL,0,'com.apple.Safari',NULL,NULL,1755087312"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.Safari',NULL,NULL,1755087312"
    "'kTCCServiceAppleEvents','/opt/hca/hosted-compute-agent',1,2,0,1,NULL,NULL,0,'com.apple.Safari',NULL,NULL,1755087312"
    "'kTCCServiceMicrophone','/opt/hca/hosted-compute-agent',1,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1736467200"
    "'kTCCServiceMicrophone','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/provisioner/provisioner',1,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1736467200"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServicePostEvent','/Library/Application Support/Veertu/Anka/addons/ankarund',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,0,1644565949"
    "'kTCCServicePostEvent','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321326"
    "'kTCCServicePostEvent','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321326"
    "'kTCCServiceScreenCapture','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1599831148"
    "'kTCCServiceScreenCapture','/opt/hca/hosted-compute-agent',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,0,1687786159"
    "'kTCCServiceScreenCapture','/usr/local/opt/runner/provisioner/provisioner',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,0,1687786159"
    "'kTCCServiceScreenCapture','com.devexpress.testcafe-browser-tools',0,2,3,1,X'fade0c0000000068000000010000000700000007000000080000001443fa4ca5141baeda21aeca1f50894673b440d4690000000800000014f8afcf6e69791b283e55bd0b03e39e422745770e0000000800000014bf4fc1aed64c871a49fc6bc9dd3878ce5d4d17c6',NULL,0,'UNUSED',NULL,0,1687952810"
    "'kTCCServiceSystemPolicyAllFiles','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceSystemPolicyAllFiles','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceSystemPolicyAllFiles','/usr/libexec/sshd-keygen-wrapper',1,0,4,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'UNUSED',NULL,0,1639660695"
    "'kTCCServiceSystemPolicyAllFiles','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceSystemPolicyAllFiles','com.apple.Terminal',0,2,4,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,0,'UNUSED',NULL,0,1678990068"
    "'kTCCServiceSystemPolicyAllFiles','com.microsoft.wdav',0,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,0,1643970979"
    "'kTCCServiceSystemPolicyAllFiles','com.microsoft.wdav.epsext',0,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,0,1643970979"
    "'kTCCServiceSystemPolicyNetworkVolumes','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceSystemPolicyNetworkVolumes','com.apple.Terminal',0,2,4,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,0,'UNUSED',NULL,0,1678990068"
)
for values in "${systemValuesArray[@]}"; do
    if ! is_Ventura; then
        # TCC access table in Sonoma and later has extra 4 columns: pid, pid_version, boot_uuid, last_reminded
        configure_system_tccdb "$values,NULL,NULL,'UNUSED',${values##*,}"
    else
        configure_system_tccdb "$values"
    fi
done

# $HOME/Library/Application\ Support/com.apple.TCC/TCC.db
userValuesArray=(
    "'kTCCServiceAccessibility','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceAccessibility','/usr/bin/osascript',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServiceAccessibility','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,NULL,'UNUSED',NULL,0,1591180502"
    "'kTCCServiceAppleEvents','/Library/Application Support/Veertu/Anka/addons/ankarund',1,2,3,1,NULL,NULL,0,'com.apple.Terminal',X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,1655808179"
    "'kTCCServiceAppleEvents','/Library/Application Support/Veertu/Anka/addons/ankarund',1,2,3,1,NULL,NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1629294900"
    "'kTCCServiceAppleEvents','/Library/Application Support/Veertu/Anka/addons/ankarund',1,2,3,1,NULL,NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,164456761"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.finder',NULL,NULL,1592919552"
    "'kTCCServiceAppleEvents','/bin/bash',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1591532620"
    "'kTCCServiceAppleEvents','/usr/bin/osascript',1,2,0,1,NULL,NULL,0,'com.apple.finder',NULL,NULL,1592919552"
    "'kTCCServiceAppleEvents','/usr/bin/osascript',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1591532620"
    "'kTCCServiceAppleEvents','/opt/hca/hosted-compute-agent',1,2,3,1,NULL,NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','/opt/hca/hosted-compute-agent',1,2,3,1,NULL,NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1574241374"
    "'kTCCServiceAppleEvents','/usr/libexec/sshd-keygen-wrapper',1,2,0,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1591357685"
    "'kTCCServiceAppleEvents','/usr/libexec/sshd-keygen-wrapper',1,2,3,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1644564201"
    "'kTCCServiceAppleEvents','/usr/libexec/sshd-keygen-wrapper',1,2,3,1,X'fade0c000000003c0000000100000006000000020000001d636f6d2e6170706c652e737368642d6b657967656e2d7772617070657200000000000003',NULL,0,'com.apple.Terminal',X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,1650386089"
    "'kTCCServiceAppleEvents','/usr/local/opt/runner/provisioner/provisioner',1,2,3,1,NULL,NULL,0,'com.apple.finder',X'fade0c000000002c00000001000000060000000200000010636f6d2e6170706c652e66696e64657200000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','/usr/local/opt/runner/provisioner/provisioner',1,2,3,1,NULL,NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1592919552"
    "'kTCCServiceAppleEvents','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,0,'com.apple.systemevents',NULL,NULL,1574241374"
    "'kTCCServiceAppleEvents','com.apple.Terminal',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,0,'com.apple.systemevents',X'fade0c000000003400000001000000060000000200000016636f6d2e6170706c652e73797374656d6576656e7473000000000003',NULL,1591180478"
    "'kTCCServiceMicrophone','/opt/hca/hosted-compute-agent',1,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1736467200"
    "'kTCCServiceMicrophone','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/provisioner/provisioner',1,2,4,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1736467200"
    "'kTCCServiceMicrophone','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576661342"
    "'kTCCServiceMicrophone','com.apple.CoreSimulator.SimulatorTrampoline',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1576347152"
    "'kTCCServicePostEvent','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceScreenCapture','/opt/hca/hosted-compute-agent',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,0,1687786159"
    "'kTCCServiceScreenCapture','/usr/local/opt/runner/provisioner/provisioner',1,2,4,1,NULL,NULL,0,'UNUSED',NULL,0,1687786159"
    "'kTCCServiceScreenCapture','/bin/bash',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceScreenCapture','/usr/bin/osascript',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1566321319"
    "'kTCCServiceScreenCapture','com.apple.Terminal',0,2,4,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465726d696e616c000000000003',NULL,0,'UNUSED',NULL,0,1678990068"
    "'kTCCServiceSystemPolicyAllFiles','/opt/hca/start_hca.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceSystemPolicyAllFiles','/usr/local/opt/runner/runprovisioner.sh',1,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,0,1583997993"
    "'kTCCServiceUbiquity','/System/Library/PrivateFrameworks/PhotoLibraryServices.framework/Versions/A/Support/photolibraryd',1,2,5,1,NULL,NULL,NULL,'UNUSED',NULL,0,1619461750"
    "'kTCCServiceUbiquity','com.apple.CloudDocs.MobileDocumentsFileProvider',0,2,0,1,X'fade0c000000004c0000000100000006000000020000002f636f6d2e6170706c652e436c6f7564446f63732e4d6f62696c65446f63756d656e747346696c6550726f76696465720000000003',NULL,NULL,'UNUSED',NULL,0,1570793290"
    "'kTCCServiceUbiquity','com.apple.PassKitCore',0,2,5,1,NULL,NULL,NULL,'UNUSED',NULL,0,1619516250"
    "'kTCCServiceUbiquity','com.apple.TextEdit',0,2,0,1,X'fade0c000000003000000001000000060000000200000012636f6d2e6170706c652e5465787445646974000000000003',NULL,NULL,'UNUSED',NULL,0,1566368356"
    "'kTCCServiceUbiquity','com.apple.mail',0,2,0,1,NULL,NULL,NULL,'UNUSED',NULL,NULL,1551941469"
)
for values in "${userValuesArray[@]}"; do
    if ! is_Ventura; then
        # TCC access table in Sonoma and later has extra 4 columns: pid, pid_version, boot_uuid, last_reminded
        configure_user_tccdb "$values,NULL,NULL,'UNUSED',${values##*,}"
    else
        configure_user_tccdb "$values"
    fi
done
