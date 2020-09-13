VCENTER_SERVER=$1
VCENTER_USERNAME=$2
VCENTER_PASSWORD=$3
VM_IPATH=$4

URLENCODE="image-generation/bootstrap/support/urlencode.sh"

govc vm.power -k=true \
-off=true \
-u "$VCENTER_USERNAME:`$URLENCODE "$VCENTER_PASSWORD"`@$VCENTER_SERVER" \
-vm.ipath="$VM_IPATH"

#Time to VM's shutdown
sleep 30

govc vm.destroy -k=true \
-u "$VCENTER_USERNAME:`$URLENCODE "$VCENTER_PASSWORD"`@$VCENTER_SERVER" \
-vm.ipath="$VM_IPATH"